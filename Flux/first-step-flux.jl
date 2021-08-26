### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ f35d060b-6ede-4988-8071-c6ead80cc1cd
begin
	using Pkg
	Pkg.activate(".")
	using PlutoUI
	with_terminal() do 
		Pkg.status()
		println()
		versioninfo()
	end
end

# ╔═╡ 284fc078-6703-459f-9a33-fdc027912102
begin 
	using Flux
	using Flux.Data: DataLoader
 	using Flux: onehotbatch, onecold, @epochs
 	using Flux.Losses: logitcrossentropy
	using Flux: onehotbatch #  batch (matrix) of one-hot vectors
	using MLDatasets: MNIST
	using Plots
end

# ╔═╡ 937b2892-046c-11ec-38f6-7b359f56c76e
md"""
# The first step for deep learning with Flux.
- Date: 24.8.2021
- Date: 25.8.2021

This notebook gives a tutorial of a neutral network.
- Load MNIST dataset.
- Define affine layers
- Define an activation function

"""

# ╔═╡ fa0ccf38-fa7d-4a1e-8561-6bee290a8364
TableOfContents()

# ╔═╡ dcd36616-ddfe-4ef6-8ae6-820374406284
md"""
## Load and View MNIST dataset

!!! note "MNIST dataset"
	Train data: 28 $\times$ 28 $\times$ 60000; i.e., 60000 images each of which consists of 28 $\times$ 28 pixcels. 

	Test data : 28 $\times$ 28 $\times$ 10000; i.e., 10000 images each of which consists of 28 $\times$ 28 pixcels.
28 $\times$ 28
"""

# ╔═╡ decf4a47-80e0-4791-bb98-f12f41f32a81
begin
	train_x, train_y = MNIST.traindata(Float32)
	@show size(train_x), size(train_y)
end

# ╔═╡ 8132e2b2-5319-4995-a047-3863e575cf08
begin 
	test_x, test_y = MNIST.testdata(Float32)
	@show size(test_x), size(test_y)
end

# ╔═╡ 06da8206-3894-46b3-9016-ce6ddab45382
md"""
#### A slide bar is given below so that you can visualize each data (from `train_x[1]` to `train_x[10]`) in MNIST dataset:

Index of train_x : 1 $(@bind n PlutoUI.Slider(1:10)) 10

"""

# ╔═╡ ec8a0478-54d4-4088-b174-0304c5cc798b
md"""
#### Index: train_x[$n]

#### label: $(train_y[n])
"""

# ╔═╡ 7e37814f-116a-45e5-9295-949693aed8db
md"""

!!! note
	Check if each image is expressed by the heatmap below. 
"""

# ╔═╡ 3b080741-1386-43b1-9efc-4a3edfc4e09b
heatmap(train_x[:,:,n])

# ╔═╡ 8ddfa7d3-86e1-4dea-9dc5-6e4117df0b3f
md"""
## Reshape MNIST dataset
To give the matrix of MNIST dataset to your model, it would be necessary to reshape it so that our input layer can take the matrix. 
In the case of MNIST dataset, we can pass an image (28 $\times$ 28 $\times$ 1 matrix) to the input layer. we must reshape train_x and test_x into 
suppose that your neutral network model takes an input as 10-element array. Then we have to 
"""

# ╔═╡ cad5bea4-33bf-45c7-ae03-e3cda9d934aa
md"""
### Flatten train data matrix

Flatten does:
- 28 $\times$ 28 $\times$ 60000 matrix $\to$ 784 $\times$ 60000
- 28 $\times$ 28 $\times$ 60000 matrix $\to$ 784 $\times$ 10000

!!! note "Why flatten?"
	Our simple multilayer perceptron is expected to feed images expressed by a one-dimensional array, whose length is 784. So, we convert 28 $\times$ 28 to 784.  

"""

# ╔═╡ e159a25b-a68f-468b-97f6-12f786b5aba9
train_x_flatten = Flux.flatten(train_x)

