function [ call, put ] = bsmoptionprice( price, strike, rate, time, period, volatility )
%BSMCALL Compute option prices
%   bsmoptionprice( price, strike, rate, time, period, volatility )
%   price = starting price of asset
%   strike = strike price
%   rate = risk-free rate
%   time = time at which option price is to be calculated
%   period = time to expiration of the option
%   volatility = annualised asset price volatility

d1 = (log(price/strike) + (rate + volatility*volatility*0.5)*(period - time) )/(volatility * sqrt(period - time) );
d2 = (log(price/strike) + (rate - volatility*volatility*0.5)*(period - time) )/(volatility * sqrt(period - time) );

call = normcdf(d1)*price - normcdf(d2)*strike*exp(-rate*(period-time));
put = normcdf(-d2)*strike*exp(-rate*(period-time)) - normcdf(-d1)*price;

end