println("Hello world!");

a = split("This is my first Julia code file!", ' ')

for sub in a
    print(sub)
    print('_')
end
println()


strings = "MyJulia"

for char in strings
    print(char)
end
println()

strings = "1 + 1"
println("1 + 1 = $(1 + 5)")

α, β = 1, 3
println(α + β)

function MySum(A)
    s = 0
    for a in A
        s += a
    end
    return s
end

list = [1 2 3 4 5]
println(MySum(list))

x1 = rand(2, 2) .* 3
show(x1)
println(x1)
println(x1 .+ 2)

struct MyComplex
    rea::Float64
    ima::Float64
end
a = MyComplex(1.0, 2.0)
println(a.ima)

import Base: *
import Base: show
show(x::MyComplex) = println("$(x.rea) + $(x.ima)im")
*(a::MyComplex, b::MyComplex) = MyComplex(a.rea * b.rea - a.ima * b.ima, a.rea * b.ima + a.ima * b.rea)
b = MyComplex(1, 2)
show(a * b)
