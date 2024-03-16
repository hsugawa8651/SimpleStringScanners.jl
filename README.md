# SimpleStringScanners

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://hsugawa8651.github.io/SimpleStringScanners.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://hsugawa8651.github.io/SimpleStringScanners.jl/dev/)
[![Build Status](https://github.com/hsugawa8651/SimpleStringScanners.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/hsugawa8651/SimpleStringScanners.jl/actions/workflows/CI.yml?query=branch%3Amain)


Helper for scanning fixed-length substring and parsing.

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
