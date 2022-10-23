%%%%%%%%%%%%%%%%
%  Script for plotting the gain-loss utility function over time
%  This captures the change of wealth distribution from period to period in
%  a histogram plot.
%
%  Note, this call on functions b (bequeset function of wealth) s
%  and k_p (capital function of wealth for poor agents), included in the
%  same folder.
%%%%%%%%%%%%%%%%
format long

% Create generational-wealth matrix (empty)
T = 50; % periods
N = 100; % number of people aka partitions for wealth distribution
w_g=zeros(T,N+1);  % wealth of generations --- a matrix where at time period T, we obersve agent N's wealth


% Assign wealth distrobution
w_max = 1;       % maximum wealth level in population
delta_N = w_max/N;  % change in wealth from each individual for uniform dist.
w_g(1,:) = ???????;  % Uniform Distribution of wealth in first time period

% Bounds on capital
k_l = 1;       %lower bound
k_u = 1.6;      %upper bound

% Exogenous variables
p = .2;    %Probability of catching reneging agent
R = 2.8;      %Interest Rate on gains from borrowed captial
r = 1.1;     %Interest rate agent must repay on borrowed captial

w_c = k_l - k_l^2*p*R/r;    % wealth cut-off for poor/rich captial borrowing

sigma = .27;          % P.T. when s < s*, where parents do not invest enough back into progeny
lambda = 2.25;            % Loss coefficient, >= 0
eta = .2;

alpha = sigma*(1+lambda*eta)/(1+eta*(1-sigma*(1-lambda)));
w_4 = alpha*k_l*(R-r)/(1-alpha*r);
w_3 = sigma*k_l*(R-r)/(1-sigma*r);
w_2 = sigma*r*(1-sigma*R)*(R-r)/(p*R*(1-sigma*r)^2);
w_1 = alpha*r*(1-alpha*R)*(R-r)/(p*R*(1-alpha*r)^2);











% For-Loop determining wealth in subsequent periods
for j=1:T-1
    for i=1:N
       w_g(j+1,i)=b(w_g(j,i));
       %w_g(j+1,i)=b_original(w_g(j,i));   %Wealth of next period determined by bequeath/wealth of last period
    end
end


% Creating 3_D plot of histogram
binNum = 30;   %bin number for 2d histogram
bins = zeros(T, binNum);  %creating empty bins

for j=1:T
    h = histogram(w_g(j,:), binNum);   %storing each period's histogram
    bins(j,:)= h.Values;               %Putting them all in bins matrix
end

%Plot bins matrix in bargraph
figure(1)
title('Wealth Polarization over Time')
bar3(bins)
xlabel('Wealth')
ylabel('Period')
zlabel('Number of Agents')

figure(2)
title('Wealth Polarization at Last Period')
hold on;
histogram(w_g(1,:),10, 'DisplayName','First Period')
histogram(w_g(T,:),10, 'DisplayName','Last Period')
xlabel('Wealth')
ylabel('Period')
zlabel('Number of Agents')
legend


