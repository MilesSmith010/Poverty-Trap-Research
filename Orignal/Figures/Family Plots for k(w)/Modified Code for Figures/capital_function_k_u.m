%%%%%%%%%%%%%%%%
%  Script for plotting capital (k) as a function of wealth(w)
%  Fixed exogenous variables, with discrete variable R values
%  Using Banerjee, Newman 1994 as basis for analysis
%%%%%%%%%%%%%%%%
clear
format long

% Bounds on capital
k_l = 1;       %lower bound
k_u = [4, 3, 2, 1];    %upper bound

% Exogenous variables
p = .1;    %Probability of catching reneging agent
R = 5;      %Interest Rate on gains from borrowed captial, R > r 

r = 4.01;   %Interest rate agent must repay on borrowed captial, r > 1

for i = 1:4
    if R <= r
        disp("R must be strictly greater than r")
    return
    end
    if r <= 2*p*R*k_u(i)
        disp("r must be strictly greater than 2*p*R*k_u: " + num2str(2*p*R*k_u(i)))
    return
    end
    % Set up captial and wealth functions
    syms w k positive rational
    w_c = k_l - k_l^2*p*R/r;

    % For additional verification, plotting increasing and concave functions
    % for returns to capital borrowed, f(k), and probability of catching
    % reneging, pi(k)
    f = @(k) R*min(k,k_l);
    pi = @(k) p*min(k,k_u(i));
    %{
    figure(1)
    fplot(f)
    xlim([0,1])
    ylim([0,1])
    title('f(k) := R*min(k,k_l)')
    xlabel('k')
    ylabel('f(k)')

    figure(2)
    fplot(pi)
    xlim([0,2])
    ylim([0,1])
    title('Pi(k) := p*min(k,k_u)')
    xlabel('k')
    ylabel('Pi(k)')
    %}

    % Piecewise function for capital, k(w)
    k_p = @(w) (r - sqrt(r^2-4*p*R*r*w))/(2*p*R);  % Capital for the poor, below w_c
    k_r = @(w) k_l;                    % Capital for the rich, above w_c

    k = piecewise(w <= w_c, k_p, w> w_c, k_r);

    k_u_state = "k_u = " + num2str(k_u(i));
    k_u_lgd(i) = k_u_state;
    figure(3)
    fplot(k)
    xlim([0,1])
    ylim([0,2])
    title("k(w) with Variable k_u Value")
    xlabel('w')
    ylabel('k(w)')
    hold on;
    legend(k_u_lgd);
end