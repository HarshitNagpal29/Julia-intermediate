using Pkg
Pkg.add("Plots")
using Plots

x = range(0, 2π, length=100)
y_sin = sin.(x)
y_cos = cos.(x)

plot(x, y_sin, label="sin(x)")
plot!(x, y_cos, label="cos(x)")

plot!(title="Sine and Cosine Waves", xlabel="x", ylabel="y", grid=true)
savefig("waves.png")

