load(fullfile(matlabroot,'examples','nnet','LettersClassificationNet.mat'))

net.Layers

digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos', ...
    'nndatasets','DigitDataset');

digitData = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

[trainDigitData,testDigitData] = splitEachLabel(digitData,0.5,'randomize');

numImages = numel(trainDigitData.Files);
idx = randperm(numImages,20);
for i = 1:20
    subplot(4,5,i)

    I = readimage(trainDigitData, idx(i));

    imshow(I)
end

layersTransfer = net.Layers(1:end-3);

numClasses = numel(categories(trainDigitData.Labels))

layers = [ ...
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

optionsTransfer = trainingOptions('sgdm', ...
    'MaxEpochs',5, ...
    'InitialLearnRate',0.0001);

netTransfer = trainNetwork(trainDigitData,layers,optionsTransfer);

YPred = classify(netTransfer,testDigitData);
YTest = testDigitData.Labels;

accuracy = sum(YPred==YTest)/numel(YTest)   

idx = 501:500:5000;
figure
for i = 1:numel(idx)
    subplot(3,3,i)

    I = readimage(testDigitData, idx(i));
    label = char(YTest(idx(i)));

    imshow(I)
    title(label)
end