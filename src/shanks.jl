"""
    Shanks <: SumHelper

Desciption
-------------
Shanks method helper.

Usage
-------------

Arguments
-------------

Examples
-------------
"""
struct Shanks <: SumHelper
    order::Int
    function Shanks(order::Int)
        (order < 0) && throw(DomainError("Order can not be negative."))
        new(order)
    end
end


function wynn_epsilon(arr::AbstractArray{T,1}, order::Int) where T <: Number
    ϵ = Array{T, 2}(undef, 2*order + 2, 1 + length(arr))
    ϵ[1,:] .= zero(T)
    ϵ[2,2:end] = arr
    ϵ[2,1] = zero(T)
    for m in 3:size(ϵ,1)
        l = size(ϵ,2)-(m-2)
        ϵ[m,1:l] = ϵ[m-2,2:(l+1)] .+ 1.0 ./ (ϵ[m-1,2:(l+1)] .- ϵ[m-1,1:l])
    end
    return ϵ
end

function _shanks(arr::AbstractArray{T, 1}; atol_denom = 10*eps(Float64)) where T <: Number
    v0 = view(arr, 2:(length(arr)-1))
    vm1 = view(arr, 1:(length(arr)-2))
    vp1 = view(arr, 3:(length(arr)-0))
    denom = (vp1 .- v0) .- (v0 .- vm1)
    return any(abs.(denom) .< atol_denom) ? (vp1,true) : (vp1 .- (((vp1 .- v0) .^ 2) ./ denom),false)
end

function shanks_direct(arr::AbstractArray{T,1}, type::Shanks) where T <: Number
    arr_int = copy(arr)
    order = type.order
    order = (order == 0) ? floor(Int64,(length(arr)-1)/2) : order
    i = 0
    while i < order
        i += 1
        arr_int, conv = _shanks(arr_int)
        conv && break
    end
    return arr_int[end], i
end




"""
    build_weights_wynn(arr::AbstractArray{T1,1}) where T1 <: Number

"""
function build_weights_wynn(dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})
end

function esum_c(arr::AbstractArray{T1,1}, type::Shanks) where {T1 <: Number}
    return shanks_direct(arr, type)
end

function esum(arr::AbstractArray{T1,1}, type::Shanks; csum_f::Function=cumsum) where {T1 <: Number}
    return esum_c(csum_f(arr), type)
end
