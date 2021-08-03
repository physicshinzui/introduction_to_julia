### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ de1993be-f328-11eb-0e73-7bab5943e982
using Plots, PlutoUI

# ╔═╡ 5247b05b-e1b1-4519-9a45-9caba4eb883c
md"""
# Metropolice Algorithm
Written by shinji iida
"""

# ╔═╡ 85885a7b-55fe-4258-ac17-bddfa9f22a1e
VERSION

# ╔═╡ b004472e-ee2d-4b3c-a9df-53cb714a2efb
abstract type Simulator end

# ╔═╡ 696a5600-14e9-44dc-a31d-f8608a3f8760
abstract type MetroPolice <: Simulator end

# ╔═╡ dbf86a88-c82d-447f-a9bd-1d5df17a4e34
md"""
$p_i=\exp(-E_i/k_BT)/Z$


!!! definition "a"
	aasdf
	asd
!!!

"""

# ╔═╡ f6876d14-ccd8-4585-b1ef-2fbc9e5c6ae5
abstract type EnergyFunction end

# ╔═╡ 7bf0718f-73c0-4506-b2eb-8958a01c686c
abstract type Harmonic <: EnergyFunction end

# ╔═╡ cf83ec85-63ad-4e07-aadb-c236800a561b
abstract type LJ <: EnergyFunction end

# ╔═╡ b1b2d628-d488-49c1-abf1-bf91873fee76
function harmonicpotential(x) <: 
end

# ╔═╡ 79e06316-fe38-49b9-b327-8c94c226c124
#function simulate(s::Simulator, nsteps=100, stepsize=0.5)
function simulate(nsteps=100, stepsize=0.5, fenergy=nothing)
	α = 0.5 #kT
	x, naccepts = 0.0, 0

	traj = []
	for i in 1:nsteps
		x1 = x
		E1 = x1^2
		
		Δx = rand()
		Δx = 2.0 * stepsize * (Δx - 0.5) # [-1, -1] 
		x2 = x1 + Δx
		
		E2 = x2^2
		ΔE = E2 - E1
		if exp(-ΔE/α) > rand()
			naccepts += 1
			x = x2
		else 
			x = x1
		end
		push!(traj, x)
	end
	return traj	
end

# ╔═╡ 69f48696-4553-412d-90c2-cfb7c3472243
trajectory = simulate(10^4)

# ╔═╡ c2efe7f6-d97b-4265-871d-d49092a89faf
begin
	p1 = plot(trajectory)
	p2 = histogram(trajectory)
	plot(p1,p2)
end

# ╔═╡ Cell order:
# ╠═5247b05b-e1b1-4519-9a45-9caba4eb883c
# ╠═85885a7b-55fe-4258-ac17-bddfa9f22a1e
# ╠═de1993be-f328-11eb-0e73-7bab5943e982
# ╠═b004472e-ee2d-4b3c-a9df-53cb714a2efb
# ╠═696a5600-14e9-44dc-a31d-f8608a3f8760
# ╠═dbf86a88-c82d-447f-a9bd-1d5df17a4e34
# ╠═f6876d14-ccd8-4585-b1ef-2fbc9e5c6ae5
# ╠═7bf0718f-73c0-4506-b2eb-8958a01c686c
# ╠═cf83ec85-63ad-4e07-aadb-c236800a561b
# ╠═b1b2d628-d488-49c1-abf1-bf91873fee76
# ╠═79e06316-fe38-49b9-b327-8c94c226c124
# ╠═69f48696-4553-412d-90c2-cfb7c3472243
# ╠═c2efe7f6-d97b-4265-871d-d49092a89faf
