@testset "rate of convergence" begin
    @test typeof(rateOfConv(S1_100)) === Float64
    @test rateOfConv(S1_100) < 1.0
    @test rateOfConv(geom(0.5,100)) < 1.1
end
