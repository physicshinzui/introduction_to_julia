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

# ╔═╡ 1467e1b4-89f8-4084-9567-3a4d5bbe5655
using Plots, PlutoUI

# ╔═╡ 54fa6854-d80b-11eb-0668-61deb4905f8a
md"# Euler Method: A difference method for a differential equation."

# ╔═╡ d90aa1c9-5073-490d-8ccc-4b04a8b07236
md"""
## Definition of a 1D harmonic system

Potential energy: $V = \frac{1}{2}k(x - x_{eq})$ 
Kinetic energy  : $K = \frac{1}{2}mv^2$

"""

# ╔═╡ 5040d8cd-6807-495c-8a0c-5ca71bf81a54
begin
	struct harmonic_1D_sys
        mass::Float64
        spring_const::Float64
        x_eq::Float64
    end
	function potential(x, x_eq, k = 1.0)
		potential = 0.5 * k * (x - x_eq)^2
		force     = - k * (x - x_eq) 
		return potential
	end

	function force(x, x_eq, k = 1.0)
		force = - k * (x - x_eq) 
		return force
	end 

	function kinetic_energy(v, mass)
		return 0.5 * mass * v^2
	end
end

# ╔═╡ f6217cad-424b-4492-94a8-dbbe104b29c7
md"## Euler's method function"

# ╔═╡ c9d6d933-88f8-4dea-a5d8-9a752ccda3e5
function euler(x0, v0, dt, n_steps, sys::harmonic_1D_sys)
    spring_const = sys.spring_const
    mass         = sys.mass 
    x_eq         = sys.x_eq 
    
    # --- Initialization ---
    x_t  = x0
    v_t  = v0 
    PE   = potential(x_t, x_eq, spring_const)
    f_t  = force(x_t, x_eq, spring_const) 
    KE   = kinetic_energy(v_t, mass)
    H    = PE + KE
    a_t  = f_t / mass
	
	xs   = []
	vs   = []
	Ps   = []
	Ks   = []
	Hs   = []
    # --- main loop ---
    for i in 1:n_steps
        x_t = x_t + v_t * dt
        PE  = potential(x_t, x_eq, spring_const) 
        f_t = force(x_t, x_eq, spring_const) 
        a_t = f_t / mass
        v_t = v_t + a_t * dt
        KE  = kinetic_energy(v_t, mass)
		push!(xs, x_t)
		push!(vs, v_t)
		push!(Ps, PE)
		push!(Ks, KE)
        push!(Hs, PE + KE)
    end
	return xs, vs, Ps, Ks, Hs
end

# ╔═╡ 88b216aa-3928-4658-b8e8-20e8cdfc50a1
md"## Velocity Verlet Algorithm"

# ╔═╡ 7f7b69c8-4fc6-4494-8f02-12dfabe719f3
function velocityVerlet(x0, v0, dt, n_steps, sys::harmonic_1D_sys)
    spring_const = sys.spring_const
    mass         = sys.mass 
    x_eq         = sys.x_eq 
    
    # --- Initialization ---
    x_t  = x0
    v_t  = v0 
    PE   = potential(x_t, x_eq, spring_const)
    f_t  = force(x_t, x_eq, spring_const) 
    KE   = kinetic_energy(v_t, mass)
    H    = PE + KE
    a_t  = f_t / mass
	
	xs   = []
	vs   = []
	Ps   = []
	Ks   = []
	Hs   = []
    # --- main loop ---
	for i in 1:n_steps
        v_half = v_t + 0.5 * a_t * dt
        x_t = x_t + v_half * dt
        PE  = potential(x_t, x_eq, spring_const) 
        f_t = force(x_t, x_eq, spring_const) 
        a_t = f_t / mass
        v_t = v_half + 0.5 * a_t * dt
        KE  = kinetic_energy(v_t, mass)
        H   = PE + KE
		push!(xs, x_t)
		push!(vs, v_t)
		push!(Ps, PE)
		push!(Ks, KE)
        push!(Hs, PE + KE)		
    end
	return xs, vs, Ps, Ks, Hs
end    


