using Statistics, LinearAlgebra

function negSquareEucDists(X)
    sumX = sum(X .^ 2, dims = 2)
    Dist = sumX .+ (sumX .- 2 * X * X')'
    -Dist
end

function softmax(D, diag_zero = true)
    ex = exp.(D .- maximum(D, dims = 2))
    if diag_zero 
        for i in 1:minimum(size(D))
            ex[i, i] = 0
        end
    end
    ex .+= 1e-18
    ex ./ sum(ex, dims = 2)
end

function calcProbMatrix(D, σ = nothing)
    if σ != nothing
        P = softmax(D ./ reshape(σ, :, 1))
    else
        P = softmax(D)
    end
    P
end

function calcPerp(P)
    H = -sum(P .* log2.(P), dims = 2)
    perp = 2 .^ (H)
end

function Perplexity(D, σ)
    calcPerp(calcProbMatrix(D, σ))
end

function binarySearch(D, target, tol = 1e-10, maxIter = 1e4, lower = 1e-20, upper = 1e3)
    lower = ones(size(D)[1]) * lower
    upper = ones(size(D)[1]) * upper
    mid = zeros(size(D)[1])
    for iter in 1:maxIter
        for i in 1:size(D)[1] 
            mid[i] = (lower[i] + upper[i]) / 2 
        end
        perp = Perplexity(D, mid)
        lower = ifelse.(perp .< target, mid, lower)
        upper = ifelse.(perp .>= target, mid, upper)
        if maximum(abs.(perp .- target)) <= tol
            break
        end
    end
    mid
end

X1 = randn(100, 10)
X2 = randn(100, 10) .+ 1
X = [X1; X2]
D = negSquareEucDists(X)
σ = binarySearch(D, 30)