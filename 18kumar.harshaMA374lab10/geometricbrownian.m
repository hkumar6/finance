function [ gbmpath ] = geometricbrownian( mu, sig, start, steps )
%GEOMETRICBROWNIAN simulate a geometric brownian path
%   mu    : drift
%   sig   : volatility
%   start : initial value of the path
%   steps : number of steps to simulate

rn = normrnd(0, 1, 1, steps);
t = 0:1/steps:1;
gbmpath = zeros(1, steps);
gbmpath(1) = start;
for i=2:steps
    gbmpath(i) = gbmpath(i-1)*exp((mu - 0.5*sig*sig)*(t(i)-t(i-1))...
        + sig*sqrt(t(i)-t(i-1))*rn(i));
end

end