# ╔═╡ 1105db00-91bd-4a85-9893-d5abb1271123
md"""
In my simulation, $m=1$, $k=1$ is assumed, and hence the resultant trajectory must follow the circule $\frac{1}{2}v^2 + \frac{1}{2}(x - x_{\mathrm{eq}})^2 = H$. 
Since we set 
$v_0 = 0$, 
$x_0 = 1$, 
$x_{\mathrm{eq}} = 0$
, we get $H=0.5$ (as shown above).
Therefore, we expect the trajectory to trace $\frac{1}{2}v^2 + \frac{1}{2}x^2 = 0.5 \Rightarrow v^2 + x^2 = 1$.
Let's see if we can get it.
"""

# ╔═╡ f1cc3381-dde0-49c4-8649-4b4a46d764d2
begin
	mass = 1.0
	x_eq = 0.0
	k    = 1.0
	x0   = 1.0
	v0   = 0.0 
	n_steps = 10^2
	sys = harmonic_1D_sys(mass, k, x_eq)
end

# ╔═╡ a73c2b1a-a87b-4def-9b42-570d944aeef3
md"$(@bind dt PlutoUI.Slider(0.01:0.01:2.0))"

# ╔═╡ 77b0f727-b59e-4dc6-a883-bc18bcf759e9
md"### Time step = $(dt)"

# ╔═╡ 079af12d-5fa4-42e4-9913-c31b3e7ae52c
begin
	xs, vs, pot, kine, tot = euler(x0, v0, dt, n_steps, sys)
	vv_xs, vv_vs, vv_pot, vv_kine, vv_tot = velocityVerlet(x0, v0, dt, n_steps, sys)
end

# ╔═╡ 8c498545-2139-4f12-818f-6eb3236549f4
begin
	t = dt*[ti for ti in 1:length(pot)]
	p1 = plot(t, tot, lw=3, label="Total (Euler)", 
		xlim=(0,10),ylim=(0,1), xlabel="Time", ylabel="Energy")
	plot!(p1, t, vv_tot, lw=3, label="Total (VV)")

	#plot!(t, pot, seriestype=:path, lw=3, label="Potential",
	#	xlim=(0,10),ylim=(0,1), xlabel="Steps", ylabel="Energy")
	#plot!(p1, t, kine, lw=3, label="Kinetic")

	p2 = plot(xs,vs, seriestype=:scatter, aspect_ratio=1, 
		xlim=(-1.2,1.2),ylim=(-1.2,1.2), label="Euler", markersize=3, markerstrokewidth=0)
	θ=-π:0.01:π
	x = cos.(θ); y = sin.(θ)
	
    plot!(p2, vv_xs,vv_vs, seriestype=:scatter, label="Velocity Verlet", markersize=2) 
	plot!(p2, x, y, seriestype=:path, markersize=1, 
		label="Analytical", c=:black, xlabel="x", ylabel="v")	
	p = plot(p1, p2)
end

# ╔═╡ 9f1778ab-62b8-4629-9bdc-de11526c60d5


# ╔═╡ Cell order:
# ╟─54fa6854-d80b-11eb-0668-61deb4905f8a
# ╠═1467e1b4-89f8-4084-9567-3a4d5bbe5655
# ╠═d90aa1c9-5073-490d-8ccc-4b04a8b07236
# ╠═5040d8cd-6807-495c-8a0c-5ca71bf81a54
# ╠═f6217cad-424b-4492-94a8-dbbe104b29c7
# ╟─c9d6d933-88f8-4dea-a5d8-9a752ccda3e5
# ╠═88b216aa-3928-4658-b8e8-20e8cdfc50a1
# ╠═7f7b69c8-4fc6-4494-8f02-12dfabe719f3
# ╠═1105db00-91bd-4a85-9893-d5abb1271123
# ╟─f1cc3381-dde0-49c4-8649-4b4a46d764d2
# ╠═a73c2b1a-a87b-4def-9b42-570d944aeef3
# ╟─77b0f727-b59e-4dc6-a883-bc18bcf759e9
# ╠═079af12d-5fa4-42e4-9913-c31b3e7ae52c
# ╠═8c498545-2139-4f12-818f-6eb3236549f4
# ╠═9f1778ab-62b8-4629-9bdc-de11526c60d5
