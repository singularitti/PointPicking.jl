module Disk

using RecipesBase: @recipe

export Disk, Angular, Uniform, SunflowerSpiral, sample

struct Disk
    r::Float64
end

const GOLDEN_RATIO = (√5 - 1) / 2  # Doesn't matter if its +1 or -1

abstract type Distribution end
struct Angular <: Distribution end
struct Uniform <: Distribution end
struct SunflowerSpiral <: Distribution end

function sample(::Disk, 𝐫, 𝛉, ::Angular)
    𝛉 = filter(θ -> zero(θ) <= θ <= 2 * one(θ), 𝛉)
    𝐱 = 𝐫 .* cospi.(𝛉)  # Outer product
    𝐲 = 𝐫 .* sinpi.(𝛉)
    return 𝐱, 𝐲
end
function sample(𝐫, 𝛉, ::Uniform)
    𝛉 = filter(θ -> zero(θ) <= θ <= 2 * one(θ), 𝛉)
    𝐱 = sqrt.(𝐫) .* cospi.(𝛉)  # Outer product
    𝐲 = sqrt.(𝐫) .* sinpi.(𝛉)
    return 𝐱, 𝐲
end
function sample(disk::Disk, n::Integer, ::SunflowerSpiral)  # See https://stackoverflow.com/a/44164075 & https://archive.bridgesmathart.org/2010/bridges2010-483.pdf
    𝐧 = range(zero(disk.r); length=n)
    𝐫, 𝛉 = sqrt.(𝐧), 2GOLDEN_RATIO .* 𝐧
    𝐱 = 𝐫 .* cospi.(𝛉)
    𝐲 = 𝐫 .* sinpi.(𝛉)
    return 𝐱, 𝐲
end

end
