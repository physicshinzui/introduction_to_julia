### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ ec37d760-6455-4f55-b531-7b6fd9e9dfa9
using CSV, PlutoUI

# ╔═╡ 6f45b140-da08-11eb-2944-3dc36630df45
md"""
# Getting stated: CSV.jl

Written by Shinji Iida

Date : 1.7.2021

In this notebook, we shall see main functions in CSV.jl and learn how to use them. 

- `CSV.File(source; kwargs...) => CSV.File`: Read a UTF-8 CSV input and return a CSV.File object.
- `CSV.Rows(source; kwargs...) => CSV.Rows`: Read a csv input returning a CSV.Rows object.

Kinda advanced note: 
- if you start julia by `julia -t 4` or with the julia environment variable `JULIA_NUM_THREADS`, which both mean 4 threads are used, `CSV.File()` follows it when it reads a file (Might be efficient when reading a big file).
"""

# ╔═╡ f82fd21f-8031-4c8b-ac73-5edaab1333ed
PlutoUI.TableOfContents()

# ╔═╡ f4ffa22a-26b3-4442-97a6-50f3084789d3
VERSION

# ╔═╡ cdc2e3f3-c901-4841-9795-90317bf96cf2
md"## Read rows"

# ╔═╡ c5c5f1e8-9bdd-4883-8f90-52f03ca6c1a7
obj = CSV.File("ex1.csv") # CSV.File object is created.

# ╔═╡ 78ed1716-7fa9-41f8-924f-1532a899e51f
md"To extract rows of the object, we might do this:"

# ╔═╡ 1fa34f37-b62d-48bd-a233-0173fb9a2cdf
with_terminal() do
	for row in obj
		println(row)
	end
end

# ╔═╡ 4d6f2e6c-d0cf-4079-b023-7d8cd378a755
md"Hoever, you notice `Symbol(\" col2\")`... I did not understand what was going on here. If we keep it, we can't extract rows like:"

# ╔═╡ 40ed8313-b30b-4e59-b3dd-29a521fe94a3
with_terminal() do
	for row in obj
		println(row.col1, row.col2)
	end
end

# ╔═╡ 10e71a23-c8b6-4f6c-a697-61f025df0d4e
md"## How can we avoid the bizarre parsing of columns? 
We can use the option `normalizenames=true`, which is by defalut `normalizenames=false`." 

# ╔═╡ 2969582e-b4d9-404d-ac4e-4df420725a47
with_terminal() do
	for row in CSV.File("ex1.csv"; normalizenames=true)
		println("$row.col1, $row.col2, $row.col3")
	end
end

# ╔═╡ Cell order:
# ╠═6f45b140-da08-11eb-2944-3dc36630df45
# ╠═ec37d760-6455-4f55-b531-7b6fd9e9dfa9
# ╠═f82fd21f-8031-4c8b-ac73-5edaab1333ed
# ╠═f4ffa22a-26b3-4442-97a6-50f3084789d3
# ╠═cdc2e3f3-c901-4841-9795-90317bf96cf2
# ╠═c5c5f1e8-9bdd-4883-8f90-52f03ca6c1a7
# ╟─78ed1716-7fa9-41f8-924f-1532a899e51f
# ╠═1fa34f37-b62d-48bd-a233-0173fb9a2cdf
# ╠═4d6f2e6c-d0cf-4079-b023-7d8cd378a755
# ╠═40ed8313-b30b-4e59-b3dd-29a521fe94a3
# ╠═10e71a23-c8b6-4f6c-a697-61f025df0d4e
# ╠═2969582e-b4d9-404d-ac4e-4df420725a47
