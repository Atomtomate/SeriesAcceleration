M1 = SeriesAcceleration.build_M_matrix(1:2, [0,1])
M2 = SeriesAcceleration.build_M_matrix(1:30, [0,1,2,3,4])
@testset "build M matrix" begin
    @test all(M1 .≈ [2.0 1.5; 1.5 1.25])
    @test all(inv(inv(M2)) .≈ M2)
    @test_throws DomainError SeriesAcceleration.build_M_matrix([1,2,3], [0,1,2,3])
    @test_throws DomainError SeriesAcceleration.build_M_matrix(0:2, [0,1])
end


@testset "build weights" begin
    @test all(SeriesAcceleration.build_weights_rohringer([1,2], [0,1]) .≈ [-1 2; 2 -2]) 
    # println(SeriesAcceleration.build_weights([1,2], [0,1]))
    # println(SeriesAcceleration.build_weights_direct(1, [1,2],[1]))
    # println(SeriesAcceleration.build_weights([1,2,3,4], [0,1,2]))
    # println(SeriesAcceleration.build_weights_direct(0, [1,2,3,4],[1,2]))
    # println(SeriesAcceleration.build_weights_direct(1, [1,2,3,4],[1,2]))
    # println(SeriesAcceleration.build_weights_direct(2, [1,2,3,4],[1,2]))
    # println(SeriesAcceleration.build_weights_direct(3, [1,2,3,4],[1,2]))
end
wr = SeriesAcceleration.build_weights_rohringer(1:10, [0,1,2,3,4])
wb0 = SeriesAcceleration.build_weights_bender(1, 0:9, [1,2,3,4]);
wb1 = SeriesAcceleration.build_weights_bender(1, 1:10, [1,2,3,4]);
wb2 = SeriesAcceleration.build_weights_bender(20, 0:9, [1,2,3,4]);
wb3 = SeriesAcceleration.build_weights_bender(91, 91:100, [1,2,3,4]);

rr1 = Richardson(wr)
rb0 = Richardson(wb0)
rb1 = Richardson(wb1)
rb2 = Richardson(wb2)
rb3 = Richardson(wb3)

println(acc_csum(cS1_100,rr1))
println(acc_csum(cS1_100,rb0))
println(acc_csum(cS1_100,rb1))
println(acc_csum(cS1_100,rb2))
println(acc_csum(cS1_100,rb3))
