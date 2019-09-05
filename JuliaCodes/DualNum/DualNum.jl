module DualNum

struct Dual{T} <: Number
    a::T
    da::T
end

Base.:+(x::Dual, y::Dual) = Dual(x.a + y.a, x.da + y.da)
Base.:-(x::Dual) = Dual(-x.a, -x.da)
Base.:-(x::Dual, y::Dual) = x + (-y)
Base.:*(x::Dual, y::Dual) = Dual(x.a * y.a, x.a * y.da + x.da * y.a)
Base.:/(x::Dual, y::Dual) = Dual(x.a / y.a, (x.da * y.a - x.a * y.da) / y.da ^ 2)

Base.show(io::IO, x::Dual) = print(io, x.a, "+", x.da, "ϵ")
Base.promote_rule(::Type{Dual{T}}, ::Type{S}) where {T <: Number, S <: Number} = Dual{promote_type(S, T)}
Dual{T}(x) where T <: Number = Dual{T}(x, zero(T))
Float64(x::Dual) = Dual(Float64(x.a), Float64(x.da))

end
