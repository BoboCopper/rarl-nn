% Generates the figure of the current backend vs carmaker with the current
% model

% change this id to a saved 'net' file
modelstr = 'e-18.0634-400-350-300-250-200-150-125-100-75-50-trainscg-mse+40-8500';

% add *.m file to the scoe
addpath('../../data/regulator/hyperparamtuning');

% load the saved workspace variable 'net'
net = importdata(strcat(modelstr, '.m'), 'net');

% create the neural net with the hardcoded name
genFunction(net, 'current_model.m');

% how to smooth the curves with movmean - mse depends on this
meancount = 70; 

% adding csv wemding data
addpath('../../data/regulator');

csv_data_cm = csvread('data_wemding_cm.csv', 2, 0);
csv_data_gr = csvread('data_wemding_regulator.csv', 2, 0);

from = 40;
to   = 8500;

% ----------------------------------------------

X_CM = csv_data_cm(from:to, 2:4);
X_CM = transpose(X_CM);

X_GR = csv_data_gr(from:to, 2:4);
X_GR = transpose(X_GR);

X_INIT = from:1:to;

% -----------------------------------------------

Y_CM = csv_data_cm(from:to, 5);
Y_CM = transpose(Y_CM);
Y_CM = movmean(Y_CM,70);

Y_GR = csv_data_gr(from:to, 5);
Y_GR = transpose(Y_GR);
Y_GR = movmean(Y_GR,meancount);

Y_CBM_CM = movmean(current_model(X_CM), meancount);
Y_CBM_GR = movmean(current_model(X_GR), meancount);

% Y_CBM_CM = current_best_model(X_CM);
% Y_CBM_GR = current_best_model(X_GR);


cbm_gr_error = num2str(mean(pow2(Y_CM - Y_CBM_GR)));
cbm_cm_error = num2str(mean(pow2(Y_CM - Y_CBM_CM)));
gr_error     = num2str(mean(pow2(Y_CM - Y_GR)));
 
figure
subplot(2, 1, 1);
plot(X_INIT, Y_CM, X_INIT, Y_GR);
title 'Backend Steering Angle';
xlabel('Timesteps in whatever the Hz of CM is');
ylabel('Steering Angle in Degrees');

y_gr_legend = 'Grittr Backend, err: ';
y_gr_legend = strcat(y_gr_legend, gr_error, ', ', strcat(' smoothed by movmean(', num2str(meancount), ')'));
legend('CM-Backend, smoothed by movmean(70)', y_gr_legend, 'Location', 'southeast');

subplot(2, 1, 2);
plot(X_INIT, Y_CM, X_INIT, Y_CBM_CM, X_INIT, Y_CBM_GR);

titlestr = 'Current approximation for the Steering Angle for both Backends (Carmaker/Grittr)\n';
title(sprintf(strcat(titlestr, modelstr)));

xlabel('Timesteps in whatever the Hz of CM is');
ylabel('Steering Angle in Degrees');


y_cbm_cm_legend = 'X_{CM} \rightarrow Y, err: ';
y_cbm_cm_legend = strcat(y_cbm_cm_legend, cbm_cm_error, ', ', strcat('smoothed by movmean(', num2str(meancount), ')'));

y_cbm_gr_legend = 'X_{GR} \rightarrow Y, err: ';
y_cbm_gr_legend = strcat(y_cbm_gr_legend, cbm_gr_error, ', ', strcat('smoothed by movmean(', num2str(meancount), ')'));

legend('CM-Backend, smoothed by movmean(70)', y_cbm_cm_legend, y_cbm_gr_legend, 'Location', 'southeast');
