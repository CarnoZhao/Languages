using MLDatasets, LinearAlgebra, Statistics, Images, PyPlot, Random

train_x, train_y = MNIST.traindata(Float64)
test_x, test_y = MNIST.testdata(Float64)
;

relu(x) = max(0, x)
sigmoid(x) = 1 / (1 + exp(-x))
relu_derivative(y) = ifelse(y > 0, 1, 0)
sigmoid_derivative(y) = y * (1 - y)

function random_initialization(layer_dims)
    parameters = []
    L = length(layer_dims) - 1
    for i in 1:L
        W = randn(layer_dims[i + 1], layer_dims[i]) * sqrt(2 / layer_dims[i])
        b = zeros(layer_dims[i + 1])
        push!(parameters, [W, b])
    end
    parameters
end

function moment_initialization(parameters)
    V = []
    for (W, b) in parameters
        vdW = zeros(size(W))
        vdb = zeros(size(b))
        push!(V, [vdW, vdb])
    end
    S = deepcopy(V)
    V, S
end

function batch_data(X, Y, batch_size)
    m = size(X)[2]
    shuffle_X = X[:, shuffle(1:m)]
    shuffle_Y = Y[:, shuffle(1:m)]
    batches = []
    k = Int(floor(m // batch_size))
    for i in 1:k
        mini_X = shuffle_X[:, ((k - 1) * batch_size + 1):ifelse(i == k, m, (k * batch_size))]
        mini_Y = shuffle_Y[:, ((k - 1) * batch_size + 1):ifelse(i == k, m, (k * batch_size))]
        push!(batches, [mini_X, mini_Y])
    end
    batches
end

function forward(X, parameters)
    caches = [X]
    A = X
    for (i, (W, b)) in enumerate(parameters)
        Z = W * A .+ b
        A = ifelse(i == length(parameters), sigmoid.(Z), relu.(Z))
        push!(caches, A)
    end
    caches
end

function backward(Y, parameters, caches, V, S, beta1, beta2)
    L = length(parameters)
    m = size(Y)[2]
    AL = caches[length(caches)]
    dA = (AL - Y) ./ (AL .* (1 .- AL))
    for i in L:-1:1
        A, A_prev, W = caches[i + 1], caches[i], parameters[i][1]
        dZ = dA .* ifelse(i == L, sigmoid_derivative.(A), relu_derivative.(A))
        dW = dZ * A_prev' / m
        db = mean(dZ, dims = 2)
        dA = W' * dZ
        V[i][1] = beta1 * V[i][1] + (1 - beta1) * dW
        V[i][2] = beta1 * V[i][2] + (1 - beta1) * db
        S[i][1] = beta2 * S[i][1] + (1 - beta2) * dW .^ 2
        S[i][2] = beta2 * S[i][2] + (1 - beta2) * db .^ 2
    end
    V, S
end

function update_parameters(V, S, epsilon, parameters, learning_rate)
    L = length(parameters)
    for i in 1:L
        parameters[i][1] -= learning_rate * V[i][1] ./ (sqrt.(S[i][1]) .+ epsilon)
        parameters[i][2] -= learning_rate * V[i][2] ./ (sqrt.(S[i][2]) .+ epsilon)
    end
    parameters
end

function compute_cost(AL, Y)
    cost = -mean(Y .* log.(AL) + (1 .- Y) .* log.(1 .- AL))
    cost
end

function predict(X, parameters)
    caches = forward(X, parameters)
    AL = caches[length(caches)]
    num = reshape(argmax(AL, dims = 1), :, 1)
    num
end

function network(X, Y, layer_dims; num_iterations = 30000, batch_size = 64, learning_rate = 0.0075, beta1 = 0.9, beta2 = 0.999, epsilon = 1e-8)
    parameters = random_initialization(layer_dims)
    V, S = moment_initialization(parameters)
    for i in 1:num_iterations
        cost = 0
        batches = batch_data(X, Y, batch_size)
        for (mini_X, mini_Y) in batches
            caches = forward(mini_X, parameters)
            cost += compute_cost(caches[length(caches)], mini_Y)
            V, S = backward(mini_Y, parameters, caches, V, S, beta1, beta2)
            parameters = update_parameters(V, S, epsilon, parameters, learning_rate)
        end
        if i % 100 == 0
            println("Cost after $(i) iterations: $(round(cost, digits = 4))")
        end
    end
    parameters
end

function main(train_x, train_y, test_x, test_y; train_size = 600, test_size = 100, num_iterations = 30000, batch_size = 64, learning_rate = 0.0075, beta1 = 0.9, beta2 = 0.999, epsilon = 1e-8)
    train_x = reshape(train_x, :, size(train_x)[length(size(train_x))])[:, 1:train_size]
    train_y_num = reshape(train_y[1:train_size], :, 1)
    train_y = [ifelse(i == y, 1, 0) for y in train_y for i in 0:9]
    train_y = reshape(train_y, 10, :)[:, 1:train_size]
    test_x = reshape(test_x, :, size(test_x)[length(size(test_x))])[:, 1:test_size]
    test_y_num = reshape(test_y[1:test_size], :, 1)
    test_y = [ifelse(i == y, 1, 0) for y in test_y for i in 0:9]
    test_y = reshape(test_y, 10, :)[:, 1:test_size]
    layer_dims = [size(train_x)[1], 20, 15, size(train_y)[1]]
    parameters = network(train_x, train_y, layer_dims, num_iterations = num_iterations, batch_size = batch_size, learning_rate = learning_rate, beta1 = beta1, beta2 = beta2, epsilon = epsilon)
    pred_train_y = predict(train_x, parameters)
    pred_test_y = predict(test_x, parameters)
    println("Train accuracy: $(round(mean(pred_train_y .== train_y_num) * 100, digits = 3))%")
    println("Test accuracy: $(round(mean(pred_test_y .== test_y_num) * 100, digits = 3))%")
    parameters
end

parameters = main(train_x, train_y, test_x, test_y)      