format long; clc; clear all;
%initial values
s0 = 9;
strike = 10;
rate = 0.06;
sigma = 0.3;
T = 3;
steps = [1,5,10,20,50,100,200,400];
n = size(steps);
n = n(2);

%question 1
%valuate option for call and put
cnp = zeros(n,3);
cnp(:,1) = steps';
for i=1:n
    cnp(i,2) = (european(s0, strike,rate,steps(i),sigma,T,0));
    cnp(i,3) = (european(s0, strike,rate,steps(i),sigma,T,1));
end

uitable('Data', cnp, 'ColumnName', {'Steps', 'Call', 'Put'});


%question 2
%compare option prices for various step sizes
n = 400;
stepsof1 = zeros(n,3);
stepsof1(:,1) = [1:n]';
for i=1:n
    stepsof1(i,2) = (european(s0, strike,rate,stepsof1(i,1),sigma,T,0));
    stepsof1(i,3) = (european(s0, strike,rate,stepsof1(i,1),sigma,T,1));
end

stepsof5 = zeros(1+n/5,3);
stepsof5(1,:) = stepsof1(1,:);
for i=1:n/5
    stepsof5(i+1,:) = stepsof1(5*i,:);
end

figure
plot(stepsof1(:,1), stepsof1(:,2), stepsof1(:,1), stepsof1(:,3));
legend('Call', 'Put'); xlabel('Time steps'); ylabel('Option price'); title('Step size = 1');
figure
plot(stepsof5(:,1), stepsof5(:,2), stepsof5(:,1), stepsof5(:,3));
legend('Call', 'Put'); xlabel('Time steps'); ylabel('Option price'); title('Step size = 5');


%question 3
%option prices at different times for 20 time steps
t = [0, 0.30, 0.75, 1.50, 2.70];
n = 20;
callprices = dispoptionprices(s0,strike,rate,n,sigma,T,t,0);
putprices = dispoptionprices(s0,strike,rate,n,sigma,T,t,1);

figure
uitable('Data', callprices);
figure
uitable('Data', putprices);