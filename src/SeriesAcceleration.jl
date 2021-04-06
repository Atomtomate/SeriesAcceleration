module SeriesAcceleration
using LinearAlgebra

# Types
export Naive, Richardson
# Main Functions
export acc_csum
# Helper Functions
export rateOfConv

include("DataTypes.jl")
include("richardson.jl")
include("tools.jl")


"""
    acc_sum(arr::AbstractArray{T1,1}, type::T2) where {T1 <: Number, T2 <: SumHelper}

`arr` specifies a 1D array of partial sums using a method specified by `type`
"""
function acc_csum(carr::AbstractArray{T1,1}, type::T2) where {T1 <: Number, T2 <: SumHelper} 
end

end # module
