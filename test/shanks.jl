@testset "constructor" begin
    @test Shanks(1).order == 1
    @test_throws DomainError Shanks(-1)
end

@testset "wynn epsilon" begin
    @test all(SeriesAcceleration.wynn_epsilon(cS2_100[1:2], 2)[1:2,:] .== [0 0 0; 0 cS2_100[1] cS2_100[2]])

    test_vec = [1; 0 + 1/(cS2_100[2] - cS2_100[1]); 0 + 1/(cS2_100[3] - cS2_100[2]); 0 + 1/(cS2_100[4] - cS2_100[3])]
    @test all(SeriesAcceleration.wynn_epsilon(cS2_100[1:4], 4)[3,1:4] .≈ test_vec)
end

@testset "sum" begin
end
