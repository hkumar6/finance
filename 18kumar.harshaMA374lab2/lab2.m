format long; clc; clear all;
%initial values
s0 = 100;
strike = 100;
T = 1;
M = 100;
rate = 0.08;
sigma = 0.2;

%compute option prices for two sets of u and d
up1 = exp(sigma*sqrt(T/M));
down1 = exp(-sigma*sqrt(T/M));
ce1 = european(s0, strike, rate, M, sigma, T, 0, up1, down1);
pe1 = european(s0, strike, rate, M, sigma, T, 1, up1, down1);
up2 = exp(sigma*sqrt(T/M) + (rate-sigma*sigma*0.5)*T/M);
down2 = exp(-sigma*sqrt(T/M) + (rate-sigma*sigma*0.5)*T/M);
ce2 = european(s0, strike, rate, M, sigma, T, 0, up2, down2);
pe2 = european(s0, strike, rate, M, sigma, T, 1, up2, down2);

%varying starting price S(0)
range = 50;
optiondata = zeros(2*range+1, 5);
for i=s0-range:s0+range
    optiondata(i-s0+range+1, 1) = i;
    optiondata(i-s0+range+1, 2) = european(i, strike, rate, M, sigma, T, 0, up1, down1);
    optiondata(i-s0+range+1, 3) = european(i, strike, rate, M, sigma, T, 1, up1, down1);
    optiondata(i-s0+range+1, 4) = european(i, strike, rate, M, sigma, T, 0, up2, down2);
    optiondata(i-s0+range+1, 5) = european(i, strike, rate, M, sigma, T, 1, up2, down2);
end
figure
plot(optiondata(:,1), optiondata(:,2), optiondata(:,1), optiondata(:,3), optiondata(:,1), optiondata(:,4), optiondata(:,1), optiondata(:,5))
title('Varying Starting price of Asset')
legend('Call option, set 1', 'Put option, set 2', 'Call option, set 2', 'Put option, set 2')


%varying strike price K
range = 50;
strikedata = zeros(2*range+1, 5);
for i=strike-range:strike+range
    strikedata(i-s0+range+1, 1) = i;
    strikedata(i-s0+range+1, 2) = european(s0, i, rate, M, sigma, T, 0, up1, down1);
    strikedata(i-s0+range+1, 3) = european(s0, i, rate, M, sigma, T, 1, up1, down1);
    strikedata(i-s0+range+1, 4) = european(s0, i, rate, M, sigma, T, 0, up2, down2);
    strikedata(i-s0+range+1, 5) = european(s0, i, rate, M, sigma, T, 1, up2, down2);
end
figure
plot(strikedata(:,1), strikedata(:,2), strikedata(:,1), strikedata(:,3), strikedata(:,1), strikedata(:,4), strikedata(:,1), strikedata(:,5))
title('Varying Strike price')
legend('Call for set 1', 'Put for set 1', 'Call for set 2', 'Put for set 2')


%varying interest rate
range = 4;
r = 8;
ratedata = zeros(2*range+1, 5);
for i=r-range:r+range
    ratedata(i-r+range+1, 1) = i/100;
    ratedata(i-r+range+1, 2) = european(s0, strike, i/100, M, sigma, T, 0, up1, down1);
    ratedata(i-r+range+1, 3) = european(s0, strike, i/100, M, sigma, T, 1, up1, down1);
    ratedata(i-r+range+1, 4) = european(s0, strike, i/100, M, sigma, T, 0, up2, down2);
    ratedata(i-r+range+1, 5) = european(s0, strike, i/100, M, sigma, T, 1, up2, down2);
end
figure
x = plot(ratedata(:,1), ratedata(:,2), ratedata(:,1), ratedata(:,3), ratedata(:,1), ratedata(:,4), ratedata(:,1), ratedata(:,5));
title('Varying Interest rate')
legend('Call for set 1', 'Put for set 1', 'Call for set 2', 'Put for set 2')


%varying sigma
s = 20;
range = 10;
sigmadata = zeros(2*range+1, 5);
for i=s-range:s+range
    u1 = exp(i*sqrt(T/M)/100);  d1 = exp(-i*sqrt(T/M)/100);
    u2 = exp(i*sqrt(T/M)/100 + (rate-i*i*0.5/10000)*T/M); d2 = exp(-i*sqrt(T/M)/100 + (rate-i*i*0.5)*(T/M)/10000);
    sigmadata(i-s+range+1, 1) = i/100;
    sigmadata(i-s+range+1, 2) = european(s0, strike, rate, M, i/100, T, 0, u1, d1);
    sigmadata(i-s+range+1, 3) = european(s0, strike, rate, M, i/100, T, 1, u1, d1);
    sigmadata(i-s+range+1, 4) = european(s0, strike, rate, M, i/100, T, 0, u2, d2);
    sigmadata(i-s+range+1, 5) = european(s0, strike, rate, M, i/100, T, 1, u2, d2);
end
figure
plot(sigmadata(:,1), sigmadata(:,2), sigmadata(:,1), sigmadata(:,3), sigmadata(:,1), sigmadata(:,4), sigmadata(:,1), sigmadata(:,5))
title('Varying SIGMA')
legend('Call for set 1', 'Put for set 1', 'Call for set 2', 'Put for set 2')


%varying steps and strike prices
range = 50;
K = [95, 100, 105];
stepdata = zeros(2*range+1, 13);
for i=M-range:M+range
    stepdata(i-M+range+1, 1) = i;
    for j=1:3
        stepdata(i-M+range+1, 2+(j-1)*4) = european(s0, K(j), rate, i, sigma, T, 0, up1, down1);
        stepdata(i-M+range+1, 3+(j-1)*4) = european(s0, K(j), rate, i, sigma, T, 1, up1, down1);
        stepdata(i-M+range+1, 4+(j-1)*4) = european(s0, K(j), rate, i, sigma, T, 0, up2, down2);
        stepdata(i-M+range+1, 5+(j-1)*4) = european(s0, K(j), rate, i, sigma, T, 1, up2, down2);
    end
end
for i=1:3
    figure
    plot(stepdata(:,1), stepdata(:,2+(i-1)*4), stepdata(:,1), stepdata(:,3+(i-1)*4), stepdata(:,1), stepdata(:,4+(i-1)*4), stepdata(:,1), stepdata(:,5)+(i-1)*4)
    title(['Varying Steps, Strike =', num2str(K(i))])
    legend('Call option, set 1', 'Put option, set 1', 'Call option, set 2', 'Put option, set 2')
end