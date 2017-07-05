% Generates the figure of the current backend vs carmaker with the current
% model

% change this id to a saved 'net' file
modelstr = 'e-11.0375-64-32-16-8-trainscg-mse+1-98365rad2deg-size-5-lambda-1';

% add *.m file to the scoe
addpath('../../data/regulator/hyperparamtuning');

% load the saved workspace variable 'net'
net = importdata(strcat(modelstr, '.m'), 'net');

% create the neural net with the hardcoded name
genFunction(net, 'current_best_model.m');

% how to smooth the curves with movmean - rms depends on this
mediancount = 500;
meancount = 500;

initial_y_meancount = 1;

% 1 ~ every data point
% 5 ~ every 5th data point
stepSize = 1;

% adding csv wemding data
addpath('../../data/regulator');

csv_data_cm = csvread('cmerr_to_cmangle_rad2deg.csv', 2, 0);

from = 1;
to   = 98365; % 98365;

% ----------------------------------------------

X_CM = csv_data_cm(from:stepSize:to, 1:3);
X_CM = transpose(X_CM);

X_INIT = from:stepSize:to;

% -----------------------------------------------

Y_CM = csv_data_cm(from:stepSize:to, 4);
Y_CM = transpose(Y_CM);
Y_CM = movmean(Y_CM, initial_y_meancount);

Y_CBM        = current_best_model(X_CM);
Y_CBM_MEDIAN = medfilt1(Y_CBM, mediancount);
Y_CBM_MEAN   = movmean(Y_CBM_MEDIAN, meancount);

Y_CBM_RESULT = Y_CBM_MEAN;

% Y_CBM_RESULT = movmean(current_model(X_CM), meancount);

% rms ~ root mean sqaured error
cbm_cm_result_error = num2str(rms(Y_CM - Y_CBM_RESULT));
cbm_cm_median_error = num2str(rms(Y_CM - Y_CBM_MEDIAN));
cbm_cm_error        = num2str(rms(Y_CM - Y_CBM));

 
figure

subplot(3, 1, 1);
plot(X_INIT, Y_CM, X_INIT, Y_CBM_RESULT);

titlestr = 'Current approximation for the Steering Angle for both Backends (Carmaker/Grittr)\n';
titlestr = strcat(titlestr, ' with stepSize: ', num2str(stepSize), '\n');
titlestr = strcat(titlestr, ' after median + mean\n');
title(sprintf(strcat(titlestr, modelstr)));

xlabel('Timesteps in whatever the Hz of CM is');
ylabel('Steering Angle in Degrees');

y_cbm_cm_legend = 'X_{CM} \rightarrow Y, err: ';
y_cbm_cm_legend = strcat(y_cbm_cm_legend ...
                        , cbm_cm_result_error, ', ' ...
                        , strcat('smoothed by movmean(', num2str(meancount), ')') ...
                        , strcat(' and by medfilt1(', num2str(mediancount), ')'));

legend(strcat('CM-Backend, smoothed by movmean(' ...
     , num2str(initial_y_meancount),')') ...
     , y_cbm_cm_legend ...
     , 'Location', 'southeast');
 
% only median smoothing
subplot(3, 1, 2);
plot(X_INIT, Y_CM, X_INIT, Y_CBM_MEDIAN);

titlestr = 'Only Median smoothing';
title(titlestr);

xlabel('Timesteps in whatever the Hz of CM is');
ylabel('Steering Angle in Degrees');

y_cbm_cm_legend = 'X_{CM} \rightarrow Y, err: ';
y_cbm_cm_legend = strcat(y_cbm_cm_legend ...
                        , cbm_cm_median_error, ', ' ...
                        , strcat(' smoothed by medfilt1(', num2str(mediancount), ')'));

legend(strcat('CM-Backend, smoothed by movmean(' ...
     , num2str(initial_y_meancount),')') ...
     , y_cbm_cm_legend ...
     , 'Location', 'southeast');

% without smoothing
subplot(3, 1, 3);
plot(X_INIT, Y_CM, X_INIT, Y_CBM);

titlestr = 'Without smoothing';
title(titlestr); %sprintf(strcat(titlestr, modelstr)));

xlabel('Timesteps in whatever the Hz of CM is');
ylabel('Steering Angle in Degrees');

y_cbm_cm_legend = 'X_{CM} \rightarrow Y, err: ';
y_cbm_cm_legend = strcat(y_cbm_cm_legend ...
                        , cbm_cm_error);
                     %   , strcat('smoothed by movmean(', num2str(meancount), ')') ...
                     %   , strcat('and by medfilt1(', num2str(mediancount), ')'));

legend(strcat('CM-Backend, smoothed by movmean(' ...
     , num2str(initial_y_meancount),')') ...
     , y_cbm_cm_legend ...
     , 'Location', 'southeast');
