module Disk

using RecipesBase: @recipe

export Angular, Uniform, Sunflower, diskpoints

GOLDEN_RATIO = (√5 - 1) / 2

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
function diskpoints(𝐫, n, ::Sunflower)
    𝛉 = GOLDEN_RATIO .* (1:n)
    𝐱 = vec([√r * cospi(θ) for r in 𝐫, θ in 𝛉])
    𝐲 = vec([√r * sinpi(θ) for r in 𝐫, θ in 𝛉])
    return 𝐱, 𝐲
end

end
