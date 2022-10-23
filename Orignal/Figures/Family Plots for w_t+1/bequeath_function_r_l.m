%%%%%%%%%%%%%%%%
%  Script for plotting the bequeath function, b = w_{t+1} = s*V(w_{t})
%  Using Banerjee, Newman 1994 as basis for analysis
%  Exogenous variables: w, k_l, k_u, p, R, r
%%%%%%%%%%%%%%%%
clear
clc
format long

% Bounds on capital
% Bounds on capital
k_l = 1;       %lower bound
k_u = 1.5;      %upper bound

% Exogenous variables
p = .2;    %Probability of catching reneging agent
R = 3;      %Interest Rate on gains from borrowed captial
%r = 1.2;

sigma = .26;

c_v = [1.5, 1];    %changed variable, matrix of values for variable eta
colors = ['r', 'g', 'b', 'c'];

% Conditions on variables
for i = 1:size(c_v,2)
    
    r = c_v(i);
  
    % Set up captial and wealth functions
    syms w x y positive rational
    w_c = k_l - k_l^2*p*R/r;    % wealth cut-off for poor/rich captial borrowing

    V_p = @(w) (r-sqrt(r^2-4*p*R*r*w))/(2*p*R)*R*(1-(r-sqrt(r^2-4*p*R*r*w))/(2*R)); %Income of those in poverty
    V_r = @(w) k_l*(R-r)+w*r;                           %Income of the rich

    V = piecewise(w <= w_c, V_p, w > w_c, V_r);         %Total income based on wealth

    b_t(i) = sigma*V;
    
    cv_state = "r = " + num2str(r);
    cv_lgd(i) = cv_state;
    
end
figure(1)
fplot(b_t, '-', 'LineWidth', 2)
hold on;
fplot([x y], '--k', 'DisplayName', '45 Deg')
xlim([0, 1])
ylim([0, 1])
title('Baseline Model: r Variation')
xlabel('w_t');
ylabel('b_t'); 
legend(cv_lgd);   
set(gcf, 'Position',  [300, 100, 1000, 666])  
