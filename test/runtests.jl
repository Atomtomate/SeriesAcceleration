using SeriesAcceleration
using Test

# Example Series
S1_100 = 1 ./ (1:100) .^ 2               # ζ(2) = π²/6
S1_500 = 1 ./ (1:500) .^ 2              
S2_100 = [(1/π^2) for n in 1:100]               # ζ(2) = π²/6
geom(q, n) = [q^k for k in 0:n]
lim_geom(q,n) = ((1 - q^(n+1))/(1-q), 1/(1-q))

# cumulative sums
cS1_100 = cumsum(S1_100)
cS1_500 = cumsum(S1_500)


@testset "naive" begin
    include("./DataTypes.jl")
end
@testset "richardson" begin
    include("./richardson.jl")
end
@testset "shanks" begin
    include("./shanks.jl")
end
@testset "tools" begin
    include("./tools.jl")
end


@testset "convergence tests" begin
    #@testset "richardson" begin
#
#    end
end
