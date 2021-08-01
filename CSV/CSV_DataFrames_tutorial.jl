### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 30d536ac-e30a-11eb-31c0-0d58eff09d6f
using CSV, DataFrames, PlutoUI, DataFramesMeta, HTTP, Plots, Pkg

# ╔═╡ c8981ac6-8bbe-4cb9-a555-251240345888
md"""
# CSV.jlとDataFrames.jlのチュートリアル
Written by Shinji Iida

"""

# ╔═╡ d6f56931-c545-4fc2-b2f5-2ad92f3104ae
TableOfContents()

# ╔═╡ 7c30b29f-bba5-4df4-b545-d5c54cece4f9
md"## バージョンの確認"

# ╔═╡ 92516988-924b-426a-8989-ac3029e81d05
with_terminal() do # with_terminal() is added to print value in Pluto.jl
	println(VERSION)
	Pkg.status(["CSV","DataFrames"])
end

# ╔═╡ 6a1d3799-5908-4e36-a17a-35a240126acc
md"CSV.File()はCSV.File objectを返します:"

# ╔═╡ 77c79828-c6b3-432c-b8f3-d93960902503
CSV.File("dataset/file.csv")

# ╔═╡ 6ad9b2f9-fcfd-4b76-a002-c4d1faf61062
md"""
## CSV.File objectをDataFrameに渡す
DataFrame objectを作成できます．
"""

# ╔═╡ 37fa15f3-9571-4e1d-be78-43b97f23a113
df1 = DataFrame(CSV.File("dataset/file.csv"))

# ╔═╡ 352ca297-d5ca-4d21-9ec1-906ad087f828
md"""
## CSV.File objectのループ
行(row)ごとに要素を取得できます．"
"""

# ╔═╡ 52b7c15e-8a43-4a7a-abe6-bb9b9ba2b1a5
with_terminal() do # with_terminal() is in PlutoUI
	for row in CSV.File("dataset/file.csv")
		println(row)
	end
end

# ╔═╡ ac8740c5-2d4e-4cb8-be64-0ddd75ff7ce4
md"""
## CSVファイルをDataFrameに変換する
### 1. パイプを使ってCSV.File objectをDataFrameに渡す
"""

# ╔═╡ fc578535-b163-41de-bf6d-ce451aa4bc7d
## Pipe
CSV.File("dataset/file.csv") |> DataFrame

# ╔═╡ ab442e7e-68d4-4dd5-9c93-cd28655de3ae
md"### 2. CSV.read()を使ってDataFrame objectを作る"

# ╔═╡ 644e9bf2-226f-45d0-92ad-939f53dd84fe
## CSV.read()
CSV.read("dataset/file.csv", DataFrame)

# ╔═╡ 5ea77f4d-d800-4662-9999-2f964f313fbf
md"## データの情報を確認"

# ╔═╡ c0ba1cb3-9392-4660-92e6-b31b5bf31d95
describe(df1)

# ╔═╡ 8180bab7-4f71-4371-8bfd-f2ab26212fac
with_terminal() do
	println("N of columns : ", ncol(df1))
	println("N of rows    : ", nrow(df1))
	println("Column names : ", names(df1), " or ", propertynames(df1))
end

# ╔═╡ 15023596-163b-4c0a-a709-63ad65b0833b
md"""
## @linqを使ったデータセットのフィルタリング
正規分布を生成するようなランダム変数のリストを作成し，そのリストに対してフィルタリングをかけてみます．

"""

# ╔═╡ 01ca0e43-9b75-49c7-af3f-37d78db2c579
begin
	N = 10^4
	r1 = randn(N) #標準正規分布を生成するようなランダム変数
	r2 = randn(N) #標準正規分布を生成するようなランダム変数
	t = 1:N #ランダム変数のステップ数と考える
	df_normal_dist = DataFrame("step"=>t, "r1"=>r1, "r2"=>r2)
	#histogram(r, bins = 40) #念の為，rが正規分布を生成するかチェック
end

# ╔═╡ 152be099-765c-48ec-b0fd-74536aedbc31
propertynames(df_normal_dist)

# ╔═╡ 4569b7c5-f64d-47cc-99cd-3d92f8f120dc
md"""
### 1. 条件に当てはまる行を抽出する
"""

# ╔═╡ 66de3d60-2d27-4d7d-9bc4-00cbe0fe0f97
dfnew = @linq df_normal_dist |> where(:r1 .> 0.0) # not ">" but ".>"  

# ╔═╡ 99037f03-e65b-45cc-a721-ce6b99b8df00
md"ちゃんとフィルタリングされたかどうか分布を確認してみると，思ったとうりに動作していることがわかる："

# ╔═╡ 86609cc6-3363-4824-bbc9-a792d24a02ea
begin
p1 = histogram(df_normal_dist.r1, bins=-4:0.5:4)
p2 = histogram(dfnew.r1, bins=-4:0.5:4)
plot(p1, p2)
end

# ╔═╡ 89364394-c115-4f50-831e-592dd1d52b7b
md"### 2. 複数条件での行抽出"

# ╔═╡ 3dea68d2-0808-407a-9d64-c6b89f1a32ca
dfnew2 = @linq df_normal_dist |> where(:r1 .> 0.0, :r2 .> 0.0)   

