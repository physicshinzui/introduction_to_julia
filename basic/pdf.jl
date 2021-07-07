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

# ╔═╡ 92be8510-e124-48d7-86ef-77d2904c26b6
using Pluto, Plots, PlutoUI, LinearAlgebra

# ╔═╡ 18093438-db8b-11eb-1cb2-7ffbb52e7b45
md"# Probability Distribution"

# ╔═╡ d86ef533-52ac-430a-9710-f48bb98df85f
begin
	σslider = @bind σ PlutoUI.Slider(0.01:0.01:10^3)
	μslider = @bind μ PlutoUI.Slider(0:0.1:10)
	md"""
	σ : $σslider
	μ : $μslider
	"""
end

# ╔═╡ 2dbf3142-d83c-4cd1-82ed-4d7ca36bd271
md"σ = $σ, μ = $μ"

# ╔═╡ 6068acfa-c5f0-45da-b54a-a26d40b4bf32
begin
	x = -10:0.01:10
	f(x) = exp(-(x - μ)^2/σ)
	y = [f(xi) for xi in x]
	plot(x, y, lw=3, label="Gaussian: mu=$μ, sigma=$σ", xlim=[-10,10], ylim=[0.0,1])
end

# ╔═╡ 2d015fe4-1083-45e4-a635-d24fb80f3870


# ╔═╡ 03a7a649-894e-4a51-a913-3771014a1994


# ╔═╡ Cell order:
# ╠═18093438-db8b-11eb-1cb2-7ffbb52e7b45
# ╠═92be8510-e124-48d7-86ef-77d2904c26b6
# ╠═d86ef533-52ac-430a-9710-f48bb98df85f
# ╠═2dbf3142-d83c-4cd1-82ed-4d7ca36bd271
# ╠═6068acfa-c5f0-45da-b54a-a26d40b4bf32
# ╠═2d015fe4-1083-45e4-a635-d24fb80f3870
# ╠═03a7a649-894e-4a51-a913-3771014a1994
