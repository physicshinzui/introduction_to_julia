using Flux: train!
using Flux.Losses: mse

function main()
    # 1. make a dataset
    x_train, x_test = hcat(0:5...), hcat(6:10...)
    actual(x) = 4x + 2
    y_train, y_test = actual.(x_train), actual.(x_test)

    # 2. Build a model 
    model      = Flux.Dense(1,1)    # dense layer that take one input and returns one output
    parameters = Flux.params(model) # Store the model parameters 
    opt        = Flux.Descent()
    loss(x,y)  = mse(model(x), y)   # mean square error
                # ^  

    # 3. The model learns
    nepochs = 500
    data    = [(x_train, y_train)]
    objfuncvalue = Vector{Float32}(undef, nepochs)
    for i in 1:nepochs
        train!(loss, parameters, data, opt)
        @show loss(x_train, y_train)
        objfuncvalue[i] = loss(x_train, y_train)
    end
    println("Prediction: ", model(x_test))
    println("Test data : ", y_test)

    p = plot(1:nepochs, objfuncvalue, lw = 3, label = nothing)
    display(p)
end

main()