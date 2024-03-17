```@meta
CurrentModule = SimpleStringScanners
```

# SimpleStringScanners

Documentation for [SimpleStringScanners](https://github.com/hsugawa8651/SimpleStringScanners.jl).


## Installation

Install this package with `Pkg.add("SimpleStringScanners")`

# Quick start

```julia
julia> using SimpleStringScanners

julia> scanner=SimpleStringScanner("  2 3d-1");

julia> advance!(scanner,3)
"  2"

julia> eos(scanner)
false

julia> advance!(scanner,5)
" 3d-1"

julia> eos(scanner)
true

julia> advance!(scanner,1)
ERROR: BoundsError: attempt to access 8-codeunit String at index [9]
```

```julia
julia> using SimpleStringScanners

julia> scanner=SimpleStringScanner("  2 3d-1");

julia> tryparse1Int64(scanner,3)
2

julia> tryparse1Float64(scanner,5)
0.3

julia> eos(scanner)
true
```

```julia
julia> using SimpleStringScanners

julia> scanner=SimpleStringScanner(" 12 34");

julia> tryparse1Int64(scanner, r"\d+")
12

julia> tryparse1Int64(scanner, r"\d+")
34

julia> eos(scan)
true
```


## See also


* class [`StringScanner`](https://docs.ruby-lang.org/en/3.3/StringScanner.html), Ruby programming language
