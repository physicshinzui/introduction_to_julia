### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 1240ec61-cd4d-4c78-a9e5-79d9a4d87a22
begin
	using Pkg
	Pkg.activate(".")
	using PlutoUI
	with_terminal() do 
		Pkg.status()
		versioninfo()
	end
end

# ╔═╡ 04423ec3-395c-4608-9475-5edb019e4825
using Flux: gradient

# ╔═╡ d90fd4a2-03a4-11ec-0771-199ea83180f1
md"""
# Deep learning with Flux


Reference:
- https://github.com/FluxML/model-zoo/blob/master/tutorials/60-minute-blitz/60-minute-
blitz.jl

"""

# ╔═╡ c308c42e-5208-4d22-86c8-2883ef4b1cdd
TableOfContents()

# ╔═╡ 5bb0eee3-82d5-4d57-9da8-044196b6ab3b
md"""
## 自動微分
### 簡単な例

"""

# ╔═╡ cc6d98e8-0233-48b4-9022-c3bf7fbf09bb
f(x) = 3x^2 + 2x + 1

# ╔═╡ b0b17187-2b84-42de-b664-c72919280ee6
f(5)

# ╔═╡ 4f8914fc-e28a-469d-bdd9-a78488aaaae2
df(x) = gradient(f, x)[1]

# ╔═╡ e3552185-05ac-4d15-a3d7-5d92ba1112b6
df(5)

# ╔═╡ 6a18035a-97fb-46ac-8ccd-04cb3d0c8b22
ddf(x) = gradient(df, x)[1]

# ╔═╡ 7dbf2ccb-30d2-4375-8541-6c6ef1079fdb
ddf(5)

# ╔═╡ 7e129d6c-c3a7-4a1c-8016-16e6c03745d4
md"""
### もっと複雑な関数の微分
$\sin(x) = \sum_{k=0}^\infty \frac{(-1)^kx^{1+2k}}{(1+2k)!}$
を考えます．$k=5$までで近似した関数の微分をADでやってみます．
"""

# ╔═╡ 55873517-efb0-4964-b359-3d9654bd5bd8
mysin(x) = sum((-1)^k*x^(1+2k)/factorial(1+2k) for k in 0:5)

# ╔═╡ eb0de624-5abd-4a9a-b677-1b64d252ebf6
x = 0.5

# ╔═╡ 948c3b3b-839d-44fb-8533-85fd78589be8
mysin(x), gradient(mysin, x)

# ╔═╡ 53aa2a58-ddcd-46f4-ba02-c09f47bdafff
sin(x), cos(x)

# ╔═╡ 7243cd8b-4f35-45b6-a56f-a1bb5c1d052a
md"確かに５次の項までで打ち切ったsinのテイラー展開の微分した値は，真の値に近いことが確認できました．"

# ╔═╡ 3f98e93b-6289-4ec7-9b71-753b26357b93
md"""
## 多変数関数の微分

### Loss functionな例
一変数の関数だけでなくて，多変数関数の微分も`gradient`はできます．
例えば，以下の関数を考えます：
"""

# ╔═╡ 44350718-e94e-4738-99fe-5770d45c66f3
myloss(W, b, x) = sum(W*x .+ b) 

# ╔═╡ f6dc0e42-e77d-4a80-8711-7f925d5d709c
md"これは行列$W$,配列$b$ and $x$を受け取る関数です．"

# ╔═╡ 950353f0-a79c-446c-8d6f-d089e575c8bd
begin
	W = rand(3, 5) 
	b = zeros(3) 
	xx = rand(5) 
end

# ╔═╡ 0eab7c36-b910-49b8-8d0c-8720eba4bb7f
gradient(myloss, W, b, xx) 

# ╔═╡ c8cdc710-6f3c-4c0e-84f0-083932b1b768
md"これで三つの変数W, b, and xxそれぞれに対するgradientが計算できました．"

# ╔═╡ 64a773c2-1914-4942-ad65-fb08f42f3fb4
md"""
### 簡単な例
上の例だと手でチェックするのが面倒なので，以下の関数の偏微分を考えてみます：

$f(x,y) = x^2y$
$\frac{\partial f(x,y)}{\partial x} = 2xy$
$\frac{\partial f(x,y)}{\partial y} = x^2$

"""

# ╔═╡ 092bfa30-62cf-4476-a78b-27f4f6fb4870
fs(x,y) = x^2*y 

# ╔═╡ a7efaba1-5775-4519-94a9-1d8810817668
gradient(fs, 1, 1)

# ╔═╡ a697acc5-2fed-442d-8daf-d59c7e006d1a
md"""

!!! note "何をしているか"
	gradientがfsの各変数を偏微分してベクトルができる．それぞれの要素の導関数にx=1, y=1を代入した結果が返ってきています．
"""

# ╔═╡ 7b558433-966f-4fba-8123-e3b22374bbeb


# ╔═╡ Cell order:
# ╠═d90fd4a2-03a4-11ec-0771-199ea83180f1
# ╠═1240ec61-cd4d-4c78-a9e5-79d9a4d87a22
# ╟─c308c42e-5208-4d22-86c8-2883ef4b1cdd
# ╠═5bb0eee3-82d5-4d57-9da8-044196b6ab3b
# ╠═cc6d98e8-0233-48b4-9022-c3bf7fbf09bb
# ╠═b0b17187-2b84-42de-b664-c72919280ee6
# ╠═04423ec3-395c-4608-9475-5edb019e4825
# ╠═4f8914fc-e28a-469d-bdd9-a78488aaaae2
# ╠═e3552185-05ac-4d15-a3d7-5d92ba1112b6
# ╠═6a18035a-97fb-46ac-8ccd-04cb3d0c8b22
# ╠═7dbf2ccb-30d2-4375-8541-6c6ef1079fdb
# ╠═7e129d6c-c3a7-4a1c-8016-16e6c03745d4
# ╠═55873517-efb0-4964-b359-3d9654bd5bd8
# ╠═eb0de624-5abd-4a9a-b677-1b64d252ebf6
# ╠═948c3b3b-839d-44fb-8533-85fd78589be8
# ╠═53aa2a58-ddcd-46f4-ba02-c09f47bdafff
# ╠═7243cd8b-4f35-45b6-a56f-a1bb5c1d052a
# ╠═3f98e93b-6289-4ec7-9b71-753b26357b93
# ╠═44350718-e94e-4738-99fe-5770d45c66f3
# ╠═f6dc0e42-e77d-4a80-8711-7f925d5d709c
# ╠═950353f0-a79c-446c-8d6f-d089e575c8bd
# ╠═0eab7c36-b910-49b8-8d0c-8720eba4bb7f
# ╠═c8cdc710-6f3c-4c0e-84f0-083932b1b768
# ╠═64a773c2-1914-4942-ad65-fb08f42f3fb4
# ╠═092bfa30-62cf-4476-a78b-27f4f6fb4870
# ╠═a7efaba1-5775-4519-94a9-1d8810817668
# ╠═a697acc5-2fed-442d-8daf-d59c7e006d1a
# ╠═7b558433-966f-4fba-8123-e3b22374bbeb
