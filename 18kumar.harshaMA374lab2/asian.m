function [ optionprice ] = asian( start, strike, rate, steps, sigma, T, callorput , up, down )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


payoff = zeros(1, 2^steps);
p = (exp(rate*T) - down)/(up - down);
for i=0:2^steps-1
    assetpath = de2bi(i, steps);
    asset = start;
    avg = start;
    for j=1:steps
        if assetpath(steps-j+1) == 0
            asset = asset*up;
        else
            asset = asset*down;
        end
        avg = avg + asset;
    end
    avg = avg/(steps+1);
    if callorput == 0
        payoff(1, i+1) = max(0, (avg-strike));
    else
        payoff(1, i+1) = max(0, (strike-avg));
    end
    downs = sum(assetpath);
    ups = steps - downs;
    payoff(1, i+1) = payoff(1, i+1)*(p^ups)*((1-p)^downs);
end

optionprice = sum(payoff)*exp(-rate*T);

end