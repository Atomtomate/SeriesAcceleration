using Pkg
Pkg.activate(".")
using SeriesAcceleration

s_test = 1 ./ (1:100) .^ 2;
An = cumsum(s_test);
w2 = Richardson(1:5, [0,1]);
acc_csum(An[1:5], w2)
