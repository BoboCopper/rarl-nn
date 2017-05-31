% Moved network testing to a single function

function [ trainingError, testError, validationError ] = trainingdata(net, X, Y, tr)

% Test network
Y_= net(X);
% e = gsubtract(Y,Y_);
% performance = perform(net,Y,Y_)

% Recalculate Training, Validation and Test Performance
  trainTargets    = Y .* tr.trainMask{1};
  valTargets      = Y .* tr.valMask{1};
  testTargets     = Y .* tr.testMask{1};
 
  trainingError   = perform(net,trainTargets,Y_);
  testError       = perform(net,testTargets,Y_);
  validationError = perform(net,valTargets,Y_);
  
% ------------------------------------------------------------------

end