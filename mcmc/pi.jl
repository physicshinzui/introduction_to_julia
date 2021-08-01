### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 31511d3c-c4a8-4b38-bec3-2cc054d859ad
using Plots, PlutoUI

# ╔═╡ 60ca3b34-f2c3-11eb-1435-5d656c84512f
md"# モンテカルロ法で円周率を求める"

# ╔═╡ 901847d0-f8bb-4508-9f7d-b7a9bfb98c30
function calcpi(N)
    seqx = zeros(N)
    seqy = zeros(N)

    n_count = 0
    for i in 1:N   
        x = rand() # random number ranging [0,1]
        y = rand() # same 
        seqx[i] = x
        seqy[i] = y

        if (x^2 + y^2 <= 1.0)
            n_count += 1 
        end
    end
    numeric_pi = n_count / N
    return numeric_pi * 4.0, seqx, seqy
end

# ╔═╡ 1f9dd47b-1346-42b8-b63e-0006c8d8efab
begin
	N = 10^5
	numeric_pi, x, y = calcpi(N)
	numeric_pi
end

# ╔═╡ 7ffad0e1-d1a0-4fd3-b58f-0051d7990c0e
function circuleShape(h, k, r)
    # (r*sinθ)^2 + (r*cosθ)^2 
    θ = LinRange(0, 2π, 500)
    (h .+ r*sin.(θ), k .+r*cos.(θ))
end

# ╔═╡ 62ebadc0-1eac-4b1e-97cb-26b22431fca9
begin
plot(xlims = [0,1], ylims = [0,1], aspect_ratio = 1)
plot!(circuleShape(0,0,1), c = :red, lw = 3, linecolor = :black, label = false, 
      fillrange = 0, fillalpha=0.5, fillcolor=:cyan)

nskip = 10^3 # for the sake of plotting
anim = @animate for i in 1:nskip:N
    scatter!((x[i], y[i]), c = :red, label = false)
end

gif(anim, "anim_pi_fps15.gif", fps = 15)
end

# ╔═╡ Cell order:
# ╟─60ca3b34-f2c3-11eb-1435-5d656c84512f
# ╠═31511d3c-c4a8-4b38-bec3-2cc054d859ad
# ╠═901847d0-f8bb-4508-9f7d-b7a9bfb98c30
# ╠═1f9dd47b-1346-42b8-b63e-0006c8d8efab
# ╠═7ffad0e1-d1a0-4fd3-b58f-0051d7990c0e
# ╠═62ebadc0-1eac-4b1e-97cb-26b22431fca9
