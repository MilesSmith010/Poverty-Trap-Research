function f = b_original(w)
k_l = 1;       %lower bound
k_u = 1.5;      %upper bound

% Exogenous variables
p = .2;    %Probability of catching reneging agent
R = 3;      %Interest Rate on gains from borrowed captial
r = 1.2;

w_c = k_l - k_l^2*p*R/r;    % wealth cut-off for poor/rich captial borrowing

sigma = .26;          % P.T. when s < s*, where parents do not invest enough back into progeny



    if (w_c > w)
        f = sigma*(R*k_p(w)*(1-p*k_p(w)));

    elseif (w_c <= w)
        f = sigma*(k_l*(R-r)+w*r);
    end
end