# ╔═╡ 8c3e11e2-9cd0-47e9-b636-30a047960430
test_x_flatten = Flux.flatten(test_x)

# ╔═╡ cf09c249-1980-4385-9c95-a625eb221d9e
md"""
### One-hot representation
We convert the label vector to a one-hot vector here. 
One-hot representation is the way to convert labels to numbers that can be fed to ML models. 
!!! note "Why one-hot?" 
	One-hot represnetation allows a machine learning model to handle categorical data. 
"""

# ╔═╡ 68e5d150-4b02-45c0-b1b1-a56f3b26f2b9
train_y_onehot, test_y_onehot = onehotbatch(train_y, 0:9), onehotbatch(test_y, 0:9)

# ╔═╡ 1e6d49de-882e-4832-89fd-d737025a4d9f
md"""
#### What does this do? 

Suppose a vector [1, 3, 2] where the range is 1:3. 
If this is convered to a hot vector, then it would be: 

- [1, 0, 0] # for 1
- [0, 0, 1] # for 3
- [0, 1, 0] # for 2

!!! note 
	One label, one hot vector

"""

# ╔═╡ a6176614-abff-4a9d-a718-74c963d49410
with_terminal() do 
	@show train_y[1]
	@show train_y_onehot[:,1]
	@show length(train_y_onehot[:,1]) #0 to 9
	@show size(train_y_onehot)
end

# ╔═╡ a980d7ee-5d4f-4597-ad0a-2ad11342252b
md"""
### DataLoader
"""

# ╔═╡ 6a8822ef-a554-40c3-a8f0-e19f761c086b
begin
	batchsize = 256
	train_loader = DataLoader((train_x_flatten, train_y_onehot), 
							   batchsize=batchsize, shuffle=true)
	test_loader = DataLoader((test_x_flatten, test_y_onehot), batchsize=batchsize)
end

# ╔═╡ f2f9b086-5a2a-4e4c-963e-5a76c8dbdd01
md"""
## Buid a model
"""

# ╔═╡ 6e3a36b2-58c2-450a-954b-d1469533e3f0
begin 
	imgsize=(28,28,1)
	nclasses=10
	model = Chain( Dense(prod(imgsize), 32, relu), 
		           Dense(32, nclasses), softmax
				 )
end

# ╔═╡ 400ac9bb-c7d6-497a-b6a1-8b795802b85b
ps = Flux.params(model)

# ╔═╡ 0ea08fa7-7338-4100-a585-4befffb65eb0
begin 
	η = 3e-4 
	opt = ADAM(η)
end

# ╔═╡ 0a7d1f6d-8ece-4fdf-ba46-fdea99a874be
 function loss_and_accuracy(data_loader, model)
     acc = 0
     ls = 0.0f0
     num = 0
     for (x, y) in data_loader
         ŷ = model(x)
         ls += logitcrossentropy(model(x), y, agg=sum)
         acc += sum(onecold(cpu(model(x))) .== onecold(cpu(y)))
         num +=  size(x, 2)
     end
     return ls / num, acc / num
 end

# ╔═╡ 0b1786b7-1602-4801-a2cb-f89812632e6c
md"""
## Training 
"""

# ╔═╡ 97927f76-03d3-4e58-a84b-f29cc5a7e72d
begin
	epochs = 20
	loss_train = zeros(epochs)
	acc_test = zeros(epochs)
end

# ╔═╡ 9d510a57-c293-4cdc-881e-87a30579898f
for epoch in 1:epochs
	for (x, y) in train_loader
		gs = gradient(() -> logitcrossentropy(model(x), y), ps) # compute gradient
		Flux.Optimise.update!(opt, ps, gs) # update parameters
	end
	# Report on train and test
	train_loss, train_acc = loss_and_accuracy(train_loader, model)
	test_loss, test_acc   = loss_and_accuracy(test_loader, model)
	loss_train[epoch] = train_loss
	acc_test[epoch]  = test_acc
	#@show epoch
	#println("  train_loss = $train_loss, train_accuracy = $train_acc")
	#println("  test_loss = $test_loss, test_accuracy = $test_acc")
