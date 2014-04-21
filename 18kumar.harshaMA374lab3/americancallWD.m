function [ price ] = americancallWD( start, strike, rate, steps, sigma, T, set )
%AMERICANCALLWD computes american call option price; no dividends on asset
%   start = price of asset at t = 0
%   strike = strike price for the option
%   rate = risk free interest rate
%   steps = number of time steps
%   sigma = volatility
%   T = total time
%   set = set number of up-down pair to use

dt = T/steps;
switch set
    case 1
        up = exp(sigma*sqrt(dt));
        down = 1/up;
    case 2
        up = exp(sigma*sqrt(dt) + (rate-sigma*sigma*0.5)*dt);
        down = exp(-sigma*sqrt(dt) + (rate-sigma*sigma*0.5)*dt);
end

price = european(start, strike, rate, steps, sigma, T, 0, up, down);

end