# ╔═╡ 885ebbdd-e76f-4cda-898b-2a984c70123d
md"動作確認のため二次元ヒストグラムをプロットしてみる："

# ╔═╡ 73f3ee1d-c15f-40f1-9a3b-04fd6086a6fd
begin 
p2d1 = histogram2d(df_normal_dist.r1, df_normal_dist.r2, bins=-4:0.5:4)
p2d2 = histogram2d(dfnew2.r1, dfnew2.r2, bins=-4:0.5:4)
plot(p2d1, p2d2)
end

# ╔═╡ eb8f09a1-5ec4-4149-beb8-8e5ad443d81f
md"""
### 以下のURLからの例https://dataframes.juliadata.org/stable/man/querying_frameworks/#DataFramesMeta.jl
"""

# ╔═╡ 93f857bb-4913-4f6d-bbe0-986fdadad130
dfex = DataFrame(name=["John", "Sally", "Roger"],
                      age=[54.0, 34.0, 79.0],
                      children=[0, 2, 4])

# ╔═╡ 4e8911f1-7457-4aa8-9b77-fb552794b089
@linq dfex |> where(:age .> 40) |> select(number_of_children=:children, :name)

# ╔═╡ faa9842f-1d80-4b77-939e-b087c0975da9
md"""
## 蛋白質の熱安定性のデータセットをいじくる
以下のパッケージを使うので，事前に`Pkg.add()`しておいてください．
- DataFrameMeta.jl (https://github.com/JuliaData/DataFramesMeta.jl)
- HTTP.jl (https://github.com/JuliaWeb/HTTP.jl)
"""

# ╔═╡ 9204d5ac-b300-49f8-8569-c9a6d7213dd2
begin 
	url = "http://marid.bioc.cam.ac.uk/sdm2/static/datasets/dataset_S2648.csv"
	df = DataFrame(CSV.File(HTTP.get(url).body)) # HTTP.get().body is from HTTP.jl 
end

# ╔═╡ 43f0126b-98fc-4ca1-9fc5-d751e830acd6
@linq df |> where(:PH .>= 6.5, :PH .<= 7.5)

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
# ╠═30d536ac-e30a-11eb-31c0-0d58eff09d6f
# ╠═d6f56931-c545-4fc2-b2f5-2ad92f3104ae
# ╠═7c30b29f-bba5-4df4-b545-d5c54cece4f9
# ╠═92516988-924b-426a-8989-ac3029e81d05
# ╠═6a1d3799-5908-4e36-a17a-35a240126acc
# ╠═77c79828-c6b3-432c-b8f3-d93960902503
# ╠═6ad9b2f9-fcfd-4b76-a002-c4d1faf61062
# ╠═37fa15f3-9571-4e1d-be78-43b97f23a113
# ╠═352ca297-d5ca-4d21-9ec1-906ad087f828
# ╠═52b7c15e-8a43-4a7a-abe6-bb9b9ba2b1a5
# ╠═ac8740c5-2d4e-4cb8-be64-0ddd75ff7ce4
# ╠═fc578535-b163-41de-bf6d-ce451aa4bc7d
# ╠═ab442e7e-68d4-4dd5-9c93-cd28655de3ae
# ╠═644e9bf2-226f-45d0-92ad-939f53dd84fe
# ╠═5ea77f4d-d800-4662-9999-2f964f313fbf
# ╠═c0ba1cb3-9392-4660-92e6-b31b5bf31d95
# ╠═8180bab7-4f71-4371-8bfd-f2ab26212fac
# ╠═15023596-163b-4c0a-a709-63ad65b0833b
# ╠═01ca0e43-9b75-49c7-af3f-37d78db2c579
# ╠═152be099-765c-48ec-b0fd-74536aedbc31
# ╟─4569b7c5-f64d-47cc-99cd-3d92f8f120dc
# ╠═66de3d60-2d27-4d7d-9bc4-00cbe0fe0f97
# ╠═99037f03-e65b-45cc-a721-ce6b99b8df00
# ╠═86609cc6-3363-4824-bbc9-a792d24a02ea
# ╠═89364394-c115-4f50-831e-592dd1d52b7b
# ╠═3dea68d2-0808-407a-9d64-c6b89f1a32ca
# ╠═885ebbdd-e76f-4cda-898b-2a984c70123d
# ╠═73f3ee1d-c15f-40f1-9a3b-04fd6086a6fd
# ╠═eb8f09a1-5ec4-4149-beb8-8e5ad443d81f
# ╠═93f857bb-4913-4f6d-bbe0-986fdadad130
# ╠═4e8911f1-7457-4aa8-9b77-fb552794b089
# ╠═faa9842f-1d80-4b77-939e-b087c0975da9
# ╠═9204d5ac-b300-49f8-8569-c9a6d7213dd2
# ╠═43f0126b-98fc-4ca1-9fc5-d751e830acd6
# ╠═7539c44f-fb93-4a56-8fb6-55a4832c8f77
# ╠═8a0196ea-0165-433f-8b3d-738c0fd1124c
# ╠═e4c68e1f-d9bd-4a1a-bf35-f705ef9af2e5
# ╠═f2b041ea-4b48-429f-ac7e-f674882c00f0
