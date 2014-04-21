function [  ] = analysemarketdata( csv_file )
%ANALYSEMARKETDATA analyse market data of a stock/index stored as a csv
%   analysemarketdata('filename')

data = flipud(csvread(csv_file));

%part 1 : plot
figure
plot(data);
title('Time plot');

%part 2 : returns
returns = (data(2:end) - data(1:end-1))./data(1:end-1);
mu = mean(returns);
sig = std(returns);
nreturns = (returns - mu)/sig;
figure
histfit(nreturns);
title('Normalised returns');

%part 3 : log returns
lreturns = log(1 + returns);
figure
histfit(lreturns);
title('Log returns');

end