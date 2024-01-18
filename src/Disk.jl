module Disk

using RecipesBase: @recipe

export Angular, Uniform, Sunflower, diskpoints

const GOLDEN_RATIO = (√5 - 1) / 2  # Doesn't matter if its +1 or -1

abstract type Distribution end
struct Angular <: Distribution end
struct Uniform <: Distribution end
struct Sunflower <: Distribution end

function diskpoints(𝐫, 𝛉, ::Angular)
    𝛉 = filter(θ -> zero(θ) <= θ <= 2 * one(θ), 𝛉)
    𝐱 = vec([r * cospi(θ) for r in 𝐫, θ in 𝛉])
    𝐲 = vec([r * sinpi(θ) for r in 𝐫, θ in 𝛉])
    return 𝐱, 𝐲
end
function diskpoints(𝐫, 𝛉, ::Uniform)
    𝛉 = filter(θ -> zero(θ) <= θ <= 2 * one(θ), 𝛉)
    𝐱 = vec([√r * cospi(θ) for r in 𝐫, θ in 𝛉])
    𝐲 = vec([√r * sinpi(θ) for r in 𝐫, θ in 𝛉])
    return 𝐱, 𝐲
end
function diskpoints(𝐫, ::Sunflower)  # See https://stackoverflow.com/a/44164075
    𝛉 = GOLDEN_RATIO .* (range(0; length=length(𝐫)) .+ 0.5)
    𝐱 = 𝐫 .* cospi.(2𝛉)
    𝐲 = 𝐫 .* sinpi.(2𝛉)
    return 𝐱, 𝐲
end

end
