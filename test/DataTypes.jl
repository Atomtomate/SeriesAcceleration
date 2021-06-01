@test esum_c([1,2,3], Naive()) == 3
@test esum([1,2,3], Naive()) == 6
@test npartial_sums(Naive()) == 1
