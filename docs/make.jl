using SeriesAcceleration
using Documenter

push!(LOAD_PATH, "../src")
makedocs(;
    modules=[SeriesAcceleration],
    authors="Julian Stobbe <Atomtomate@gmx.de> and contributors",
    repo="https://github.com/Atomtomate/SeriesAcceleration.jl/blob/{commit}{path}#L{line}",
    sitename="Series Acceleration",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", nothing) == "true",
        canonical="https://Atomtomate.github.io/SeriesAcceleration.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    branch="gh-pages",
    devbranch = "master",
    devurl = "stable",
    repo="github.com/Atomtomate/SeriesAcceleration.jl.git",
)

