clear all; clc;

% Part A
%--------------------------------------------------------------------------
%script to calculate the markov efficient frontier
mu=(1:50)/100;%for fifty points
ExpReturn=[0.1;0.2;0.15];%the mean return vector
ExpCovariance=[0.005,-0.010,0.004;-0.010,0.040,-0.002;0.004,-0.002,0.023];% the covariance vector
NumPorts = 10;
[PortRisk, PortReturn, PortWts] = portopt(ExpReturn, ExpCovariance, NumPorts);
plot(PortRisk, PortReturn)
