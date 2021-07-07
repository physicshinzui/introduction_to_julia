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

# ╔═╡ 2be6fde4-aa12-48b6-8e94-a6412503c183
using PlutoUI, Plots

# ╔═╡ 17685de1-5141-4655-baab-3e1163a312b5
md"# Update a value interactively."

# ╔═╡ 58f86c03-3b80-4147-811b-75a415e72aca
value = 11 

# ╔═╡ 205ee32f-eacd-4890-bda1-f1bdc8aa22c5
md"Look at this! -> $(value)"

# ╔═╡ b1a61194-9e55-4dad-a5ad-4ba6db320294
md"""
## Use Slider
*HTML version*
"""

# ╔═╡ 82530140-cdde-4788-b5e5-e44518859a34
@bind value2 html"<input type=range min=-50 max=50>" 

# ╔═╡ 992b900f-9f56-4c0b-8516-7647730282f5
md" $value2 ranges from -50 to 50."

# ╔═╡ 5276ba06-4afd-44fe-8e8f-0704a0eb14db
md"*PlutoUI.Slider version*"

# ╔═╡ 3160a55d-2e75-4332-b8f9-099d6772b4f4
@bind value3 PlutoUI.Slider(-100:50)

# ╔═╡ 4b98b839-217e-4d36-9354-9e56bdc052f2
md"While sliding the bar, look -> $value3"

# ╔═╡ 725b424a-8764-4d92-a1e6-fa48fa5478b6
md"""
## Plot a sin curve
Let's plot $Asin(ωt+ϕ)$, where $A$ is amplitude, $ω$ is angular momentum, and $ϕ$ is phase.
"""

# ╔═╡ 42c869f4-38ea-4589-b55e-8dad6037cfe6
md"""
A: $(@bind A PlutoUI.Slider(1:10))
ω: $(@bind ω PlutoUI.Slider(1:0.1:10))
ϕ: $(@bind ϕ PlutoUI.Slider(0:0.01:π))

"""

# ╔═╡ 9d322649-c3a4-4fbe-a8c2-947c8eb3f4de
md"A = $A, ω = $ω, ϕ = $ϕ"

# ╔═╡ 284b8032-9259-4c2f-b476-a79828973162
begin
	t = 0:0.1:10
	f(t) = A*sin(ω*t + ϕ)
	y = [f(ti) for ti in t]
	plot(t, y)
end

# ╔═╡ 4db782c0-f80e-4b84-a2b0-e75b57eaf49a


# ╔═╡ Cell order:
# ╠═2be6fde4-aa12-48b6-8e94-a6412503c183
# ╟─17685de1-5141-4655-baab-3e1163a312b5
# ╠═58f86c03-3b80-4147-811b-75a415e72aca
# ╠═205ee32f-eacd-4890-bda1-f1bdc8aa22c5
# ╟─b1a61194-9e55-4dad-a5ad-4ba6db320294
# ╠═82530140-cdde-4788-b5e5-e44518859a34
# ╟─992b900f-9f56-4c0b-8516-7647730282f5
# ╟─5276ba06-4afd-44fe-8e8f-0704a0eb14db
# ╠═3160a55d-2e75-4332-b8f9-099d6772b4f4
# ╟─4b98b839-217e-4d36-9354-9e56bdc052f2
# ╠═725b424a-8764-4d92-a1e6-fa48fa5478b6
# ╠═42c869f4-38ea-4589-b55e-8dad6037cfe6
# ╠═9d322649-c3a4-4fbe-a8c2-947c8eb3f4de
# ╟─284b8032-9259-4c2f-b476-a79828973162
# ╠═4db782c0-f80e-4b84-a2b0-e75b57eaf49a
