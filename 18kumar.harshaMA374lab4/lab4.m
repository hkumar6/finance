clear all; clc;

M = [0.1 0.2 0.15];
%M = [0.10 0.15 0.20];
C = [0.005 -0.010 0.004; -0.010 0.040 -0.002; 0.004 -0.002 0.023];
%C = [0.0784 -0.0067 0.0175; -0.0067 0.0576 0.0120; 0.0175 0.0120 0.0625];
u = [1 1 1];

% [PortRisk, PortReturn, PortWts] = portopt(M, C);
% plot(PortRisk,PortReturn,'DisplayName','PortReturn vs. PortRisk','XDataSource','PortRisk','YDataSource','PortReturn');
% figure(gcf)
% xlabel('Risk (Standard Deviation)')
% ylabel('Expected Return')
% title('Mean-Variance-Efficient Frontier')
% grid on

Ci = inv(C);
%construct and plot the Markowitz efficient frontier
N = 50;
returns = zeros(1,N);
stddevs = zeros(1,N);
for r = 1:N
    ret = r/100;
    returns(r) = ret;
    w = (M*Ci*M' - ret*(u*Ci*M'))*u*Ci + (ret*(u*Ci*u') - M*Ci*u')*M*Ci;
    t = (u*Ci*u')*(M*Ci*M') - (u*Ci*M')*(M*Ci*u');
    w = w/t;
    stddevs(r) = sqrt(w*C*w');
end

cut = min(stddevs);
i = 1;
while(stddevs(i) ~= cut)
    i = i+1;
end

plot(stddevs(i:end), returns(i:end))
xlabel('Risk (Standard Deviation)')
ylabel('Expected Return')
title('Markowitz bullet')
grid on


%tabulate weights, return and risk for 10 values
indices = int8(i + rand(10, 1)*(N-i))
for i=1:10
    ret = returns(indices(i));
    risk = stddevs(indices(i));
    w = (M*Ci*M' - ret*(u*Ci*M'))*u*Ci + (ret*(u*Ci*u') - M*Ci*u')*M*Ci;
    t = (u*Ci*u')*(M*Ci*M') - (u*Ci*M')*(M*Ci*u');
    w = w/t;
    disp([' &', num2str(ret), ' &', num2str(risk), ' &', num2str(w(1)), ' &', num2str(w(2)), ' &', num2str(w(3)), '\\' ])
end

%portfolio for 15% risk
%approx 5% and 19% returns from the graph
%achieve greater accuracy
reqrisk = 0.15;
r = [0.05 0.06; 0.18 0.19];
interval = 0.03;
for i = 1:2
    left = r(i,1);
    right = r(i,2);
    for j = 1:10
        ret = (left + right)/2;
        w = (M*Ci*M' - ret*(u*Ci*M'))*u*Ci + (ret*(u*Ci*u') - M*Ci*u')*M*Ci;
        t = (u*Ci*u')*(M*Ci*M') - (u*Ci*M')*(M*Ci*u');
        w = w/t;
        temprisk = sqrt(w*C*w');
        if temprisk > reqrisk && i == 1
            left = ret;
        elseif temprisk < reqrisk && i == 1
            right = ret;
        elseif temprisk > reqrisk && i == 2
            right = ret;
        elseif temprisk < reqrisk && i== 2
            left = ret;
        end
    end
    disp(['part c  ', 'risk=', num2str(temprisk), '   return=', num2str(ret)])
    disp(w)
end

%minimum risk portfolio for 18% return
ret = 0.18;
w = (M*Ci*M' - ret*(u*Ci*M'))*u*Ci + (ret*(u*Ci*u') - M*Ci*u')*M*Ci;
t = (u*Ci*u')*(M*Ci*M') - (u*Ci*M')*(M*Ci*u');
w = w/t


%market portfolio
riskfree = 0.10;
w = (M - riskfree*u)*Ci;
norm = sum(w);
disp('market portfolio')
w = w/norm

%capital market line
expmr = w*M';
beta = 0:0.01:1;
mr = riskfree + beta.*(expmr - riskfree);
figure
plot(beta, mr)
xlabel('Risk (Standard Deviation)')
ylabel('Expected Return')
title('Capital Market Line')
grid on