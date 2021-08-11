### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 504f9d8d-c6f5-443a-b151-a7822a651582
using Plots

# ╔═╡ 7fd83c46-f80d-11eb-1419-835c00888d0b
md"Laurentz attractor"

# ╔═╡ 27e62691-c05f-4055-bce0-5473a589838b
begin 
	xi, yi, zi = 0.5, 0.5, 0.5
	Δt = 0.001
	p  = 10.0
	r  = 28.0
	b  = 1.0
	xs, ys, zs = [], [], []
end

# ╔═╡ 1e5fa238-348e-4243-94c6-6fdc3091f355
function forward(x, y, z, Δt)
	x_suc = x + Δt*(-p*x + p*y)
	y_suc = y + Δt*(-x*z + r*x - y)
	z_suc = z + Δt*(x*y - b*z) 
	return x_suc, y_suc, z_suc
end

# ╔═╡ d305784c-17c7-46cb-a70b-2d95caa65f4e
for i in 1:1000
	x_suc, y_suc, z_suc = forward(xi, yi, zi, Δt)
	push!(xs, x_suc)
	push!(ys, y_suc)
	push!(zs, z_suc)
	xi, yi, zi = x_suc, y_suc, z_suc 
end

# ╔═╡ acb0c704-ef54-418b-b63d-27182a98e579
begin
	anim = @animate for i in 1:100
		scatter3d(xs[i],ys[i],zs[i], markersize=1, label=nothing)
	end
	gif(anim, fps=15)
end

# ╔═╡ Cell order:
# ╠═7fd83c46-f80d-11eb-1419-835c00888d0b
# ╠═504f9d8d-c6f5-443a-b151-a7822a651582
# ╠═27e62691-c05f-4055-bce0-5473a589838b
# ╠═1e5fa238-348e-4243-94c6-6fdc3091f355
# ╠═d305784c-17c7-46cb-a70b-2d95caa65f4e
# ╠═acb0c704-ef54-418b-b63d-27182a98e579
