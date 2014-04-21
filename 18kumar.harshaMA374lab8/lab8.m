format short; clear all; clc;

bse = csvread('bsedata_daily.csv');
nse = csvread('nsedata_daily.csv');


% assuming that a month has 26 trading days
daysInAMonth = 26;

months = 76;

% other parameters
rate = 0.05;
s0 = bse(1);
K = s0 * (0.5:0.1:1.5);
v = zeros(1, months);

% estimate historical volatility
for i=1:months
    v(i) = sqrt(252) * std((bse(2:i*daysInAMonth) - bse(1:i*daysInAMonth-1))...
        ./(bse(1:i*daysInAMonth-1)));
end
h = figure;
plot(v)
title('Volatility against period length')
xlabel('Number of months')
ylabel('Volatility')
saveas(h, 'volatility', 'jpg')

calldata = zeros(months, length(K));
putdata = zeros(months, length(K));

for i=1:months
    for j=1:length(K)
        [calldata(i, j), putdata(i, j)] = bsmoptionprice(s0, K(j), rate, 0, 0.5, v(i));
    end
end

for i=1:length(K)
    h = figure;
    plot(calldata(:, i));
    title(['Call option prices for BSE; Strike = ' num2str(K(i))]);
    xlabel('Period length')
    ylabel('Call option')
    saveas(h, ['call_strike' num2str(i)], 'jpg')
    figure
    plot(putdata(:, i));
    title(['Put option prices for BSE; Strike = ' num2str(K(i))]);
    xlabel('Period length')
    ylabel('Put option')
    saveas(h, ['put_strike' num2str(i)], 'jpg')
end