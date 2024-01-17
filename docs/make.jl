using PointPicking
using Documenter

DocMeta.setdocmeta!(PointPicking, :DocTestSetup, :(using PointPicking); recursive=true)

makedocs(;
    modules=[PointPicking],
    authors="singularitti <singularitti@outlook.com> and contributors",
    sitename="PointPicking.jl",
    format=Documenter.HTML(;
        canonical="https://singularitti.github.io/PointPicking.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/singularitti/PointPicking.jl",
    devbranch="main",
)
