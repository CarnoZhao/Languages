using LinearAlgebra
using Random
Random.seed!(0)

A = rand(-3:3, 4, 4)

function printa(A::Array)
    l = size(A)[1]
    for i = 1:l println(join(round.(A[i,:], digits = 2), ' ')) end
    println()
end

β = rand(1:9, 4)

printa(A)
E₄ = Matrix{Int}(I, size(A))

## A = QR, 正交矩阵Q，上三角矩阵R
qr_result = qr(A)
Q, R = Array(qr_result.Q), qr_result.R
println("A = QR, \nQ × Qᵀ - E₄ = ")
printa(round.(Q * Q' - E₄, digits = 1))

## A求逆
println("|A| = $(det(A))")
inv_A = inv(A)
println("A⁻¹ × A - E₄ =")
printa(round.(inv_A * A - E₄, digits = 1))

## 最小二乘解
println("AX = β, \n, then X = ")
X = 
printa(A \ β)