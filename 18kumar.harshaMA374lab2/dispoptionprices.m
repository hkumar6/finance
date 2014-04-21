function [ pricetable ] = dispoptionprices( start, strike, rate, steps, sigma, T, t, callorput )
%compute value of european option
%   start = price of asset at t = 0
%   strike = strike price for the option
%   rate = risk free interest rate
%   steps = number of time steps
%   sigma = volatility
%   T = total time
%   t = array of times at which option prices are required
%   callorput = 0 for call, 1 for put

optionprices = zeros(steps+1);
dt = T/steps;
t = int8(t./(T/steps));
up = exp(sigma*sqrt(dt) + (rate-sigma*sigma*0.5)*dt);
down = exp(-sigma*sqrt(dt) + (rate-sigma*sigma*0.5)*dt);
p = (exp(rate*dt) - down)/(up - down);
for i = 1:steps+1
    if callorput == 0 %call option
        optionprices(i,steps+1) = max(start*(up^(steps-i+1))*(down^(i-1)) - strike, 0);
    elseif callorput == 1 %put option
        optionprices(i,steps+1) = max(strike - start*(up^(steps-i+1))*(down^(i-1)), 0);
end
for i = 1:steps
    for j = 1:steps+1-i
        optionprices(j,steps+1-i) = (optionprices(j,steps+2-i)*p + optionprices(j+1,steps+2-i)*(1-p))*exp(-rate*dt);
    end
end

n = size(t);
n = max(n(1), n(2));
pricetable = zeros(steps+1,n);
for i=1:n
    pricetable(:,i) = optionprices(:,t(i)+1);
end

end

