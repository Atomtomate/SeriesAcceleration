abstract type SumHelper end

struct Naive <: SumHelper end

esum_c(carr::AbstractArray{T1,1}, type::Naive) where {T1 <: Number} = carr[end] 
esum(arr::AbstractArray{T1,1}, type::Naive) where {T1 <: Number} = sum(arr)
npartial_sums(type::Naive) = 1
