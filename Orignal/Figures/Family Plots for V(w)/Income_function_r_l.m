%%%%%%%%%%%%%%%%
%  Script for plotting Income V(w) families
%  Using Banerjee, Newman 1994 as basis for analysis
%  Exogenous variables: w, k_l, k_u, p, R, r
%%%%%%%%%%%%%%%%
clear
clc
format long

% Bounds on capital
k_l = 1;       %lower bound
k_u = 2;      %upper bound

% Exogenous variables
p = .1;    %Probability of catching reneging agent
R = 3;      %Interest Rate on gains from borrowed captial

r = [2.5, 2, 1.5, 1.21];    %Interest rate agent must repay on borrowed captial

% Conditions on variables
for i = 1:4 
    if R <= r(i)
        disp("R must be strictly greater than r")
        return
    end
    if r(i) <= 2*p*R*k_u
        disp("r must be strictly greater than 2*p*R*k_u: " + num2str(2*p*R*k_u))
        return
    end
    2*p*R*k_u;
    % Set up captial and wealth functions
    syms w x y positive rational
    w_c = k_l - k_l^2*p*R/r(i)   % wealth cut-off for poor/rich captial borrowing

    V_p = @(w) (r(i)-sqrt(r(i)^2-4*p*R*r(i)*w))/(2*p*R)*R*(1-(r(i)-sqrt(r(i)^2-4*p*R*r(i)*w))/(2*R)); %Income of those in poverty
    V_r = @(w) k_l*(R-r(i))+w*r(i);                           %Income of the rich

    V = piecewise(w <= w_c, V_p, w > w_c, V_r);         %Total income based on wealth
    
    r_state = "r = " + num2str(r(i));
    r_lgd(i) = r_state;
    
    figure(1)
    fplot(V)
    xlim([0,2])
    ylim([0,2])
    title('V(w) with variable r')
    xlabel('w');
    ylabel('V(w)');    
    hold on;
    legend(r_lgd);
    
    %hold;
    %refline = [x y];
    %fplot(refline, '--r');

    % Recursion For Poverty Trap Admittance in Generations
    % s is propensity to give/invest back, w_n is new wealth for child/next
    % period
    %{
    s = .9;          % P.T. when s < s*, where parents do not invest enough back into progeny
    w_n = s*V;

    figure(2)
    fplot(w_n)
    xlim([0,1])
    ylim([0,1])
    title('w_n := s*V(w)')
    xlabel('w_t');
    ylabel('w_{t+1}');
    hline = refline([1 0]);
    hline.Color = 'r';
    hline.LineStyle = ':';
    %hold;
    %refline = [x y];
    %fplot(refline, '--r');
    %}

end
hline = refline([1 0]);
hline.Color = 'r';
hline.LineStyle = ':';
