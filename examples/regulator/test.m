function [Y,Xf,Af] = test(X,Xi,~)
%TEST neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 04-Jul-2017 16:26:09.
% 
% [Y,Xf,Af] = test(X,Xi,~) takes these arguments:
% 
%   X = 1xTS cell, 1 inputs over TS timesteps
%   Each X{1,ts} = 3xQ matrix, input #1 at timestep ts.
% 
%   Xi = 1x4 cell 1, initial 4 input delay states.
%   Each Xi{1,ts} = 3xQ matrix, initial states for input #1.
% 
%   Ai = 2x0 cell 2, initial 4 layer delay states.
%   Each Ai{1,ts} = 10xQ matrix, initial states for layer #1.
%   Each Ai{2,ts} = 1xQ matrix, initial states for layer #2.
% 
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = 1xQ matrix, output #1 at timestep ts.
% 
%   Xf = 1x4 cell 1, final 4 input delay states.
%   Each Xf{1,ts} = 3xQ matrix, final states for input #1.
% 
%   Af = 2x0 cell 2, final 0 layer delay states.
%   Each Af{1ts} = 10xQ matrix, final states for layer #1.
%   Each Af{2ts} = 1xQ matrix, final states for layer #2.
% 
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [-26.324;-0.73774;-0.305];
x1_step1.gain = [0.0361814136078297;1.09031041137412;2.95967443581206];
x1_step1.ymin = -1;

% Layer 1
b1 = [1.8129679794487508;-0.58024245653036266;-0.010431337141166442;0.044510829501628935;-0.30466433263238468;0.72617165875289247;0.25887297225043843;1.7674040673297859;0.61300509199427877;0.094662070888822447];
IW1_1 = [-2.1865313830983779 0.29834094474873091 -0.53041317915314712 -1.3195636484367821 0.4496758615969535 -0.44638285506100239 1.2223315625303439 -0.24750958064512676 0.39334558936123454 2.4924773298834775 -2.8232915534748035 1.3624295923959746;-3.4526145161581598 -14.471708841222743 -1.2926248055327247 2.4728276875668902 -3.071906633627747 -0.70960551973895569 2.2744689811284382 5.8560206913544643 -0.394108295528449 -1.0162100018827851 11.672391162755829 1.8141595644177646;3.1819838945815455 -4.0857788416162517 1.0646363278753006 0.40758219124479639 0.38881922767352689 0.40192620250632022 -0.63837033858640868 1.7978317615668451 -0.84699819679641075 -3.0391629762101693 0.75597724682573431 -0.51164706103265789;3.1178651545944565 -0.16860870281656093 -1.4475311471985637 0.90359173457666686 0.92319584365465601 -0.59012328074661302 -1.6930450646847339 1.0958945280834274 1.1390821033744238 -2.1313759395293483 -0.54678982370669393 0.88757406177228682;1.9258040234116833 -7.286596933203521 0.70536334262598721 4.3541780976948878 0.95652488800979318 -0.27745079861155814 1.3116208429371476 3.643219585070939 1.1856575543705541 -7.5157650233065825 2.4429208815807684 -1.3625590375687651;0.72803746726289376 0.9829780305514294 1.9678524237274224 -0.30859722010165402 -0.13064569395016373 0.31916310234287099 0.26351394309944265 0.0051013385526170289 -0.45765065473000882 0.10549626322760325 -1.0151107146373091 -2.5039955729059447;3.7014566460501945 1.4045640522593021 -0.32846737352001326 -1.5313941895967214 0.05458994396884622 -0.98078241223402995 -1.9805216170115814 -1.0685933143287261 1.1905973222556119 -0.037295011981660998 -0.36898472622774486 -0.14991424702210054;1.9480815343309192 -2.7479942456208621 -0.19809814769593106 1.2723066386973392 -1.4376184861013663 -0.56475693024797302 -0.35711832739095428 -0.68205232477497557 0.91155930158853027 -2.6243166194733538 2.6451190926219783 0.62208749736640068;-7.1619167837942435 3.6979919386386335 -1.1731699155623803 -3.3436834161548701 1.6723185003785388 -0.67375498781359011 1.6282101729138789 -2.2802401869245732 -0.18119547497528432 8.9602223560560006 -3.0254866667211107 1.4534096556123932;0.30671353786548489 9.4556573625132483 0.2618729420583174 -2.151110155089607 0.96573629178468234 0.1264035028199226 -1.8177690490144596 -4.7908726488857987 -0.29053616458389897 3.5789482897634457 -6.1776193116559082 -0.054299128951025899];

% Layer 2
b2 = -4.0716049202296594;
LW2_1 = [4.410611505712513 -4.5360510012756494 -6.7484499399800253 -3.2820341847371348 -13.401451484138933 -0.29055164825486579 11.955002631456633 -5.26788050992322 -9.8453955173783783 12.129412985199822];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 0.0202829412351036;
y1_step1.xoffset = -56.2361142857143;

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
    a2 = repmat(b2,1,Q) + LW2_1*a1;
    
    % Output 1
    Y{1,ts} = mapminmax_reverse(a2,y1_step1);
end

% Final Delay States
finalxts = TS+(1: 4);
xits = finalxts(finalxts<=4);
xts = finalxts(finalxts>4)-4;
Xf = [Xi(:,xits) X(:,xts)];
Af = cell(2,0);

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
