addpath('../../data/regulator');

from = 1;
to = 98365; % #timesteps in cmerr_to_cmangle_rad2deg.csv

stepSize = 1; % stepsize to take in cmerr_to_cmangle_rad2deg.csv

tic

csv_data_cm = csvread('cmerr_to_cmangle_rad2deg.csv', 2, 0);
% csv_data_rg = csvread('data_wemding_regulator.csv', 2, 0);

X_CM = csv_data_cm(from:stepSize:to, 1:3);
X_CM = transpose(X_CM);

Y_CM = csv_data_cm(from:stepSize:to, 4);
Y = transpose(Y_CM);
Y = movmean(Y,70);

toc