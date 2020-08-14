# This file was generated, do not modify it. # hide
using Latexify
empty_ary = Array{Float32, 2}(undef, 2, 2)
ls = latexify(empty_ary) # this is an L string
s = replace(ls.s, "\\begin{equation}" => "\$\$") # hide
s = replace(s, "\\end{equation}" => "\$\$") # hide
println(s) # hide