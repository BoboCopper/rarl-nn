
tic

trainingFunctions = {'trainscg' };
costFunctions     = { 'mse' }; 

from = 40;
to   = 8500;

layer8 = [ [200 180 160 140 120 100 50 20]; [ 200 175 150 125 100  75 50 25 ]; ...
           [200 100  80  60  40  20 10  5]; [ 300 250 200 175 125  75 50 25 ]; ...
           [400 350 300 275 200 150 75 50]; [ 500 450 350 300 200 100 50 25 ]; ...
         ];

layer10 = [ [500  450 400 350 300 250 200 150 100  50]; [ 300 250 225 200 175 150 125 100 75 50]; ...
            [1000 900 800 700 600 500 400 300 200 100]; [ 400 350 300 250 200 150 125 100 75 50]; ...
            [600  550 500 400 300 250 200 150 100  50]; [ 700 600 500 450 400 350 300 250 75 25]; ...
          ];

for tfc = trainingFunctions
    for cfc = costFunctions
        [rows, ~] = size(layer8); 
        for l = 1:rows
            ffnet_runner_regulator(tfc{1}, layer8(l,:), cfc{1}, from, to);
        end

        [rows, ~] = size(layer9); 
        for l = 1:rows
            ffnet_runner_regulator(tfc{1}, layer9(l,:), cfc{1}, from, to);
        end
     end
end
toc
