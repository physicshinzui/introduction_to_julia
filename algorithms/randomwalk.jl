### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 02d38976-d3be-46e3-9e92-4ad52701bab8
using Plots, PlutoUI, BenchmarkTools

# ╔═╡ bd4a3594-d86d-11eb-09e1-7714e043a863
md"""
# Random Walk
Written by Shinji Iida
Date: 30.6.2021
"""

# ╔═╡ a508cd01-9366-432b-aac3-3a8798550bfb
TableOfContents(aside=true)

# ╔═╡ 9a2014d5-4790-4642-a5ed-3108a6aba5d8
md"""## Trajectories of a simple random walk
The following lines each generates a random step, -1 or 1.
"""

# ╔═╡ c81ce5d9-f7b1-4ca4-a699-992867de92d6
begin
	step1() = rand((-1,1))
	step2() = 2 * rand(Bool) - 1  
end

# ╔═╡ 087c4b06-77f1-4a40-89d2-829f9b43bfde
with_terminal() do  
	@btime step1()
	@btime step2()
end

# ╔═╡ f777c4e8-75b4-470f-9162-5cfe6db67ee4
step2()

# ╔═╡ 31f984d6-2a45-40dd-9112-e31de03e8254
function walk1D(N)
	x = 0
	xs = [x]
	for xi in 1:N
		x += step2()
		push!(xs, x)
	end
	return xs
end

# ╔═╡ 25aa9ea8-d396-4be4-baac-1793945cf7c0
begin
	plot()
	N = 10^2
	for i in 1:3
		xs = walk1D(N)
		plot!(xs, lw=3, label="Traj $i")
	end
	plot!()
end

# ╔═╡ 00fc2d35-0a69-4ff5-ab40-5a7677d9654d
md"""
## Generalised Random Walk Function
"""

# ╔═╡ 4a55e4c3-34b4-4b19-963e-35e9984f13af
abstract type Walker end

# ╔═╡ 46c2c8f0-ada5-4048-b4bf-768eda8f250a
struct Walker1D <: Walker
	pos::Int
end

# ╔═╡ 390eb3cf-e7bd-4cbb-8844-28399bef01fb
position(w::Walker) = w.pos

# ╔═╡ 00438f55-f60e-4b74-baae-35b7dd14f431
# Anologous to this
#function position(w::Walker)
#	return w.pos
#end

# ╔═╡ e28c8514-e00e-4e2e-810f-c5147c6ac1d0
step(w::Walker1D) = rand((-1,1))

# ╔═╡ cffdc8ce-af9d-4a49-9125-4ea40cc9eba8
struct Walker2D <: Walker
	x::Int
	y::Int
end

# ╔═╡ 3b39d63a-f855-432b-a316-38227685cba2
position(w::Walker2D) = (w.x, w.y)

# ╔═╡ efa4a984-9f72-454b-8b22-312480317002
update(w::W, step) where {W <: Walker} = W(position(w) + step) # I don't still understand how this is working. 

# ╔═╡ b0eaea89-4316-4970-b737-726d73f149dd
step(w::Walker2D) = rand( [ [1, 0], [0, 1], [-1, 0], [0, -1] ] ) # One step size is set to one, and hence there are four ways. This rand function takes one list from the four randomly.

# ╔═╡ ec0d1c9e-e6f2-4a4b-9206-9b0527901663
update(w::Walker2D, step::Vector) = Walker2D(w.x + step[1], w.y + step[2])

# ╔═╡ ace3727e-5ca3-4e36-bd86-3b46f42cb455
function trajectory(w::W, N) where {W}   # W is a type parameter
	ws = [position(w)]

	for i in 1:N
		pos = position(w)
		w = update(w, step(w))
		
		push!(ws, position(w))
	end
	
	return ws
end

# ╔═╡ 8ca60072-fe66-46fc-9049-4d400fc7cc9e
traj1D = trajectory(Walker1D(0), 10)

# ╔═╡ 3dfed208-fada-4b4b-8fcd-e0a5244db985
plot(traj1D)

# ╔═╡ 32abdd96-ed8a-4fd2-8229-f5569c20d9a8
traj = trajectory(Walker2D(0, 0), 10^N)

# ╔═╡ Cell order:
# ╠═bd4a3594-d86d-11eb-09e1-7714e043a863
# ╠═02d38976-d3be-46e3-9e92-4ad52701bab8
# ╠═a508cd01-9366-432b-aac3-3a8798550bfb
# ╠═9a2014d5-4790-4642-a5ed-3108a6aba5d8
# ╠═c81ce5d9-f7b1-4ca4-a699-992867de92d6
# ╠═087c4b06-77f1-4a40-89d2-829f9b43bfde
# ╠═f777c4e8-75b4-470f-9162-5cfe6db67ee4
# ╠═31f984d6-2a45-40dd-9112-e31de03e8254
# ╠═25aa9ea8-d396-4be4-baac-1793945cf7c0
# ╠═00fc2d35-0a69-4ff5-ab40-5a7677d9654d
# ╠═4a55e4c3-34b4-4b19-963e-35e9984f13af
# ╠═46c2c8f0-ada5-4048-b4bf-768eda8f250a
# ╠═390eb3cf-e7bd-4cbb-8844-28399bef01fb
# ╠═00438f55-f60e-4b74-baae-35b7dd14f431
# ╠═e28c8514-e00e-4e2e-810f-c5147c6ac1d0
# ╠═efa4a984-9f72-454b-8b22-312480317002
# ╠═ace3727e-5ca3-4e36-bd86-3b46f42cb455
# ╠═8ca60072-fe66-46fc-9049-4d400fc7cc9e
# ╠═3dfed208-fada-4b4b-8fcd-e0a5244db985
# ╠═cffdc8ce-af9d-4a49-9125-4ea40cc9eba8
# ╠═3b39d63a-f855-432b-a316-38227685cba2
# ╠═b0eaea89-4316-4970-b737-726d73f149dd
# ╠═ec0d1c9e-e6f2-4a4b-9206-9b0527901663
# ╠═32abdd96-ed8a-4fd2-8229-f5569c20d9a8
