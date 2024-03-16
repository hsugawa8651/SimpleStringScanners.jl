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

julia> scan=SimpleStringScanner("  2 3d-1");

julia> advance!(scan,3)
"  2"

julia> eos(scan)
false

julia> advance!(scan,5)
" 3d-1"

julia> eos(scan)
true

julia> advance!(scan,1)
ERROR: BoundsError: attempt to access 8-codeunit String at index [9]
```

```julia
julia> using SimpleStringScanners

julia> scan=SimpleStringScanner("  2 3d-1");

julia> tryparse1Int64(scan,3)
2

julia> tryparse1Float64(scan,5)
0.3

julia> eos(scan)
true
```


## See also


* class [`StringScanner`](https://docs.ruby-lang.org/en/3.3/StringScanner.html), Ruby programming language
