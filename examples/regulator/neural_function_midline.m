function [Y,Xf,Af] = neural_function_midline(X,Xi,~)
%NEURAL_FUNCTION_MIDLINE neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 14-Jul-2017 08:41:08.
% 
% [Y,Xf,Af] = neural_function_midline(X,Xi,~) takes these arguments:
% 
%   X = 1xTS cell, 1 inputs over TS timesteps
%   Each X{1,ts} = 3xQ matrix, input #1 at timestep ts.
% 
%   Xi = 1x4 cell 1, initial 4 input delay states.
%   Each Xi{1,ts} = 3xQ matrix, initial states for input #1.
% 
%   Ai = 3x0 cell 3, initial 4 layer delay states.
%   Each Ai{1,ts} = 10xQ matrix, initial states for layer #1.
%   Each Ai{2,ts} = 5xQ matrix, initial states for layer #2.
%   Each Ai{3,ts} = 1xQ matrix, initial states for layer #3.
% 
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = 1xQ matrix, output #1 at timestep ts.
% 
%   Xf = 1x4 cell 1, final 4 input delay states.
%   Each Xf{1,ts} = 3xQ matrix, final states for input #1.
% 
%   Af = 3x0 cell 3, final 0 layer delay states.
%   Each Af{1ts} = 10xQ matrix, final states for layer #1.
%   Each Af{2ts} = 5xQ matrix, final states for layer #2.
%   Each Af{3ts} = 1xQ matrix, final states for layer #3.
% 
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [-27.781;-1.6707;-0.30478];
x1_step1.gain = [0.0327659365323809;0.80681598141096;2.96081363158596];
x1_step1.ymin = -1;

% Layer 1
b1 = [-6.0055442671500456;-5.8619421598931458;-9.9352006211980957;11.059632196913972;-17.244019828360081;-0.88211909191836591;1.2909724909352609;-4.2526227765330704;0.34690405034252447;4.6638274682951302];
IW1_1 = [-1.8209639190132547 1.481480956513004 -1.1512686477092358 -1.815034146874964 1.3313369120259375 0.20840339675301064 -1.3740180491025589 1.3010776889191544 0.62075134762384543 -2.3335827923264256 1.3434466960907554 -0.20964696495311672;5.955762793267696 4.7306855384427697 -1.9678506566013811 5.915601704297722 2.942261253374983 -1.1969807249585422 5.159597727587049 2.221006002660078 -0.30908983900659542 4.2887344988044118 2.0744912375105575 -0.55493903301678216;3.1525817136103229 7.2160908976142792 1.9942442632777122 1.1983909514381497 6.9076585250256315 0.49294215083635073 -0.24862303214722903 5.1416378023979421 -1.1906489695640063 -1.2530310370899951 5.8325995582626495 -2.941010707932227;-6.6811065947719062 -11.083443325653702 2.8423052971338785 -2.4210336382283204 -7.583842660225482 1.560106588996806 1.3458937811459246 -5.5384033302943196 -0.43883005721605234 4.871699252494631 -2.2842219349689916 -1.6970207274965605;-2.4209396118129947 6.7398827428060875 2.4445667731032352 -0.27645772630088433 9.1638513563758508 0.37052954574213931 2.2199807376321408 10.843292755082061 -2.2136651234176234 4.496105507235173 13.370539513590833 -4.6763186726060431;-10.938136690697737 1.1940722671812223 1.8608262906173907 -7.9499922168289636 2.1152672748793546 0.25545918006686763 -6.3488655156918892 2.7324473934481537 -1.8505633619053929 -5.6580096704249634 3.6573056108135229 -2.4859985098675166;1.042721811081849 0.70061811896033677 -0.11803863173341958 0.63073931177790032 0.63152694476137172 0.47725039341461628 -0.45970519266117743 -0.88348445659359975 -0.18846461991598221 -1.203751764140881 -0.59806785786528749 -0.13997060350478607;1.6194564258531163 0.9493468062288698 1.6395582375176434 1.335791141193414 0.4527047559744537 0.32308711721692485 -0.49320221044104412 0.40957650646853738 -0.28344993256443718 -2.8129199897290613 -0.59848891691592787 -1.7502901310619206;1.8939287291570339 5.4294437268897981 0.0055658106476308882 -1.934806518919854 -0.4041266315820034 -0.014664941787636946 -1.7585449216614311 -2.7037500021719079 0.0038301080062578944 1.7685695877312013 -2.3157896655116015 0.0050269528141229118;0.78747174140685416 -0.84250757492161243 -0.52694286284273084 0.15094879924645074 -1.5110339227680878 -0.62814574988110372 0.13127347396809172 -1.2056418780732057 0.7728247971348744 -0.81544580008080891 -2.8685515888265298 1.3845932280568556];

