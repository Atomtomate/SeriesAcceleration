M1 = SeriesAcceleration.build_M_matrix(1:2, [0,1])
M2 = SeriesAcceleration.build_M_matrix(1:30, [0,1,2,3,4])

@testset "build M matrix" begin
    @test all(M1 .≈ [2.0 1.5; 1.5 1.25])
    @test all(inv(inv(M2)) .≈ M2)
end


@testset "build weights" begin
    @test all(SeriesAcceleration.build_weights_rohringer(1:2, 0:1) .≈ [-1 2; 2 -2]) 
    @test all(SeriesAcceleration.build_weights_bender(1:2, 0:1) .≈ [-1 -1; 2 2]) 
end

@testset "constructor" begin
    @test_throws DomainError Richardson(0:2, [0,1],method=:bender)     # starting cum. sum. at 0
    @test_throws DomainError Richardson(1:3, 1:2,method=:bender) # 0 exponent missing
    @test_throws DomainError Richardson([1,2,3], [0,1,2,3],method=:rohringer) # not enough exponents
    @test_throws DomainError Richardson(0:2, [0,1],method=:rohringer)     # starting cum. sum. at 0
    @test_throws DomainError Richardson(1:3, 1:2,method=:rohringer) # 0 exponent missing
    @test Richardson(1:1, [0,1],method=:bender).start == 1
    @test all(Richardson(1:1, [0,1],method=:bender).weights .≈ [-1, 2])
end

@testset "functional tests" begin
    # table from Bender, Orszag 99, p 377
    bender_N = [0,1,2,3,4]
    bender_sn = [1,5,10,15]
    bender_weights_res = [1.0 1.5 1.625 1.6435185185 1.6449652778;
                          1.464 1.63028 1.64416667 1.6449225246 1.6449358111;
                          1.550 1.64068 1.64480905 1.6449334030 1.6449341954;
                          1.580 1.64294 1.64489341 1.6449339578 1.6449340899]
    for (i,i_sn) in enumerate(bender_sn), (j,j_N) in enumerate(bender_N)
        r_b = Richardson(i_sn:(i_sn+j_N), 0:j_N, method=:bender)
        r_r = Richardson(i_sn:(i_sn+j_N), 0:j_N, method=:rohringer)
        @test isapprox(acc_csum(cS1_100, r_b), bender_weights_res[i,j], atol=1.0e-3)
        println("TODO: bender: $(acc_csum(cS1_100, r_b)) vs rohringer: $(acc_csum(cS1_100, r_r))")
    end
end
