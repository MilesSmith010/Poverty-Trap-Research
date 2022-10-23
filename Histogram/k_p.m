function g = k_p(x)
% Exogenous variables
p = .2;    %Probability of catching reneging agent
R = 3;      %Interest Rate on gains from borrowed captial
r = 1.2;
    g=(r-sqrt(r^2-4*p*R*r*x))/(2*p*R);
end