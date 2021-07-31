### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ df347384-73ad-48c1-848c-8adf42c99b54
using Plots, PlutoUI, LsqFit, Pkg

# ╔═╡ f47b54f6-f0cf-11eb-35e2-e129cd78014e
md"""
# Juliaでデータフィッティング
Written by なつれ

参考文献
- https://github.com/JuliaNLSolvers/LsqFit.jl
"""

# ╔═╡ acfd4f7e-6a21-4b22-96f2-182471b33734
md"## 使用するパッケージのバージョンを確認"

# ╔═╡ 8c10e197-2736-4cbb-a762-baeb2a7afc69
with_terminal() do 
	println(VERSION)
	Pkg.status(["Plots","LsqFit","PlutoUI", "Pkg"]) 
end

# ╔═╡ 9f6ba259-7ac4-4ea8-b4a4-91e16f985640
md"## 1. データの生成"

# ╔═╡ 21778339-2f51-4b92-8926-bc4dcf648c41
begin
xdata = [xi for xi in 0:0.1:4π]
ydata = sin.(xdata) .+ rand(length(xdata)) #乱数のノイズをのせる
plot(xdata, ydata)
end

# ╔═╡ ac630d6d-51ab-4136-ac06-40eb44ae5bff
md"## 2. fittingに使う関数を定義する"

# ╔═╡ 23e7d2e5-ecc1-474a-9017-dd13924de2d2
@. model(x) = p[1] * sin(x*p[2])

# ╔═╡ e898cfec-9f4d-4184-9cfa-1e932ee484c8
begin
params = [0.5, 0.5]
fit =curve_fit(model, xdata, ydata, params)
end

# ╔═╡ 6149f535-2866-452f-820a-f42095c8399a


# ╔═╡ Cell order:
# ╠═f47b54f6-f0cf-11eb-35e2-e129cd78014e
# ╠═df347384-73ad-48c1-848c-8adf42c99b54
# ╠═acfd4f7e-6a21-4b22-96f2-182471b33734
# ╠═8c10e197-2736-4cbb-a762-baeb2a7afc69
# ╠═9f6ba259-7ac4-4ea8-b4a4-91e16f985640
# ╠═21778339-2f51-4b92-8926-bc4dcf648c41
# ╠═ac630d6d-51ab-4136-ac06-40eb44ae5bff
# ╠═23e7d2e5-ecc1-474a-9017-dd13924de2d2
# ╠═e898cfec-9f4d-4184-9cfa-1e932ee484c8
# ╠═6149f535-2866-452f-820a-f42095c8399a
