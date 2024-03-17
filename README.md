# SimpleStringScanners

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://hsugawa8651.github.io/SimpleStringScanners.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://hsugawa8651.github.io/SimpleStringScanners.jl/dev/)
[![Build Status](https://github.com/hsugawa8651/SimpleStringScanners.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/hsugawa8651/SimpleStringScanners.jl/actions/workflows/CI.yml?query=branch%3Amain)


Helper for scanning fixed-length substring and parsing.

# Quick start

```julia
julia> using SimpleStringScanners

julia> scanner=SimpleStringScanner("  2 3d-1");

julia> advance!(scanner,3)
"  2"

julia> advance!(scanner,5)
" 3d-1"
```

```julia
julia> using SimpleStringScanners

julia> scanner=SimpleStringScanner("  2 3d-1");

julia> tryparse1Int64(scanner,3)
2

julia> tryparse1Float64(scanner,5)
0.3
```

```julia
julia> using SimpleStringScanners

julia> scanner=SimpleStringScanner(" 12 34");

julia> tryparse1Int64(scanner, r"\d+")
12

julia> tryparse1Int64(scanner, r"\d+")
34
```