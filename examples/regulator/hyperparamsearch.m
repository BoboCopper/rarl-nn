
tic

trainingFunctions = {'trainscg' };
costFunctions     = { 'mse' }; 

from = 1;
to   = 8741;
stepSizes = [1];

layer8 = [  [256 128 64   32  16  8  4   2]; ...  	   
            [512 256 128  64  32  16  8  4]; ...
            [200 175 150 125 100  75 50 25 ]; ...
            [300 250 200 175 125  75 50 25 ]; ...
            [400 350 300 275 200 150 75 50 ]; ...
            [500 450 350 300 200 100 50 25 ]; ...
         ];

layer10 = [  ... %[500  450 400 350 300 250 200 150 100  50];
            [ 300 250 225 200 175 150 125 100 75 50]; ...
%            [ 400 350 300 250 200 150 125 100 75 50]; ...
%            [600  550 500 400 300 250 200 150 100  50]; [ 700 600 500 450 400 350 300 250 75 25]; ...
            [1000 900 800 700 600 500 400 300 200 100]; 
          ];

for tfc = trainingFunctions
    for cfc = costFunctions
	for ss = 1:size(stepSizes)
        	[rows, ~] = size(layer8); 
        	for l = 1:rows
          	  	ffnet_runner_regulator(tfc{1}, layer8(l,:), cfc{1}, from, to, ss);
        	end

        	[rows, ~] = size(layer10); 
        	for l = 1:rows
            		ffnet_runner_regulator(tfc{1}, layer10(l,:), cfc{1}, from, to, ss);
        	end
	end
    end
end
toc
