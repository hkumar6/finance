format long; clear all; clc;

T = 1; K = 1; r = 0.05; sig = 0.6;

% part 2
% compute call and put prices as a function of asset price
t = [0, 0.2, 0.4, 0.6, 0.8, 1];
n_time = length(t);
assetprice = 0.5:0.01:1.5;
n_asset = length(assetprice);
call = zeros(n_time,n_asset);
put = zeros(1,n_asset);
for i=1:n_asset
    for j=1:n_time
        [call(j,i), put(j,i)] = bsmoptionprice(assetprice(i), K, r, t(j), T, sig);
    end
end

% plot call and put prices against asset price
colors = ['b', 'g', 'r', 'c', 'm', 'k'];
figure
for i=1:n_time
    plot(assetprice, call(i,:), colors(i))
    hold on
end
hold off
title('C(t,s) against s')
legend(num2str(t'))

figure
for i=1:n_time
    plot(assetprice, put(i,:), colors(i))
    hold on
end
hold off
title('P(t,s) against s')
legend(num2str(t'))

% plot call and put prices against asset price and time
figure
stem3(assetprice, t, call)
title('3D plot for call option')
xlabel('Asset price')
ylabel('Time')
zlabel('Option price')

figure
stem3(assetprice, t, put)
title('3D plot for put option')
xlabel('Asset price')
ylabel('Time')
zlabel('Option price')


% part 3
% surface plot of call option prices
figure
surf(assetprice, t, call)
title('3D plot for call option')
xlabel('Asset price')
ylabel('Time')
zlabel('Option price')

% surface plot of put option prices
figure
surf(assetprice, t, put)
title('3D plot for put option')
xlabel('Asset price')
ylabel('Time')
zlabel('Option price')


% part 4
assetp = 1;
% sensitivity of call and put prices against time to expiration
periodvalues = 1:0.01:5;
n_periodvalues = length(periodvalues);
call_time = zeros(n_time, n_periodvalues);
put_time = zeros(n_time, n_periodvalues);
for i=1:n_periodvalues
    for j=1:n_time
        [call_time(j,i), put_time(j,i)] = bsmoptionprice(assetp, K, r, t(j), periodvalues(i), sig);
    end
end
figure
for i=1:n_time
    plot(periodvalues, call_time(i,:), colors(i))
    hold on
end
title('Sensitivity of Call option to Time before expiry')
xlabel('Time before expiry')
ylabel('Call option price')
legend(num2str(t'))
figure
for i=1:n_time
    plot(periodvalues, put_time(i,:), colors(i))
    hold on
end
title('Sensitivity of Put option to Time before expiry')
xlabel('Time before expiry')
ylabel('Put option price')
legend(num2str(t'))


% sensitivity of call and put prices against strike price
strikevalues = 0.75:0.01:1.25;
n_strikevalues = length(strikevalues);
call_strike = zeros(n_time, n_strikevalues);
put_strike = zeros(n_time, n_strikevalues);
for i=1:n_strikevalues
    for j=1:n_time
        [call_strike(j,i), put_strike(j,i)] = bsmoptionprice(assetp, strikevalues(i), r, t(j), T, sig);
    end
end
figure
for i=1:n_time
    plot(strikevalues, call_strike(i,:), colors(i))
    hold on
end
title('Sensitivity of Call option to Strike price')
xlabel('Strike price')
ylabel('Call option price')
legend(num2str(t'))
figure
for i=1:n_time
    plot(strikevalues, put_strike(i,:), colors(i))
    hold on
end
title('Sensitivity of Put option price to Strike price')
xlabel('Strike price')
ylabel('Put option price')
legend(num2str(t'))

% sensitivity of call and put prices against rate
rates = 0.05:0.01:0.20;
n_rates = length(rates);
call_rates = zeros(n_time, n_rates);
put_rates = zeros(n_time, n_rates);
for i=1:n_rates
    for j=1:n_time
        [call_rates(j,i), put_rates(j,i)] = bsmoptionprice(assetp, K, rates(i), t(j), T, sig);
    end
end
figure
for i=1:n_time
    plot(rates, call_rates(i,:), colors(i))
    hold on
end
title('Sensitivity of Call option to rate')
xlabel('Rates')
ylabel('Call option price')
legend(num2str(t'))
figure
for i=1:n_time
    plot(rates, put_rates(i,:), colors(i))
    hold on
end
title('Sensitivity of Put option to rate')
xlabel('Rates')
ylabel('Put option price')
legend(num2str(t'))

% sensitivity of call and put prices against volatility
volatility = 0.40:0.01:0.80;
n_volatility = length(volatility);
call_vol = zeros(n_time, n_volatility);
put_vol = zeros(n_time, n_volatility);
for i=1:n_volatility
    for j=1:n_time
        [call_vol(j,i), put_vol(j,i)] = bsmoptionprice(assetp, K, r, t(j), T, volatility(i));
    end
end
figure
for i=1:n_time
    plot(volatility, call_vol(i,:), colors(i));
    hold on
end
title('Sensitivity of Call option to volatility')
xlabel('Volatility')
ylabel('Call option price')
legend(num2str(t'))
figure
for i=1:n_time
    plot(volatility, put_vol(i,:), colors(i))
    hold on
end
title('Sensitivity of Put option to volatility')
xlabel('Volatility')
ylabel('Put option price')
legend(num2str(t'))

% 3d plots
% call against time and period
figure
surf(periodvalues, t, call_time);
title('Call option prices against time and period')
xlabel('Time period')
ylabel('Time')
zlabel('Call option')
% put against time and period
figure
surf(periodvalues, t, put_time);
title('Put option prices against time and period')
xlabel('Time period')
ylabel('Time')
zlabel('Put option')

% call against time and strike
figure
surf(strikevalues, t, call_strike);
title('Call option prices against time and strike price')
xlabel('Strike price')
ylabel('Time')
zlabel('Call option')
% put against time and strike
figure
surf(strikevalues, t, put_strike);
title('Put option prices against time and strike price')
xlabel('Strike price')
ylabel('Time')
zlabel('Put option')

% call against time and rate
figure
surf(rates, t, call_rates);
title('Call option prices against time and rate')
xlabel('Rates')
ylabel('Time')
zlabel('Call option')
% put against time and rate
figure
surf(rates, t, put_rates);
title('Put option prices against time and rate')
xlabel('Rates')
ylabel('Time')
zlabel('Put option')

% call against time and volatility
figure
surf(volatility, t, call_vol);
title('Call option prices against time and volatility')
xlabel('Volatility')
ylabel('Time')
zlabel('Call option')
% put against time and volatility
figure
surf(volatility, t, put_vol);
title('Put option prices against time and volatility')
xlabel('Volatility')
ylabel('Time')
zlabel('Put option')