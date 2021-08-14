using Flux
using Flux.Losses: mse
using Plots 
using ProgressMeter

function getdata()
    # Make a dataset 
    actual(x) = 4x + 2
    x_train, x_test = hcat(0:5...), hcat(6:10...)       # Suppose we have 11 data points.
    y_train, y_test = actual.(x_train), actual.(x_test) # For each point, we have a value. 
    return [(x_train, y_train)], [(x_test, y_test)]
end

function mdoelbuilder()
    # Build a model to make prediction
    model    = Dense(1,1)         # dense layer, which takes one input and returns one output
    loss(x, y) = mse(model(x), y) # mean square error is used as a loss function.
 
    # Select an optimizer
    opt = Descent() #Stochastic gradient descent? 

    # Store parameters in Flux.params
    parameters = Flux.params(model)

    return (model, loss, opt, parameters)
end

function modellearns(traindata, nepochs)
    model, loss, opt, parameters = mdoelbuilder()

    # train the model.
    objs = []
    @showprogress 1 "Learning..." for epoch in 1:nepochs
    # parameters and loss function are updated along the way.
        Flux.train!(loss, parameters, traindata, opt)
        push!(objs, loss(traindata[1][1], traindata[1][2]))
    end

    p = plot(1:nepochs, objs, lw = 3, label = "Mean square error")
    display(p)
    return model
end

function main()
    traindata, testdata = getdata()
    println(traindata)
    model = modellearns(traindata, 1)
    x_train = traindata[1][1]
    y_test  = testdata[1][2] 
    prediction = model(x_train)
    println("Prediction : $prediction")
    println("Test data  : $y_test")
end

main()