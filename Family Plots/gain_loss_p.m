%%%%%%%%%%%%%%%%
%  Script for plotting the gain-loss utility as r changes
%   
%%%%%%%%%%%%%%%%
clear
clc
format long

% Bounds on capital
k_l = 1;       %lower bound
k_u = 1.5;      %upper bound

% Exogenous variables
%p = .2;    %Probability of catching reneging agent
R = 3;      %Interest Rate on gains from borrowed captial
r = 1.25;

sigma = .25;          % P.T. when s < s*, where parents do not invest enough back into progeny
lambda = 2;            % Loss coefficient, >= 0
eta = .2;
    
    
c_v = [.15, .25];    %changed variable, matrix of values for variable eta
colors = ['r', 'g', 'b', 'c'];


for i = 1:size(c_v,2)
    
    p = c_v(i)
    % Set up captial and wealth functions
    syms b w x y positive rational
    w_c = k_l - k_l^2*p*R/r;    % wealth cut-off for poor/rich captial borrowing

    k_p = @(w) (r-sqrt(r^2-4*p*R*r*w))/(2*p*R); %Income of those in poverty
    k_r = @(w) k_l*(R-r)+w*r;                           %Income of the rich

    % Recursion For Poverty Trap Admittance in Generations
    % s is propensity to give/invest back, w_n is new wealth for child/next
    % period
    

    alpha = sigma*(1+lambda*eta)/(1+eta*(1-sigma*(1-lambda)));

    w_4 = alpha*k_l*(R-r)/(1-alpha*r)
    w_3 = sigma*k_l*(R-r)/(1-sigma*r)
    w_2 = sigma*r*(1-sigma*R)*(R-r)/(p*R*(1-sigma*r)^2)
    w_1 = alpha*r*(1-alpha*R)*(R-r)/(p*R*(1-alpha*r)^2)

    b_t_4 = alpha*(k_l*(R-r)+w*r)
    b_t_3 = sigma*(k_l*(R-r)+w*r)
    b_t_2 = sigma*(k_p(w)*(R-r)+w*r)
    b_t_1 = alpha*(k_p(w)*(R-r)+w*r)

    b_t(i) = piecewise((0 <= w)&(w < w_1), b_t_1, (w_1 <= w)&(w <= w_2), w, (w_2 < w)&(w < w_c), b_t_2, (w_c <= w)&(w < w_3), b_t_3, (w_3 <= w)&(w <= w_4), w, w_4 < w, b_t_4);

    %{
    V_p = @(w) sigma*(r-sqrt(r^2-4*p*R*r*w))/(2*p*R)*R*(1-(r-sqrt(r^2-4*p*R*r*w))/(2*R)); %Income of those in poverty
    V_r = @(w) sigma*(k_l*(R-r)+w*r);                           %Income of the rich
    V = piecewise(w <= w_c, V_p, w > w_c, V_r);
    %}

    %Intersections with the 45deg line
    %[solw,solb] = solve(b==w, b==V_p)

    
    cv_state = "p = " + num2str(p);
    cv_lgd(i) = cv_state;
    

end
figure(1)
fplot(b_t)
hold on;
fplot([x y], '--k', 'DisplayName', '45 Deg')
xlim([.1, .9])
ylim([.1, .9])
title('Reference Dependent Utility: p Variation')
xlabel('w_t');
ylabel('b_t'); 
legend(cv_lgd);   
set(gcf, 'Position',  [300, 100, 1000, 666])  
