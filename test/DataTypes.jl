@test esum_c([1,2,3], DirectSum()) == 3
@test esum([1,2,3], DirectSum()) == 6
@test npartial_sums(DirectSum()) == 1
