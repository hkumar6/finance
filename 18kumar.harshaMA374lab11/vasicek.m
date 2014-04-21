function [ y ] = vasicek( beta, mu, sigma, r, T )
%VASICEK the vasicek term structure yield; p(0,T)

B = (1 - exp(-beta*T))/beta;
A = (B - T)*(beta*beta*mu - sigma*sigma*0.5)/(beta*beta) - beta*B*B/4;
p = exp(A - B*r);
y = -log(p)/T;

end