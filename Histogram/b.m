function f = b(w)
k_l = 1;       %lower bound
k_u = 1.5;      %upper bound

% Exogenous variables
p = .2;    %Probability of catching reneging agent
R = 3;      %Interest Rate on gains from borrowed captial
r = 1.2;

w_c = k_l - k_l^2*p*R/r;    % wealth cut-off for poor/rich captial borrowing

sigma = .26;          % P.T. when s < s*, where parents do not invest enough back into progeny
lambda = 2;            % Loss coefficient, >= 0
eta = .2;

alpha = sigma*(1+lambda*eta)/(1+eta*(1-sigma*(1-lambda)));
w_4 = alpha*k_l*(R-r)/(1-alpha*r);
w_3 = sigma*k_l*(R-r)/(1-sigma*r);
w_2 = sigma*r*(1-sigma*R)*(R-r)/(p*R*(1-sigma*r)^2);
w_1 = alpha*r*(1-alpha*R)*(R-r)/(p*R*(1-alpha*r)^2);
    if (0 <= w)&&(w < w_1)
        f = alpha*(k_p(w)*(R-r)+w*r);

    elseif (w_1 <= w)&&(w <= w_2)
        f = w;

    elseif (w_2 < w)&&(w< w_c)
        f = sigma*(k_p(w)*(R-r)+w*r);

    elseif (w_c <= w)&&(w < w_3)
        f = sigma*(k_l*(R-r)+w*r);

    elseif (w_3 <= w)&&(w <= w_4)
        f = w;

    elseif w_4 < w
        f = alpha*(k_l*(R-r)+w*r);
    end
end