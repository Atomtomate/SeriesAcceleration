"""
    Richardson <: SumHelper

Desciption
-------------
Richardson method helper. This struct is initialized with a range of integers `dom`
and a list of exponents `exponents`, which are used internally. More exponents can
lead to better convergence at the cost of noise.
There are two methods available for the fitting of internal weights: `:bender`, `:rohringer`.
See C. Bender, A. Orszag 99, p. 375; G. Rohringer, A. Toschi 2016 for the derivation
Due to the different fit methods, `method=:bender` will not use 

Usage
-------------

Fields
-------------
- **`indices`**    : `AbstractVector{Int}` of indices of partial sum array which have been fitted
- **`weights`**    : `Matrix{Float64}` fit weights
"""
struct Richardson <: SumHelper
    indices::AbstractArray{Int,1}
    weights::Matrix{Float64}
    function Richardson(dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1}; method=:bender)

        method == :rohringer && (length(dom) < length(exponents)) && throw(DomainError("length of dom(=$(length(dom))) must be longer than list of exponents (=$(exponents))"))
        (0.0 in dom) && throw(DomainError("length of cumulative sum can not be smaller than 1"))
        !(0 in exponents) && throw(DomainError("0th exponent missing!"))

        if method == :bender
            exponents = ((last(dom)-length(exponents)+1) > 0) ? exponents : 0:(length(dom)-1)        # cut of unused exponents
            w = build_weights_bender(dom, exponents)
            indices = (last(dom)-length(exponents)+1):last(dom)
            !(all(exponents .== 0:(length(exponents)-1))) && throw(DomainError("exponent array and domain array can not have gaps for bender weights!"))
            (any(abs.(w[:,1]) .> 1.0e12)) && throw(OverflowError("Weights too large! Can not approximate sum over this range, due to loss of precision."))
            return new(indices, w)
        elseif method == :rohringer
            w = build_weights_rohringer(dom, exponents)
            (any(abs.(w[:,1]) .> 1.0e5)) && throw(OverflowError("Weights too large! Can not approximate sum over this range, due to loss of precision."))
            return new(dom, w)
        end
    end
end

"""
    build_M_matrix(dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})

Helper function that build the matrix ``M`` used to fit data obtained for indices
`dom` to a ``\\sum_{n\\in \\text{exponents}} c_n/i^n`` tail.

`dom` specifies the number of terms for the partial sum, that are to be fitted.
`exponents` specifies the exponents of ``\\sum_{x \\in \\text{dom}} \\sum_{p \\in \\text{exponents}} 1/i^p`` that the partial sums should be fitted to.

The coefficients ``c_n`` are obtained by solving ``M c = b``. 
``b`` can be constructed from the data using [`build_weights_rohringer`](@ref).
"""
function build_M_matrix(dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})::Array{BigFloat, 2}
    ncoeffs = length(exponents)
    M = zeros(BigFloat, (ncoeffs, ncoeffs))
    for i in dom, (ki,k) in enumerate(exponents), (li,l) in enumerate(exponents)
        M[li,ki] += 1.0 / ((BigFloat(i)^(k+l)))
    end
    return M
end

"""
    build_weights_rohringer(dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})

Build weight matrix i.e. ``W = M^{-1} R`` with M from [`build_M_matrix`](@ref)
and ``R_{kj} = \\frac{1}{j^k}``.
Fit coefficients can be obtained by multiplying `w` with data: ``a_k = W_{kj} g_j``
"""
function build_weights_rohringer(dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})::Array{Float64, 2}
    ncoeffs = length(exponents)
    w = zeros(Float64, (ncoeffs, length(dom)))
    setprecision(50000) do
        M = build_M_matrix(dom, exponents)
        Minv = inv(M)
        for k=1:ncoeffs, (li,l) = enumerate(exponents), (ji,j) = enumerate(dom)
            w[k,ji] += Float64(Minv[k, li] / (BigFloat(j)^l), RoundDown)
        end
    end
    return transpose(w)
end

"""
    build_weights_bender(dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})

Build weight matrix in closed form. See C. Bender, A. Orszag 99, p. 375. 
Fit coefficients can be obtained by multiplying `w` with data: ``a_k = W_{kj} g_j``
"""
function build_weights_bender(dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})
    ncoeffs = length(exponents)
    w = zeros(Float64, (ncoeffs, 1))
    N = BigInt(ncoeffs-1)                       # largest exponent
    nS = BigInt(first(dom))                     # starting n
    for (ki,k) = enumerate(BigInt.(exponents))
        w[ki,1] += Float64(((nS+k)^N * (2*iseven(k+N)-1))/(factorial(k)*factorial(N - k)))
    end
    return w
end

function esum_c(arr::AbstractArray{T1,1}, type::Richardson) where {T1 <: Number}
    return dot(arr, type.weights[:,1])
end

function esum(arr::AbstractArray{T1,1}, type::Richardson; csum_f::Function=cumsum) where {T1 <: Number}
    return esum_c(csum_f(arr)[type.indices], type)
end

npartial_sums(type::Richardson) = length(type.indices)
