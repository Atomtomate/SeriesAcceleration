abstract type SumHelper end

struct Naive <: SumHelper end

esum_c(carr::AbstractArray{T1,1}, type::Naive) where {T1 <: Number} = carr[end] 
