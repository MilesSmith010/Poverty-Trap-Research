%%%%%%%%%%%%%%%%
%  Script for plotting the bequeath function, b = w_{t+1} = s*V(w_{t})
%  Using Banerjee, Newman 1994 as basis for analysis
%  Exogenous variables: w, k_l, k_u, p, R, r
%%%%%%%%%%%%%%%%
clear
clc
format long

% Bounds on capital
k_l = 1;       %lower bound
k_u = 1.5;      %upper bound

% Exogenous variables
p = .2;    %Probability of catching reneging agent
R = 3;      %Interest Rate on gains from borrowed captial
r = 1.2;


% Conditions on variables
for i = 1:4 
    if R <= r
        disp("R must be strictly greater than r")
        return
    end
    if r <= 2*p*R*k_u
        disp("r must be strictly greater than 2*p*R*k_u: " + num2str(2*p(i)*R*k_u))
        return
    end
    2*p*R*k_u
    % Set up captial and wealth functions
    syms w x y positive rational
    w_c = k_l - k_l^2*p*R/r;    % wealth cut-off for poor/rich captial borrowing

    V_p = @(w) (r-sqrt(r^2-4*p*R*r*w))/(2*p*R)*R*(1-(r-sqrt(r^2-4*p*R*r*w))/(2*R)); %Income of those in poverty
    V_r = @(w) k_l*(R-r)+w*r;                           %Income of the rich

    V = piecewise(w <= w_c, V_p, w > w_c, V_r);         %Total income based on wealth

    %{
    figure(1)
    fplot(V)
    xlim([0,2])
    ylim([0,2])
    title('V(w) with variable p')
    xlabel('w');
    ylabel('V(w)');
    hold on;
    %}
    %refline = [x y];
    %fplot(refline, '--r');

    % Recursion For Poverty Trap Admittance in Generations
    % s is propensity to give/invest back, w_n is new wealth for child/next
    % period
    
    s = [.66, .5, .33, .1];          % P.T. when s < s*, where parents do not invest enough back into progeny
    if s(i)*R >= 1
        disp("Must meet condition: s*R < " + num2Str(s*R))
        return;
    end
    s_state = "s = " + num2str(s(i));
    s_lgd(i) = s_state;
    
    w_b = s(i)*V;

    figure(1)
    fplot(w_b)
    xlim([0,1])
    ylim([0,1])
    title('w_b := s*V(w)')
    xlabel('w_t');
    ylabel('w_{t+1}');
    hold on;
    legend(s_lgd);
    %hold;
    %refline = [x y];
    %fplot(refline, '--r');
    %}

end
hline = refline([1 0]);
hline.Color = 'r';
hline.LineStyle = ':';
