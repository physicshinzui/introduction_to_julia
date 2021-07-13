### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ e9732e60-dfe2-11eb-0e11-85036ab8794c
using PlutoUI, Plots

# ╔═╡ 19e38f57-52e5-4bbe-879e-2363b0c2972a
md"# Activation functions"

# ╔═╡ b1964bf1-0b81-4a75-896d-1c6e7c0cd2f3
begin
	function step(x)
		return x<=0 ? 0 : 1
	end
	function sigmoid(x) 
		return 1 / (1 + exp(-x))
	end
	function relu(x) 
		return max(0, x)
	end
	function softmax(xs)
		y =  exp.(xs)
		return y ./ sum(y)
	end
	function identity(x)
		return x
	end
#	function softmax(x)
#		return exp(x) /exp()
#	end
end

# ╔═╡ 94616701-9c11-4c3c-ab2e-d5b0b258ddd7
begin
	x = [-2:0.01:2;]
	ystep = step.(x)
	ys = sigmoid.(x)
	yr = relu.(x)
	ysoft = softmax(x) 
	yi = identity.(x)
	plot(x, ystep, label="Step", ylims=[-0.5,2.0])  
	plot!(x, ys, label="Sigmoid")
	plot!(x,yr, label="ReLu", lw =3)
	plot!(x,ysoft, label="Softmax", lw =3)	
	plot!(x, yi, label="Identity", color=:black)
end

# ╔═╡ 15a22932-d85e-4f4f-9e23-ff0de5b4642d
sum(softmax.(x))

# ╔═╡ fae14f3f-ead2-4382-ab37-0af29419ac40
md"""# Neutral network

$\boldsymbol{A}^T = \boldsymbol{x}^T\boldsymbol{W}^T + \boldsymbol{b}^T$
(Row vector representation)

$\boldsymbol{A} = \boldsymbol{W}\boldsymbol{x} + \boldsymbol{b}$ 
(This is colum-vector representation )

b: control the extent of conbustion.

"""

# ╔═╡ 141197b6-44b3-4fca-8d94-92827a04783c
function init_network()
	network = Dict()
	network["b1"] = [0.1, 0.1, 0.1]
	network["b2"] = [0.1, 0.1, 0.1]
	network["b3"] = [0.1, 0.1, 0.1]
	network["W1"] = [0.1 0.1 ; 0.1 0.1 ; 0.1 0.1] 
	network["W2"] = [0.1 0.1 ; 0.1 0.1 ; 0.1 0.1] 
	network["W3"] = [0.1 0.1 ; 0.1 0.1 ; 0.1 0.1] 
	
	return network
end

# ╔═╡ ec6435b3-43d0-45b6-b497-280c4756b6ee
function forward(network, x)
	W1, W2, W3 = network["W1"], network["W2"], network["W3"]
	b1, b2, b3 = network["b1"], network["b2"], network["b3"]
	
	a1 = W1*x + b1  	
	z1 = sigmoid.(a1)
	
	a2 = W2*z1 + b2
	z2 = sigmoid.(a2)
	
	a3 = W3*z2 + b3
	z3 = sigmoid.(a3)
end

# ╔═╡ 3647c957-25a1-4091-9771-6765fd15c842
model = init_network()

# ╔═╡ d950cece-bee3-4cd7-9fdb-92e951a95510
begin
	features = [1.0, 0.5]
	forward(model, features)
end

# ╔═╡ Cell order:
# ╠═e9732e60-dfe2-11eb-0e11-85036ab8794c
# ╠═19e38f57-52e5-4bbe-879e-2363b0c2972a
# ╠═b1964bf1-0b81-4a75-896d-1c6e7c0cd2f3
# ╠═94616701-9c11-4c3c-ab2e-d5b0b258ddd7
# ╠═15a22932-d85e-4f4f-9e23-ff0de5b4642d
# ╠═fae14f3f-ead2-4382-ab37-0af29419ac40
# ╠═141197b6-44b3-4fca-8d94-92827a04783c
# ╠═ec6435b3-43d0-45b6-b497-280c4756b6ee
# ╠═3647c957-25a1-4091-9771-6765fd15c842
# ╠═d950cece-bee3-4cd7-9fdb-92e951a95510
