format long; clear all; clc;

%initial values
start = 100;
K = 100;
T = 1;
M = 100;
r = 0.08;
sigma = 0.2;

%initial price of American call and put
disp(['American Call; Set 1']);
disp(americancallWD(start, K, r, M, sigma, T, 1));
disp(['American Call; Set 2']);
disp(americancallWD(start, K, r, M, sigma, T, 2));
disp(['American Put; Set 1']);
disp(americanputWD(start, K, r, M, sigma, T, 1));
disp(['American Put; Set 2']);
disp(americanputWD(start, K, r, M, sigma, T, 2));

%varying starting price S(0)
range = 50;
optiondata = zeros(2*range+1, 5);
for i=start-range:start+range
    optiondata(i-start+range+1, 1) = i;
    optiondata(i-start+range+1, 2) = americancallWD(i, K, r, M, sigma, T, 1);
    optiondata(i-start+range+1, 3) = americanputWD(i, K, r, M, sigma, T, 1);
    optiondata(i-start+range+1, 4) = americancallWD(i, K, r, M, sigma, T, 2);
    optiondata(i-start+range+1, 5) = americanputWD(i, K, r, M, sigma, T, 2);
end
figure
plot(optiondata(:,1), optiondata(:,2), optiondata(:,1), optiondata(:,3), optiondata(:,1), optiondata(:,4), optiondata(:,1), optiondata(:,5))
title('Varying Starting price of Asset')
legend('Call option, set 1', 'Put option, set 1', 'Call option, set 2', 'Put option, set 2')


%varying strike price K
range = 50;
strikedata = zeros(2*range+1, 5);
for i=K-range:K+range
    strikedata(i-K+range+1, 1) = i;
    strikedata(i-K+range+1, 2) = americancallWD(start, i, r, M, sigma, T, 1);
    strikedata(i-K+range+1, 3) = americanputWD(start, i, r, M, sigma, T, 1);
    strikedata(i-K+range+1, 4) = americancallWD(start, i, r, M, sigma, T, 2);
    strikedata(i-K+range+1, 5) = americanputWD(start, i, r, M, sigma, T, 2);
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
    ratedata(i-r+range+1, 2) = americancallWD(start, K, i/100, M, sigma, T, 1);
    ratedata(i-r+range+1, 3) = americanputWD(start, K, i/100, M, sigma, T, 1);
    ratedata(i-r+range+1, 4) = americancallWD(start, K, i/100, M, sigma, T, 2);
    ratedata(i-r+range+1, 5) = americanputWD(start, K, i/100, M, sigma, T, 2);
end
figure
x = plot(ratedata(:,1), ratedata(:,2), ratedata(:,1), ratedata(:,3), ratedata(:,1), ratedata(:,4), ratedata(:,1), ratedata(:,5));
title('Varying Interest rate')
legend('Call for set 1', 'Put for set 1', 'Call for set 2', 'Put for set 2')


%varying sigma
s = 20;
r = 0.08;
range = 10;
sigmadata = zeros(2*range+1, 5);
for i=s-range:s+range
    sigmadata(i-s+range+1, 1) = i/100;
    sigmadata(i-s+range+1, 2) = americancallWD(start, K, r, M, i/100, T, 1);
    sigmadata(i-s+range+1, 3) = americanputWD(start, K, r, M, i/100, T, 1);
    sigmadata(i-s+range+1, 4) = americancallWD(start, K, r, M, i/100, T, 2);
    sigmadata(i-s+range+1, 5) = americanputWD(start, K, r, M, i/100, T, 1);
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
        stepdata(i-M+range+1, 2+(j-1)*4) = americancallWD(start, K(j), r, i, sigma, T, 1);
        stepdata(i-M+range+1, 3+(j-1)*4) = americanputWD(start, K(j), r, i, sigma, T, 1);
        stepdata(i-M+range+1, 4+(j-1)*4) = americancallWD(start, K(j), r, i, sigma, T, 2);
        stepdata(i-M+range+1, 5+(j-1)*4) = americanputWD(start, K(j), r, i, sigma, T, 2);
    end
end
for i=1:3
    figure
    plot(stepdata(:,1), log10(stepdata(:,2+(i-1)*4)), stepdata(:,1), log10(stepdata(:,3+(i-1)*4)), stepdata(:,1), log10(stepdata(:,4+(i-1)*4)), stepdata(:,1), log10(stepdata(:,5+(i-1)*4)))
    title(['Varying Steps, Strike =', num2str(K(i))])
    legend('Call option, set 1', 'Put option, set 1', 'Call option, set 2', 'Put option, set 2')
end