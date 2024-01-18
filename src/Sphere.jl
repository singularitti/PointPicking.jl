export Angular,
    Uniform, Marsaglia, Gaussian, Fibonacci, spherical_coordinates, surfacepoints

abstract type Distribution end
struct Angular <: Distribution end
struct Uniform <: Distribution end
struct Marsaglia <: Distribution end
struct Cook <: Distribution end
struct Gaussian <: Distribution end
struct Fibonacci <: Distribution end

const GOLDEN_RATIO = (√5 - 1) / 2

function spherical_coordinates(r, θ, ϕ)
    x = r * sinpi(ϕ) * cospi(θ)
    y = r * sinpi(ϕ) * sinpi(θ)
    z = r * cospi(ϕ)
    return x, y, z
end

function surfacepoints(𝛉, 𝛟, ::Angular)
    𝛉 = filter(θ -> zero(θ) <= θ <= 2 * one(θ), 𝛉)
    𝛟 = filter(ϕ -> zero(ϕ) <= ϕ <= one(ϕ), 𝛟)
    x = [cospi(θ) * sinpi(ϕ) for ϕ in 𝛟, θ in 𝛉]
    y = [sinpi(θ) * sinpi(ϕ) for ϕ in 𝛟, θ in 𝛉]
    z = [cospi(ϕ) for ϕ in 𝛟, _ in 𝛉]
    return x, y, z
end
function surfacepoints(𝛉, cos𝛟, ::Uniform)
    𝛉 = filter(θ -> zero(θ) <= θ <= 2 * one(θ), 𝛉)
    cos𝛟 = filter(cosϕ -> zero(cosϕ) <= abs(cosϕ) <= one(cosϕ), cos𝛟)
    x = [√(1 - cosϕ^2) * cospi(θ) for cosϕ in cos𝛟, θ in 𝛉]
    y = [√(1 - cosϕ^2) * sinpi(θ) for cosϕ in cos𝛟, θ in 𝛉]
    z = [cosϕ for cosϕ in cos𝛟, _ in 𝛉]
    return x, y, z
end
function surfacepoints(𝐱₁, 𝐱₂, ::Marsaglia)
    params = Iterators.filter(𝐱 -> 𝐱[1]^2 + 𝐱[2]^2 < 1, Iterators.product(𝐱₁, 𝐱₂))
    x = [2 * x₁ * √(1 - x₁^2 - x₂^2) for (x₁, x₂) in params]
    y = [2 * x₂ * √(1 - x₁^2 - x₂^2) for (x₁, x₂) in params]
    z = [1 - 2 * (x₁^2 + x₂^2) for (x₁, x₂) in params]
    return x, y, z
end
function surfacepoints(𝐱, 𝐲, 𝐳, ::Gaussian)
    x = [x / √(x^2 + y^2 + z^2) for (x, y, z) in zip(𝐱, 𝐲, 𝐳)]
    y = [y / √(x^2 + y^2 + z^2) for (x, y, z) in zip(𝐱, 𝐲, 𝐳)]
    z = [z / √(x^2 + y^2 + z^2) for (x, y, z) in zip(𝐱, 𝐲, 𝐳)]
    return x, y, z
end
function surfacepoints(n, ::Fibonacci)
    z = [(2i - 1) / n - 1 for i in 1:n]
    x = [√(1 - z[i]^2) * cospi(2i * GOLDEN_RATIO) for i in 1:n]
    y = [√(1 - z[i]^2) * sinpi(2i * GOLDEN_RATIO) for i in 1:n]
    return x, y, z
end
