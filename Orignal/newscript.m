% f(k) = ak + bk^2 - ck^3
syms k w
eqn = .1*k*(k+8*k^2-2*k^3)-3/2*k+3/2*w == 0;
Soln = solve(eqn, k, 'Real', true)

syms a b c x
eqn1 = a*x^2 + b*x + c == 0;
solx = solve(eqn1, x)