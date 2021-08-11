### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ df347384-73ad-48c1-848c-8adf42c99b54
using Plots, PlutoUI, LsqFit, Pkg

# ╔═╡ f47b54f6-f0cf-11eb-35e2-e129cd78014e
md"""
# Fitting with Julia
Written by Shinji Iida


"""

# ╔═╡ 8c10e197-2736-4cbb-a762-baeb2a7afc69
with_terminal() do 
	println(VERSION)
	Pkg.status(["Plots","LsqFit","PlutoUI", "Pkg"]) 
end

# ╔═╡ ee1e2557-169f-409c-bce8-94b10c6a0d52
TableOfContents()

# ╔═╡ 9f6ba259-7ac4-4ea8-b4a4-91e16f985640
md"## 1. Exponential Fitting"

# ╔═╡ 5a0ff55a-0b24-44f0-9264-c3c5b69474c4
begin 
	expmodel(x, p) = p[1] * exp.(p[2] * x)
	xs = 0:0.1:10
	data1 = expmodel(xs, [10,-1]) + rand(length(xs))
	plot(xs, data1, label = "Raw")

	p0 = [0.5, 0.5]
	fit = curve_fit(expmodel, xs, data1, p0)
	y_pred = expmodel(xs, fit.param)
	plot!(xs, y_pred, label = "Model")
end

# ╔═╡ 82b36a6a-0e15-4a39-9b06-08f1bb101da8
md"## 2. Sin curve fitting"

# ╔═╡ 21778339-2f51-4b92-8926-bc4dcf648c41
begin
	sin_model(x, p) = p[1] * sin.(p[2]*x) 
	xdata = [xi for xi in 0:0.1:4π]
	ydata = sin_model(xdata, [1,1]) .+ rand(length(xdata)) #noise
	plot(xdata, ydata)
	
	sinfit = curve_fit(sin_model, xdata, ydata, p0)
	sin_pred = sin_model(xdata, sinfit.param)
	plot!(xdata, sin_pred)
end

# ╔═╡ 7400fa63-b012-4da6-95b3-1f0099eed877
md"""
## References
- https://github.com/JuliaNLSolvers/LsqFit.jl
"""

# ╔═╡ Cell order:
# ╠═f47b54f6-f0cf-11eb-35e2-e129cd78014e
# ╠═df347384-73ad-48c1-848c-8adf42c99b54
# ╠═8c10e197-2736-4cbb-a762-baeb2a7afc69
# ╠═ee1e2557-169f-409c-bce8-94b10c6a0d52
# ╠═9f6ba259-7ac4-4ea8-b4a4-91e16f985640
# ╠═5a0ff55a-0b24-44f0-9264-c3c5b69474c4
# ╠═82b36a6a-0e15-4a39-9b06-08f1bb101da8
# ╠═21778339-2f51-4b92-8926-bc4dcf648c41
# ╠═7400fa63-b012-4da6-95b3-1f0099eed877
