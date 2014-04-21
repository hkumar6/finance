function [ price ] = lookback( start, rate, steps, sigma, T)
%LOOKBACK compute initial price of a lookback put option with floating
%strike
%   start = initial asset price
%   rate = risk-free interest rate
%   steps = number of time steps
%   sigma = volatility
%   T = total time


dt = T/steps;
up = exp(sigma*sqrt(dt) + (rate-sigma*sigma*0.5)*dt);
down = exp(-sigma*sqrt(dt) + (rate-sigma*sigma*0.5)*dt);
p = (exp(rate*dt) - down)/(up - down);

option = zeros(2^steps,1);

for i=0:2^steps-1
    assetpath = de2bi(i, steps);
    d = sum(assetpath);
    u = steps-d;
    option(i+1) = start*(up^u)*(down^d);
    strike = start;
    temp = start;
    for j=1:steps
        switch assetpath(steps-j+1)
            case 0
                temp = temp*up;
            case 1
                temp = temp*down;
        end
        strike = max(strike, temp);
    end
    option(i+1) = (max(strike-option(i+1), 0))*(p^u)*((1-p)^d);
end

disp(option)

price = sum(option)*exp(-rate);

end