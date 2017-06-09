

trainingFunctions = {'trainlm', 'trainbr'};

costFunctions     = {'mse', 'sse'};

layerSingle = [ [10] , [20], [30], [40], [50], [60], [70], [80], [90], [100] ...
              , [120], [140], [160], [180], [200] ...
              , [300], [400], [600], [800], [1000]];
              
layerDouble = [ [10 5], [20 10], [30 15], [40 20], [50 25], [60 30], [70 35] ...
              , [100 50], [150 75], [200 100], [500 250], [1000 500]];
                     
layerTriple = [ [20 10 5], [30 15 7], [40 20 10], [50 25 12] ...
              , [80 40 20], [120 60 30], [160 80 40], [200 100 50] ...
              , [400 200 100], [600 300 150], [1000 500 250]];

layerQuadruple = [ [20 10 5 2], [30 15 7 4], [40 20 10 5], [50 25 12 6] ...
                 , [80 40 20 10], [100 50 25 12], [150 75 37 18] ...
                 , [200 100 50 25], [400 200 100 50] ...
                 , [600 400 200 100] ];

for tfc = trainingFunctions
    for cfc = costFunctions
        for l = layerSingle
            ffnet_runner_regulator(tfc{1}, l, cfc{1}, 40, 80);
        end
        
        for l = layerDouble
            ffnet_runner_regulator(tfc{1}, l, cfc{1}, 40, 80);
        end
        
        for l = layerTriple
            ffnet_runner_regulator(tfc{1}, l, cfc{1}, 40, 80);
        end
        
        for l = layerQuadruple
            ffnet_runner_regulator(tfc{1}, l, cfc{1}, 40, 80);
        end
    end
end