abstract type SumHelper end

struct Naive <: SumHelper end

acc_csum(carr::AbstractArray{T1,1}, type::Naive) where {T1 <: Number} = carr[end] 
