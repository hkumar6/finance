format long; clear all; clc;

steps = 1000;
n = 10;
mu = 0.1; sig = 0.2; start = 100; r = 0.05;

% simulate 10 paths of asset price
gbmreal = zeros(n, steps);
for i=1:n
    gbmreal(i,:) = geometricbrownian(mu, sig, start, steps);
    figure
    plot(gbmreal(i,:))
    title('Real world')
end

gbmrfree = zeros(n, steps);
for i=1:n
    gbmrfree(i,:) = geometricbrownian(r, sig, start, steps);
    figure
    plot(gbmrfree(i,:))
    title('Risk free')
end


% pricing Asian options
K = [105, 110, 90];
n = 100;
for i=1:length(K)
    tempcall = 0;
    tempput = 0;
    for j=1:n
        tempcall = tempcall + max(mean(geometricbrownian(r, sig, start, steps)) - K(i), 0);
        tempput = tempput + max(K(i) - mean(geometricbrownian(r, sig, start, steps)), 0);
    end
    call = exp(-r)*tempcall/n;
    put = exp(-r)*tempput/n;
    disp(['strike = ', num2str(K(i)), '; call = ', num2str(call), '; put = ', num2str(put)]);
end