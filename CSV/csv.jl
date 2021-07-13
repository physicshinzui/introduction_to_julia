### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 30d536ac-e30a-11eb-31c0-0d58eff09d6f
using CSV, DataFrames, PlutoUI, DataFramesMeta, HTTP, Plots

# ╔═╡ c8981ac6-8bbe-4cb9-a555-251240345888
md"""
# CSV.jlとDataFrame.jlの使用例
Written by Shinji Iida
"""

# ╔═╡ f2fd3929-74f5-4289-88d0-0a5d48c4e6fd
VERSION

# ╔═╡ 2f629cc9-f391-4c71-89f3-76cc4b40e8ae
csv_reader = CSV.File("dataset/file.csv")

# ╔═╡ 483b0b82-d2b4-43d7-b9f6-14de2d89b22c
typeof(csv_reader)

# ╔═╡ 1b731ea2-a0b4-4b07-9a04-816b380d61ed
md"## CSV.File('file.csv')でCSV objectを作成して，DataFrame()に食わせる"

# ╔═╡ 77c79828-c6b3-432c-b8f3-d93960902503
begin
csv_obj = CSV.File("dataset/file.csv")
#typeof(csv_obj)
end

# ╔═╡ 37fa15f3-9571-4e1d-be78-43b97f23a113
df1 = DataFrame(CSV.File("dataset/file.csv"))

# ╔═╡ 52b7c15e-8a43-4a7a-abe6-bb9b9ba2b1a5
# Iterate csv_reader: rows are given
with_terminal() do # with_terminal() is in PlutoUI
	for row in csv_reader
		println(row)
	end
end

# ╔═╡ fc578535-b163-41de-bf6d-ce451aa4bc7d
## Pipe
df2 = CSV.File("dataset/file.csv") |> DataFrame

# ╔═╡ 644e9bf2-226f-45d0-92ad-939f53dd84fe
## CSV.read()
df3 = CSV.read("dataset/file.csv", DataFrame)

# ╔═╡ 15023596-163b-4c0a-a709-63ad65b0833b
md"""
## 特定の行だけを抽出する
使うパッケージ
- DataFrameMeta.jl
- HTTP.jl
まずはデータを読み込み，dataframeを作ると以下のようになります．
"""

# ╔═╡ b2268c84-34af-4172-81ec-447c3f85552d
begin 
	url = "http://marid.bioc.cam.ac.uk/sdm2/static/datasets/dataset_S2648.csv"
	df = DataFrame(CSV.File(HTTP.get(url).body)) # HTTP.get().body is from HTTP.jl 
end

# ╔═╡ 7539c44f-fb93-4a56-8fb6-55a4832c8f77
@linq df_ph_filtered = df |> where(:PH .>= 6.5, :PH .<= 7.5) |> groupby(:MUTANT_RES)

# ╔═╡ 8a0196ea-0165-433f-8b3d-738c0fd1124c
df_ph_filtered.keymap

# ╔═╡ e4c68e1f-d9bd-4a1a-bf35-f705ef9af2e5
df_ph_filtered[1]

# ╔═╡ f2b041ea-4b48-429f-ac7e-f674882c00f0
histogram(df_ph_filtered[9].EXP_DDG, bins=50)

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
# ╠═7539c44f-fb93-4a56-8fb6-55a4832c8f77
# ╠═8a0196ea-0165-433f-8b3d-738c0fd1124c
# ╠═e4c68e1f-d9bd-4a1a-bf35-f705ef9af2e5
# ╠═f2b041ea-4b48-429f-ac7e-f674882c00f0
