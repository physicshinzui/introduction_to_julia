### A Pluto.jl notebook ###
# v0.14.7

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

# ╔═╡ 2d5cc2d6-defc-11eb-02d4-eb630a129828
using LsqFit, Plots, PlutoUI

# ╔═╡ 8052bcfe-a45d-4b56-977b-f4b50141e145
md"""
# Exponential fitting Via LsqFit

$f(p_1, p_2) = p_1\exp(-p_2t)$

"""

# ╔═╡ 4dec5089-2cdc-4a6a-912c-13a154dad9fa
model(t, p) = p[1] * exp.(-p[2] * t) 

# ╔═╡ 5e55162c-bd68-4a79-aa0e-69c8feeaeb4d
begin
	md"""
	p1 = $(@bind p1 PlutoUI.Slider(1:1:10))
	p2 = $(@bind p2 PlutoUI.Slider(0.01:0.01:1))
	"""
end

# ╔═╡ 228faed9-ebc4-41d8-a079-a58e922df93a
begin
	xs = LinRange(0,10^2, 10^3)
	ys = model(xs, [p1, p2]) + 0.01*randn(length(xs))
end

# ╔═╡ 927a576b-4624-49f6-ae75-a4f656079263
plot(xs, ys, lw = 3)

# ╔═╡ 79a20477-4650-4638-b01d-f03353eb227d
p0 = [0.5, 0.5]

# ╔═╡ 59bf94eb-30c6-4026-985f-2dea4ece28a3
fit = curve_fit(model, xs, ys, p0)

# ╔═╡ f54b4dff-7c85-4eb2-8a38-c1700b600095
params = fit.param

# ╔═╡ fbc47be3-296d-41fd-a688-89a7576d3db2
ys_fit = model(xs, params)

# ╔═╡ a9f76a9f-572c-40c9-88f3-dd2bb52efbae
begin
plot(xs, ys, seriestype=:scatter, label="Data")
plot!(xs, ys_fit, lw = 3, label="fit")
end

# ╔═╡ Cell order:
# ╠═2d5cc2d6-defc-11eb-02d4-eb630a129828
# ╟─8052bcfe-a45d-4b56-977b-f4b50141e145
# ╠═4dec5089-2cdc-4a6a-912c-13a154dad9fa
# ╟─5e55162c-bd68-4a79-aa0e-69c8feeaeb4d
# ╠═228faed9-ebc4-41d8-a079-a58e922df93a
# ╠═927a576b-4624-49f6-ae75-a4f656079263
# ╠═79a20477-4650-4638-b01d-f03353eb227d
# ╠═59bf94eb-30c6-4026-985f-2dea4ece28a3
# ╠═f54b4dff-7c85-4eb2-8a38-c1700b600095
# ╠═fbc47be3-296d-41fd-a688-89a7576d3db2
# ╠═a9f76a9f-572c-40c9-88f3-dd2bb52efbae