end

# ╔═╡ 4138f612-4fba-4bf7-9ebb-4811d921184d
begin
	p1 = plot(loss_train, label=nothing, title="Loss function")
	p2 = plot(acc_test, label=nothing, title="Test accuracy")
	plot(p1,p2)
end

# ╔═╡ 6332dbc4-d35b-416c-bd36-29dc11e33573
md"""
## Prediction
$(@bind idata PlutoUI.Slider(1:100))
"""

# ╔═╡ 2b2688c4-335c-42ab-849c-6ac33b794570
begin
	ans_label = test_y[idata]
	predict = model(test_x_flatten[:,idata])
	bar(0:9, predict, 
		title = "Label is $ans_label. Predicted correctly?", 
		lw = 3, label=nothing,
		xtickfontsize=15, ytickfontsize=15)
	xticks!(0:1:9)
	xlabel!("Numbers")
	ylims!(0,1)
end

# ╔═╡ 155c6c4b-d08a-404b-afba-1ef8408773ca
md"""
# Recap
"""

# ╔═╡ Cell order:
# ╠═937b2892-046c-11ec-38f6-7b359f56c76e
# ╠═f35d060b-6ede-4988-8071-c6ead80cc1cd
# ╠═fa0ccf38-fa7d-4a1e-8561-6bee290a8364
# ╠═284fc078-6703-459f-9a33-fdc027912102
# ╠═dcd36616-ddfe-4ef6-8ae6-820374406284
# ╠═decf4a47-80e0-4791-bb98-f12f41f32a81
# ╠═8132e2b2-5319-4995-a047-3863e575cf08
# ╠═06da8206-3894-46b3-9016-ce6ddab45382
# ╠═ec8a0478-54d4-4088-b174-0304c5cc798b
# ╠═7e37814f-116a-45e5-9295-949693aed8db
# ╠═3b080741-1386-43b1-9efc-4a3edfc4e09b
# ╠═8ddfa7d3-86e1-4dea-9dc5-6e4117df0b3f
# ╠═cad5bea4-33bf-45c7-ae03-e3cda9d934aa
# ╠═e159a25b-a68f-468b-97f6-12f786b5aba9
# ╠═8c3e11e2-9cd0-47e9-b636-30a047960430
# ╠═cf09c249-1980-4385-9c95-a625eb221d9e
# ╠═68e5d150-4b02-45c0-b1b1-a56f3b26f2b9
# ╠═1e6d49de-882e-4832-89fd-d737025a4d9f
# ╠═a6176614-abff-4a9d-a718-74c963d49410
# ╠═a980d7ee-5d4f-4597-ad0a-2ad11342252b
# ╠═6a8822ef-a554-40c3-a8f0-e19f761c086b
# ╠═f2f9b086-5a2a-4e4c-963e-5a76c8dbdd01
# ╠═6e3a36b2-58c2-450a-954b-d1469533e3f0
# ╠═400ac9bb-c7d6-497a-b6a1-8b795802b85b
# ╠═0ea08fa7-7338-4100-a585-4befffb65eb0
# ╠═0a7d1f6d-8ece-4fdf-ba46-fdea99a874be
# ╠═0b1786b7-1602-4801-a2cb-f89812632e6c
# ╠═97927f76-03d3-4e58-a84b-f29cc5a7e72d
# ╠═9d510a57-c293-4cdc-881e-87a30579898f
# ╠═4138f612-4fba-4bf7-9ebb-4811d921184d
# ╠═6332dbc4-d35b-416c-bd36-29dc11e33573
# ╠═2b2688c4-335c-42ab-849c-6ac33b794570
# ╠═155c6c4b-d08a-404b-afba-1ef8408773ca
