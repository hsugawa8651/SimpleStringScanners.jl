using SimpleStringScanners
using Documenter

DocMeta.setdocmeta!(
    SimpleStringScanners,
    :DocTestSetup,
    :(using SimpleStringScanners);
    recursive = true,
)

makedocs(;
    modules = [SimpleStringScanners],
    authors = "Hiroharu Sugawara <hsugawa@gmail.com>",
    sitename = "SimpleStringScanners.jl",
    format = Documenter.HTML(;
        canonical = "https://hsugawa8651.github.io/SimpleStringScanners.jl",
        edit_link = "main",
        assets = String[],
    ),
    pages = [
        "Home" => "index.md", 
        "API Reference" => "reference.md"
    ],
)

deploydocs(; repo = "github.com/hsugawa8651/SimpleStringScanners.jl", devbranch = "main")
