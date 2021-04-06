"""
    rateOfConv(arr:AbstractArray{T, 1})

Estimates rate of convergence ``\\alpha_n = \\frac{\\log |(x_{n+1} - x_n)/(x_n - x_{n-1})|}{\\log |(x_n - x_{n-1})/(x_{n-1}-x_{n-2})|}`` from array.
`trace` can be set to true, to obtain the roc for all partial sums.
"""
function rateOfConv(arr::AbstractArray{T,1}; trace = false) where T
    darr = diff(arr)
    full = (log.(abs.(darr[3:end] ./ darr[2:end-1])) ./ log.(abs.(darr[2:end-1] ./ darr[1:end-2])))
    return trace ? full : full[end]
end
