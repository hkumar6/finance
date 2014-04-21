clear; 
% Part A
%--------------------------------------------------------------------------
%script to calculate the markov efficient frontier
mu=(1:50)/100;%for fifty points
z=[0.1;0.2;0.15];%the mean return vector
C=[0.005,-0.010,0.004;-0.010,0.040,-0.002;0.004,-0.002,0.023];% the covariance vector
z1=ones(3,1);
A=z1'*((C)^-1)*z1;
if(A<0)
    display('error');
end
B=z1'*((C)^-1)*z;
C1=z'*((C)^-1)*z;
delta=(A*C1)-(B*B);
if(delta<0)
    display('error');
end
variance=zeros(1,50);
i=1;
while(i<=50)
    variance(i)=sqrt(((A*mu(i)*mu(i))-(2*B*mu(i))+C1)/delta);% applying the formula
    i=i+1;
end
plot(variance,mu);
%--------------------------------------------------------------------------
%Part B
%--------------------------------------------------------------------------
wg=(C\z1)/A;%this is the weights for the global minimum variance portfolio
% we need another point on the efficient frontier so we calculate the
% tangency portfolio with R=0%
wt=(C\z)/B;
i=1;
weight=zeros(3,50);
ret=zeros(1,50);
sd=zeros(1,50);
while(i<=50)
    % Calculate Lambda and Gamma
    lambda= (C1 - (mu(i)*B))/delta;
    gamma=  ((mu(i)*A)-B)/delta;
    w_s=((lambda*A)*wg)+((gamma*B)*wt);
    ret(i)=w_s'*z;
    sd(i)=w_s'*C*w_s;
    weight(:,i)=w_s;
    i=i+1;
end
%tabulate weights ,return, and risk
ret
sd
weight(1,:)
weight(2,:)
weight(3,:)
%--------------------------------------------------------------------------
%Part C
%--------------------------------------------------------------------------
%15 percent risk from the markowitz graph max_return=17%, min_return=5%
% the protfoli 1
lambda= (C1 - (.17*B))/delta;
gamma=  ((.17*A)-B)/delta;
display('for maximum return');
w_s=((lambda*A)*wg)+((gamma*B)*wt)
% the protfoli 1
lambda= (C1 - (.05*B))/delta;
gamma=  ((.05*A)-B)/delta;
display('for minimum return');
w_s=((lambda*A)*wg)+((gamma*B)*wt)
%--------------------------------------------------------------------------
%Part D
%--------------------------------------------------------------------------
display('Weights of the Portfolio(at 18% return)');
weight(:,18)
%--------------------------------------------------------------------------
%Part E
%--------------------------------------------------------------------------
display('the market portfolio');
display('the market portfolio weights');
w_market=(C\(z-0.1*z1))/(B-(A*.1))
display('the market portfolio return rate');
ereturn_market=(C1-B*0.1)/(B-(A*.1))
display('the market portfolio variance')
sd_market=(C1-2*0.1*B+(0.01*A))/((B-(A*.1))^2)
variance1=(1:50)/10;
cmline=((variance1*(ereturn_market-0.1))/(sd_market));
cmline=cmline+(10*ones(1,50));
%plot the cmline from the workspace to observe the CML
%--------------------------------------------------------------------------
%Part F
%--------------------------------------------------------------------------
%risk =10% expected return from markowitz efficient frontier is 16%
display('risky asset weight');
y=(.16-0.1)/(ereturn_market-.1)
display('risk-free asset weight');
1-y
%risk =25% expected return from markowitz efficient frontier is 23%
display('risky asset weight');
y=(.23-0.1)/(ereturn_market-.1)
display('risk-free asset weight');
1-y
% the protfoli 1
lambda= (C1 - (.16*B))/delta;
gamma=  ((.16*A)-B)/delta;
display('for 10% risk');
w_s=((lambda*A)*wg)+((gamma*B)*wt)
% the protfoli 2
lambda= (C1 - (.23*B))/delta;
gamma=  ((.23*A)-B)/delta;
display('for 25% risk');
w_s=((lambda*A)*wg)+((gamma*B)*wt)
