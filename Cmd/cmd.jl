### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 9c4ff13a-035b-48b1-a648-7a1bf24a52d3
using PlutoUI

# ╔═╡ f9d847b4-a692-4e43-88e0-e0ce8a8af957
md"""
# How to Operate Shell From Julia

"""

# ╔═╡ 8e08740b-e50d-4384-bd47-ad666ad4643b
TableOfContents()

# ╔═╡ 0efd5820-5b22-44c0-b870-b39bd4e26501
VERSION

# ╔═╡ 5b7bd236-cef2-4b5e-be9a-7a2f709c962e
md"""
## Call commands

### run(cmd)
"""

# ╔═╡ 85e7633a-ccb0-45ae-bdd5-32f2fbfb52d0
typeof(`date`) # check what is the type of `date`.

# ╔═╡ f174bbeb-82dd-4347-809a-ef59e1581716
run(`date`) # return Process type object

# ╔═╡ 57dfcadf-680e-4ab1-8556-ce7db81c2738
md"### read(cmd, type)"

# ╔═╡ c3bd331b-24ea-4f66-baf4-827e688c9414
read(`date`, String) #Acquire standard output as String

# ╔═╡ 6fedd808-ed72-414f-aa51-5f804afa0833
md"### eachline(cmd)"

# ╔═╡ c5ea0aee-db11-4618-82dd-52968725584c
read(`ps`, String)

# ╔═╡ 50968b18-c29e-491d-8b5b-fc68208cb79e
md"is expressed as:"

# ╔═╡ b291b79f-5cef-4601-8640-934963ad3e84
with_terminal() do
	for line in eachline(`ps`)
		println(line)
	end
end

# ╔═╡ 0d04ee89-2665-4501-81b4-8d7cc91430b5
md"## Show a shell is used explicitly."

# ╔═╡ 9d651945-bf76-407a-8a2e-09136377ec58
md"""

!!! note
	The command that is in backquotation marks are not carried out via a shell, so asterisk（*） or a pile(|) can work properly.
The following example causes LoadError:
"""

# ╔═╡ ab4f9981-9df5-4260-892f-ac8b7a2366d9
read(`ps  | wc -l`, String)

# ╔═╡ 6d86cf25-c7f3-4f68-84af-33951e8cb071
md"""
!!! note "解決法"
    shellを明示的に実行する．
例えば以下：
"""

# ╔═╡ 4d6be723-7419-46fb-9bd5-28d8ce833477
run(`bash -c 'ps | wc -l'`)

# ╔═╡ 8c11e303-7e10-4476-936b-5a95d7cee6b5
read(`bash -c 'ps | wc -l'`, String)

# ╔═╡ b9f8446b-bf7f-4cb1-aa9a-5ab9af49f29e
md"""
## Pipeline 

"""

# ╔═╡ 746ad43e-bc23-43f3-99b5-cf8a90269c80
md"""
## References
- １から始めるJuliaプログラミング
- https://docs.julialang.org/en/v1/manual/running-external-programs/
"""

# ╔═╡ Cell order:
# ╠═f9d847b4-a692-4e43-88e0-e0ce8a8af957
# ╠═9c4ff13a-035b-48b1-a648-7a1bf24a52d3
# ╠═8e08740b-e50d-4384-bd47-ad666ad4643b
# ╠═0efd5820-5b22-44c0-b870-b39bd4e26501
# ╠═5b7bd236-cef2-4b5e-be9a-7a2f709c962e
# ╠═85e7633a-ccb0-45ae-bdd5-32f2fbfb52d0
# ╠═f174bbeb-82dd-4347-809a-ef59e1581716
# ╠═57dfcadf-680e-4ab1-8556-ce7db81c2738
# ╠═c3bd331b-24ea-4f66-baf4-827e688c9414
# ╠═6fedd808-ed72-414f-aa51-5f804afa0833
# ╠═c5ea0aee-db11-4618-82dd-52968725584c
# ╠═50968b18-c29e-491d-8b5b-fc68208cb79e
# ╠═b291b79f-5cef-4601-8640-934963ad3e84
# ╠═0d04ee89-2665-4501-81b4-8d7cc91430b5
# ╟─9d651945-bf76-407a-8a2e-09136377ec58
# ╠═ab4f9981-9df5-4260-892f-ac8b7a2366d9
# ╟─6d86cf25-c7f3-4f68-84af-33951e8cb071
# ╠═4d6be723-7419-46fb-9bd5-28d8ce833477
# ╠═8c11e303-7e10-4476-936b-5a95d7cee6b5
# ╠═b9f8446b-bf7f-4cb1-aa9a-5ab9af49f29e
# ╠═746ad43e-bc23-43f3-99b5-cf8a90269c80
