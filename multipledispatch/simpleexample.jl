### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ c13e4d4a-fa30-11eb-34ca-4b276c1f09d1
VERSION

# ╔═╡ 1620543e-9c1f-4335-bd5d-85a52ea418fb
md"""
> Base.show関数に，引数がユーザー側が独自に定義した型のオブジェクトを含む場合のメソッドを追加することです．その追加の結果，ユーザ定義の型のオブジェクトのREPLなどでの表示のされ方が変化します．
See https://twitter.com/genkuroki/status/1425193725139984386
"""

# ╔═╡ 2eab1bd8-ebc0-488e-a167-e58bc7d12a59
module My 

struct Hello{T}
    a::T
end

function Base.show(io::IO, x::Hello)
    print(io, "Hello, ")
    show(io, x.a)
    print(io, '!')
end
end

# ╔═╡ 1f6b3103-7aaf-44b3-8656-552207121c55
My.Hello("Julia")

# ╔═╡ 2cf2d197-7482-468f-b4f2-1e3f3ac80dd7
md"# Another try"

# ╔═╡ 5846cf81-d8c3-4fe2-a692-d4422a00cb8e
module My2

struct Foo{T}
	a::T
end
end

# ╔═╡ 724fe4d7-fb29-4058-83ed-8717d0ba2ddb
My2.Foo(1)

# ╔═╡ 64dcf953-1419-450f-9bb1-b10506749f69
module My3

struct Foo{T}
	a::T
end

# moduleを読み込んで，composite typeの初期化を行うと，以下の関数が呼び出されるらしい．
# いまだによく動作がわかっていない．
function Base.show(io::IO, x::Foo)
	print(io, "Foo,",  x.a, '!')
end
end

# ╔═╡ 6fbebd1c-6e74-42dc-9f47-22aec0a6258e
My3.Foo("BOO")

# ╔═╡ d127971d-f796-4bbc-96a4-726c537032f0


# ╔═╡ Cell order:
# ╠═c13e4d4a-fa30-11eb-34ca-4b276c1f09d1
# ╠═1620543e-9c1f-4335-bd5d-85a52ea418fb
# ╠═2eab1bd8-ebc0-488e-a167-e58bc7d12a59
# ╠═1f6b3103-7aaf-44b3-8656-552207121c55
# ╠═2cf2d197-7482-468f-b4f2-1e3f3ac80dd7
# ╠═5846cf81-d8c3-4fe2-a692-d4422a00cb8e
# ╠═724fe4d7-fb29-4058-83ed-8717d0ba2ddb
# ╠═64dcf953-1419-450f-9bb1-b10506749f69
# ╠═6fbebd1c-6e74-42dc-9f47-22aec0a6258e
# ╠═d127971d-f796-4bbc-96a4-726c537032f0
