function [ price ] = americanputWD( start, strike, rate, steps, sigma, T, set)
%AMERICANPUTWD computes american option price; no dividends on asset
%   start = price of asset at t = 0
%   strike = strike price for the option
%   rate = risk free interest rate
%   steps = number of time steps
%   sigma = volatility
%   T = total time
%   set = set number of up-down pair to use


asset = zeros(steps+1);
option = zeros(steps+1, steps+1);
dt = T/steps;
switch set
    case 1
        up = exp(sigma*sqrt(dt));
        down = 1/up;
    case 2
        up = exp(sigma*sqrt(dt) + (rate-sigma*sigma*0.5)*dt);
        down = exp(-sigma*sqrt(dt) + (rate-sigma*sigma*0.5)*dt);
end

p = (exp(rate*dt)-down)/(up-down);
asset(1,1) = start;

%create asset price tree
for i=2:steps+1
    asset(1,i) = asset(1,i-1)*up;
    for j=2:i
        asset(j,i) = asset(j-1,i)*down/up;
    end
end

%create option price tree
for i=1:steps+1
    option(i, steps+1) = max(strike-asset(i,steps+1), 0);
end
for i=1:steps
    for j=1:steps+1-i
        option(j, steps+1-i) = max(strike-asset(j, steps+1-i), (option(j, steps+2-i)*p + option(j+1, steps+2-i)*(1-p))*exp(-rate*dt));
    end
end

price = option(1,1);

end