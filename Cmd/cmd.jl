### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 9c4ff13a-035b-48b1-a648-7a1bf24a52d3
using PlutoUI

# ╔═╡ 883b0712-f3f6-11eb-05a4-e98c7c80cf65
md"""
# How to Operate Shell From Julia

## References
- １から始めるJuliaプログラミング
"""

# ╔═╡ 8e08740b-e50d-4384-bd47-ad666ad4643b
TableOfContents()

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

# ╔═╡ 9d651945-bf76-407a-8a2e-09136377ec58


# ╔═╡ Cell order:
# ╠═883b0712-f3f6-11eb-05a4-e98c7c80cf65
# ╠═9c4ff13a-035b-48b1-a648-7a1bf24a52d3
# ╠═8e08740b-e50d-4384-bd47-ad666ad4643b
# ╠═5b7bd236-cef2-4b5e-be9a-7a2f709c962e
# ╠═85e7633a-ccb0-45ae-bdd5-32f2fbfb52d0
# ╠═f174bbeb-82dd-4347-809a-ef59e1581716
# ╠═57dfcadf-680e-4ab1-8556-ce7db81c2738
# ╠═c3bd331b-24ea-4f66-baf4-827e688c9414
# ╠═6fedd808-ed72-414f-aa51-5f804afa0833
# ╠═c5ea0aee-db11-4618-82dd-52968725584c
# ╠═50968b18-c29e-491d-8b5b-fc68208cb79e
# ╠═b291b79f-5cef-4601-8640-934963ad3e84
# ╠═9d651945-bf76-407a-8a2e-09136377ec58
