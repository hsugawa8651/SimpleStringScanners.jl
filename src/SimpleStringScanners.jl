module SimpleStringScanners

@doc """
    SimpleStringScanner

type for SimpleStringScanner
"""
mutable struct SimpleStringScanner
    const text::String
    start::Int64
    SimpleStringScanner(str::String) = new(str, 1)
end

@doc """
    eos(scanner::SimpleStringScanner) -> Bool

Tests end-of-string.
"""
function eos(scanner::SimpleStringScanner)
    try
        nextind(scanner.text, scanner.start, 0)
    catch BoundsError
        return true
    end
    return false
end

@doc """
    advance!(scanner::SimpleStringScanner, width::Integer) -> SubString

Advances the inner pointer of `scanner` by `width` codeunits, and returns scanned substring.
"""
function advance!(scanner::SimpleStringScanner, width::Integer)
    @assert width > 0
    start = stop = thisind(scanner.text, scanner.start)
    for _ = 1:width
        stop = nextind(scanner.text, stop)
    end
    scanner.start = stop
    return SubString(scanner.text, start, stop - 1)
end

@doc """
    scan!(scanner::SimpleStringScanner, r::Regex, add_opts)

Search for the first match of the regular expression `r` in `s` from the pointer `scan.start`, advances the pointer to the next code of the match, and returns a RegexMatch object containing the match.
Returns `nothing` if the match failed.
"""
function scan!(scanner::SimpleStringScanner, r::Regex, add_opts::UInt32 = UInt32(0))
    start = thisind(scanner.text, scanner.start)
    m = match(r, scanner.text, start, add_opts)
    isnothing(m) && (return m)
    start = m.offset
    for _ = 1:length(m.match)
        start = nextind(scanner.text, start)
    end
    scanner.start = start
    return m
end

export SimpleStringScanner, advance!, eos, scan!

import Base: parse, tryparse

# parse1, tryparse1
for func in (:parse, :tryparse)
    func1 = Symbol(String(func) * "1")
    @eval begin
        @doc """
            $($func1)(type::Type, str::AbstractString; base...)

        Variant of `Base.$($func)` that can handle  Fortran's floating point numbers whose exponent part starts with `d` character.
        Substitutes `d` and `D` in `str` by `e`'s, and then invokes `Base.$($func)`.
        """
        function $func1(t::Type, str::AbstractString; base...)
            str1 = replace(str, r"d"i => "e")
            $func(t, str1; base...)
        end
        export $func1
    end
end

# Extention to SimpleStringScanner
for func in (:parse, :tryparse, :parse1, :tryparse1)
    @eval begin
        @doc """
            $($func)(type::Type, s::SimpleStringScanner, width::Integer; base...)

        Equivalent to 
        - `str = advance!(scanner, width); $($func)(type, str; base)`
        """
        $func(type::Type, scanner::SimpleStringScanner, width::Integer; base...) =
            @inline $func(type, advance!(scanner, width); base...)

        @doc """
            $($func)(type::Type, scanner::SimpleStringScanner, r::Regex, add_opts::UInt32=UInt32(0); base)

        Equivalent to 
        - `m = scan!(scanner, r, add_opts); $($func)(type, m.match; base)`
        """
        function $func(
            type::Type,
            scanner::SimpleStringScanner,
            r::Regex,
            add_opts::UInt32 = UInt32(0);
            base...,
        )
            m = scan!(scanner, r, add_opts)
            isnothing(m) && (return nothing)
            return $func(type, m.match; base...)
        end
    end
end

# `parseInt64` ...
for func in (:parse, :tryparse, :parse1, :tryparse1)
    for t in (
        Bool,
        Int8,
        Int16,
        Int32,
        Int64,
        Int128,
        BigInt,
        UInt8,
        UInt16,
        UInt32,
        UInt64,
        UInt128,
        Float16,
        Float32,
        Float64,
        BigFloat,
    )
        funcT = Symbol(String(func) * string(t))
        @eval begin
            function $funcT end
            @doc """
                $($funcT)(str::AbstractString; base...)

            Equivalent to 
                - `$($func)($($t), str; base...)`
            """
            @inline $funcT(s::AbstractString; base...) = $func($t, s; base...)

            @doc """
                $($funcT)(scanner::SimpleStringScanner, width::Integer; base...)

            Equivalent to 
            - `$($func)($($t), scanner, width; base...)`, i.e.,
            - `str=advance!(scanner, width); $($func)($($t), str; base...)`.
            """
            @inline $funcT(s::SimpleStringScanner, w::Integer; base...) =
                $func($t, s, w; base...)

            @doc """
                $($funcT)(scanner::SimpleStringScanner, r::Regex, add_opts; base...)

            Equivalent to 
            - `$($func)($($t), scanner, r, add_opts; base...)`, i.e.,
            - `m=scan!(scanner, r, add_opts); $($func)($($t), m.match; base...)`.
            """
            @inline $funcT(
                s::SimpleStringScanner,
                r::Regex,
                add_opts::UInt32 = UInt32(0);
                base...,
            ) = $func($t, s, r, add_opts; base...)

            export $funcT
        end
    end
end

end # SimpleStringScanners

