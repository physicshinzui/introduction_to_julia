### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 30d536ac-e30a-11eb-31c0-0d58eff09d6f
using CSV, DataFrames, PlutoUI

# ╔═╡ c8981ac6-8bbe-4cb9-a555-251240345888
md"""
# CSV.jlとDataFrame.jlの使用例
Written by Shinji Iida
"""

# ╔═╡ f2fd3929-74f5-4289-88d0-0a5d48c4e6fd
VERSION

# ╔═╡ 2f629cc9-f391-4c71-89f3-76cc4b40e8ae
csv_reader = CSV.File("file.csv")

# ╔═╡ 483b0b82-d2b4-43d7-b9f6-14de2d89b22c
typeof(csv_reader)

# ╔═╡ 1b731ea2-a0b4-4b07-9a04-816b380d61ed
md"## CSV.File('file.csv')でCSV objectを作成して，DataFrame()に食わせる"

# ╔═╡ 77c79828-c6b3-432c-b8f3-d93960902503
begin
csv_obj = CSV.File("file.csv")
#typeof(csv_obj)
end

# ╔═╡ 37fa15f3-9571-4e1d-be78-43b97f23a113
df1 = DataFrame(CSV.File("file.csv"))

# ╔═╡ 52b7c15e-8a43-4a7a-abe6-bb9b9ba2b1a5
# Iterate csv_reader: rows are given
with_terminal() do # with_terminal() is in PlutoUI
	for row in csv_reader
		println(row)
	end
end

# ╔═╡ fc578535-b163-41de-bf6d-ce451aa4bc7d
## Pipe
df2 = CSV.File("file.csv") |> DataFrame

# ╔═╡ 644e9bf2-226f-45d0-92ad-939f53dd84fe
## CSV.read()
df3 = CSV.read("file.csv", DataFrame)

# ╔═╡ 15023596-163b-4c0a-a709-63ad65b0833b


# ╔═╡ b2268c84-34af-4172-81ec-447c3f85552d


# ╔═╡ Cell order:
# ╠═c8981ac6-8bbe-4cb9-a555-251240345888
# ╠═f2fd3929-74f5-4289-88d0-0a5d48c4e6fd
# ╠═30d536ac-e30a-11eb-31c0-0d58eff09d6f
# ╠═2f629cc9-f391-4c71-89f3-76cc4b40e8ae
# ╠═483b0b82-d2b4-43d7-b9f6-14de2d89b22c
# ╠═1b731ea2-a0b4-4b07-9a04-816b380d61ed
# ╠═77c79828-c6b3-432c-b8f3-d93960902503
# ╠═37fa15f3-9571-4e1d-be78-43b97f23a113
# ╠═52b7c15e-8a43-4a7a-abe6-bb9b9ba2b1a5
# ╠═fc578535-b163-41de-bf6d-ce451aa4bc7d
# ╠═644e9bf2-226f-45d0-92ad-939f53dd84fe
# ╠═15023596-163b-4c0a-a709-63ad65b0833b
# ╠═b2268c84-34af-4172-81ec-447c3f85552d