% Layer 2
b2 = [-2.7565977975633751;0.63341464569396411;1.1217986346573225;-2.3850153774241312;2.1129714769138186];
LW2_1 = [-4.0509239371762398 6.4909149475622501 1.493903089213829 7.4146402449565567 0.75950660609436693 -0.82332589557609714 -6.1045520311507211 1.2726605461779621 2.3403104387314015 2.8653223517541342;-0.022973970087917312 -0.27989528479445158 1.4138326103656604 3.7056468766046957 2.3409834578720581 -0.27753451215210051 -1.5064453405320208 -0.0728458210194394 1.1598107890214793 -0.047313486238683929;-0.0083864731806555948 -0.10179373935722952 0.51379292177961089 1.3471845668932794 0.85141745993751539 -0.10055747986090223 -0.99316993733848291 -0.97089535054463094 -3.5911372679923876 -0.018202609912191848;-0.066265560626943346 -0.89663975848092659 4.4778492843570001 11.821763566656413 7.5163102739339962 -0.88736500635761961 4.3245374205112883 1.084819997215748 4.5621873000675777 -0.25793500252053508;-0.98812493608109053 -0.62348940450619517 2.0878526017006527 4.1236197239150956 0.036568185165409384 -0.28519778421708086 4.9422492616650864 -0.67655370466431131 -4.6131989900185051 0.20752251358444845];

% Layer 3
b3 = 0.80052537830870141;
LW3_2 = [-0.0051059188881188364 5.4931677131170229 -15.426504456600474 0.53161161872580343 0.52333731372237369];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 0.0204956312098103;
y1_step1.xoffset = -62.0459142857143;

% ===== SIMULATION ========

% Format Input Arguments
isCellX = iscell(X);
if ~isCellX
  X = {X};
end
if (nargin < 2), error('Initial input states Xi argument needed.'); end

% Dimensions
TS = size(X,2); % timesteps
if ~isempty(X)
  Q = size(X{1},2); % samples/series
elseif ~isempty(Xi)
  Q = size(Xi{1},2);
else
  Q = 0;
end

% Input 1 Delay States
Xd1 = cell(1,5);
for ts=1:4
    Xd1{ts} = mapminmax_apply(Xi{1,ts},x1_step1);
end

% Allocate Outputs
Y = cell(1,TS);

% Time loop
for ts=1:TS

      % Rotating delay state position
      xdts = mod(ts+3,5)+1;
    
    % Input 1
    Xd1{xdts} = mapminmax_apply(X{1,ts},x1_step1);
    
    % Layer 1
    tapdelay1 = cat(1,Xd1{mod(xdts-[1 2 3 4]-1,5)+1});
    a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*tapdelay1);
    
    % Layer 2
    a2 = tansig_apply(repmat(b2,1,Q) + LW2_1*a1);
    
    % Layer 3
    a3 = repmat(b3,1,Q) + LW3_2*a2;
    
    % Output 1
    Y{1,ts} = mapminmax_reverse(a3,y1_step1);
end

% Final Delay States
finalxts = TS+(1: 4);
xits = finalxts(finalxts<=4);
xts = finalxts(finalxts>4)-4;
Xf = [Xi(:,xits) X(:,xts)];
Af = cell(3,0);

% Format Output Arguments
if ~isCellX
  Y = cell2mat(Y);
end
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
  y = bsxfun(@minus,x,settings.xoffset);
  y = bsxfun(@times,y,settings.gain);
  y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
  a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
  x = bsxfun(@minus,y,settings.ymin);
  x = bsxfun(@rdivide,x,settings.gain);
  x = bsxfun(@plus,x,settings.xoffset);
end