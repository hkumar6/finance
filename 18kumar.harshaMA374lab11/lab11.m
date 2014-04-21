format long; clear all; clc;

% vasicek model
termstr1 = zeros(3, 10);
param = [5.9, 0.2, 0.3, 0.1;
         3.9, 0.1, 0.3, 0.2;
         0.1, 0.4, 0.11, 0.1];
figure
for i=1:3
    for j=1:10
        termstr1(i, j) = vasicek(param(i,1), param(i,2),...
            param(i,3), param(i,4), j);
    end
    plot(termstr1(i,:));
    hold on
end
hold off

rates = 0.1:0.05:0.55;
termstr2 = zeros(10, 500);
for n=1:3
    figure
    for i=1:10
        for j=1:500
            termstr2(i, j) = vasicek(param(n,1), param(n,2),...
                param(n,3), rates(i), j);
        end
        plot(termstr2(i, :));
        hold on
    end
    hold off
end