### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ c305f2ce-44e4-4eab-9833-a40c9d93767f
using Plots, PlutoUI

# ╔═╡ 83617fec-9cd9-48b1-84f8-12fb68dfa9ce
md"""
# Newton-Raphson method 

The method is used to find a solution to $f(x) = 0$ by using the derivative $f'(x)$.
Suppose that $\alpha$ is the true value of the solution and a adjacent value $x_k$. Then, the value $f(\alpha)$ can be approximated by using Tayler expansion: 

$f(\alpha) \approx f(x_k) + f'(x_k)(\alpha - x_k),$

(more than second order terms are omitted).

Since $f(\alpha)=0$, 

$0 \approx f(x_k) + f'(x_k)(\alpha - x_k) \Rightarrow \alpha \approx x_{k+1} = x_k - \frac{f(x_k)}{f'(x_k)}.$

This is an approximated solution to $f(x) = 0$.
Assigning a initial value with $x_k$ and iterating, the approximated solution can be obtained.

- (1) Set an initial value of $x_k$ and $\epsilon$, which is called "Accuracy". 
- (2) Update $x_k$ iteratively by using the above equation.
- (3) If the difference $|x_{k+1} - x_k|\le \epsilon$, then stop the iteration.
"""

# ╔═╡ c52a042d-e1bc-45a3-8d10-7a72f53910bf
md"""
## Ex1: Calculation of root
An example of the applications of Netwon's method is to calculate the root of a real number, $a$. 
This problem can be rephrased like: 
Find $x$ that satisfies 

$f(x) = x^2 - a = 0.$

When you get $x$ that satisfies the above equation, $x^2$ equates $a$, and hence $x=\sqrt{a}$, which you want (the negative sign was ignored here). 

Since the derivative is $f'(x)=2x$, the discritized equation becomes 

$x_{k+1} = x_k - \frac{x_k^2 - a}{2x_k}.$

Now, you solve this equation iteratively.

"""

# ╔═╡ 1d9f47d8-cf82-46f1-adf2-1c4edd18c5ce
function calc_root_by_newton(a, ϵ, n_steps)
    xk = a
    errors = []
    for i in 1:n_steps
        xk_suc = xk - (xk^2 - a) / 2xk
        err = abs(xk_suc - xk)
        push!(errors, err) 
        if ϵ > err
            break
        end
        xk = xk_suc
    end
    return xk, errors
end

# ╔═╡ ec39b2ac-dcf1-4110-916f-5a7f96d0520a
begin
target_num = 2
ϵ          = 10^-9 #Accuracy
n_steps    = 10^3
xk, errors = calc_root_by_newton(target_num, ϵ , n_steps)
println("The root of $target_num = $xk")
end

# ╔═╡ c2715eea-0f94-470b-84f1-6b8d1234d2ee
plot(errors, xlabel="No. of Iteration", ylabel="ϵ", label="", linewidth=3)

# ╔═╡ Cell order:
# ╠═83617fec-9cd9-48b1-84f8-12fb68dfa9ce
# ╠═c305f2ce-44e4-4eab-9833-a40c9d93767f
# ╠═c52a042d-e1bc-45a3-8d10-7a72f53910bf
# ╠═1d9f47d8-cf82-46f1-adf2-1c4edd18c5ce
# ╠═ec39b2ac-dcf1-4110-916f-5a7f96d0520a
# ╠═c2715eea-0f94-470b-84f1-6b8d1234d2ee
