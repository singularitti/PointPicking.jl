module Disks

using Distributions: Uniform as UniformDist
using RecipesBase: @recipe

export Disk, Polar, Uniform, SunflowerSpiral, sample, random

struct Disk
    r::Float64
end

const GOLDEN_RATIO = (√5 - 1) / 2  # Doesn't matter if its +1 or -1

abstract type Distribution end
struct Polar <: Distribution end
struct Uniform <: Distribution end
struct SunflowerSpiral <: Distribution end

# See https://mathworld.wolfram.com/DiskPointPicking.html
function sample(disk::Disk, ::Polar, n::Integer, m::Integer=n)
    𝐫 = range(zero(disk.r); stop=disk.r, length=n)
    𝛉 = range(0; stop=2, length=m)  # 0 to 2π
    𝐱 = vec(𝐫 .* cospi.(𝛉)')  # Outer product
    𝐲 = vec(𝐫 .* sinpi.(𝛉)')
    return 𝐱, 𝐲
end
function sample(disk::Disk, ::Uniform, n::Integer, m::Integer=n)
    𝐫 = range(zero(disk.r); stop=disk.r, length=n)
    𝛉 = range(0; stop=2, length=m)  # 0 to 2π
    sqrt𝐫 = sqrt.(𝐫)
    𝐱 = vec(sqrt𝐫 .* cospi.(𝛉)')  # Outer product
    𝐲 = vec(sqrt𝐫 .* sinpi.(𝛉)')
    return 𝐱, 𝐲
end
function sample(disk::Disk, ::SunflowerSpiral, n::Integer)  # See https://stackoverflow.com/a/44164075 & https://archive.bridgesmathart.org/2010/bridges2010-483.pdf
    𝐧 = range(zero(disk.r); length=n)
    𝐫, 𝛉 = disk.r .* sqrt.(𝐧 ./ n), 2GOLDEN_RATIO .* 𝐧  # Make radius right
    𝐱 = 𝐫 .* cospi.(𝛉)
    𝐲 = 𝐫 .* sinpi.(𝛉)
    return 𝐱, 𝐲
end

function random(disk::Disk, ::Polar, n::Integer)
    𝐫 = rand(UniformDist(zero(disk.r), disk.r), n)
    𝛉 = rand(UniformDist(0, 2π), n)
    𝐱 = 𝐫 .* cospi.(𝛉)  # Outer product
    𝐲 = 𝐫 .* sinpi.(𝛉)
    return 𝐱, 𝐲
end
function random(disk::Disk, ::Uniform, n::Integer)
    𝐫 = rand(UniformDist(zero(disk.r), disk.r), n)
    𝛉 = rand(UniformDist(0, 2π), n)
    sqrt𝐫 = sqrt.(𝐫)
    𝐱 = sqrt𝐫 .* cospi.(𝛉)  # Outer product
    𝐲 = sqrt𝐫 .* sinpi.(𝛉)
    return 𝐱, 𝐲
end

end
