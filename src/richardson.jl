struct Richardson <: SumHelper
    weights::Matrix{Float64}
end

"""
    build_M_matrix(dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})

Helper function that build the matrix ``M`` used to fit data obtained for indices
`dom` to a ``\\sum_{n\\in exponents} c_n/i^n`` tail.

`dom` specifies the number of terms for the partial sum, that are to be fitted.
`exponents` specifies the exponents of ``\\sum_{x \\in dom} \\sum_{p in exponents} 1/i^p`` that the partial sums should be fitted to.

The coefficients ``c_n`` are obtained by solving ``M c = b``. 
``b`` can be constructed from the data using [`build_rhs`](@ref).
"""
function build_M_matrix(dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})::Array{BigFloat, 2}
    ncoeffs = length(exponents)
    if length(dom) < ncoeffs
        throw(DomainError("length of dim must be longer than exponents"))
    elseif 0.0 in dom
        throw(DomainError("length of cumulative sum can not be smaller than 1"))
    end
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
    M = build_M_matrix(dom, exponents)
    Minv = inv(M)
    ncoeffs = length(exponents)
    w = zeros(Float64, (ncoeffs, length(dom)))
    for k=1:ncoeffs, (li,l) = enumerate(exponents), (ji,j) = enumerate(dom)
        w[k,ji] += Float64(Minv[k, li] / (BigFloat(j)^l), RoundDown)
    end
    return w
end

"""
   build_weights_bender(nstart::Int, dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})

Build weight matrix in closed form. See C. Bender 99, p. 375. 
Fit coefficients can be obtained by multiplying `w` with data: ``a_k = W_{kj} g_j``
"""
function build_weights_bender(nstart::Int, dom::AbstractArray{Int,1}, exponents::AbstractArray{Int,1})
    ncoeffs = length(exponents)
    w = zeros(Float64, (ncoeffs+1, length(dom)))
    N = BigInt(ncoeffs)
    kB = BigInt.(exponents)
    nS = BigInt(nstart)

    for (ki,k) = enumerate(0:ncoeffs), (ji,j) = enumerate(dom)
        w[ki,ji] += Float64(((nS+k)^N * (2*iseven(k+N)-1))/(factorial(k)*factorial(N - k)))
    end
    return w
end

function acc_csum(arr::AbstractArray{T1,1}, type::Richardson) where {T1 <: Number}
    return dot(arr[(length(arr)-size(type.weights,2)+1):end], type.weights[1,:])
end
