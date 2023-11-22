rng default % For reproducibility
% make changes for 52 * 52 * 25 
% 24 cameras 
% camera placement only on two planes
    % 2 or 3
    % 1 or 3 
profile on 
fun = @objective;
cameras=4;
lb=repmat([0,0,0,0,0],1,cameras);
ub=repmat([5,5,3,360,180],1,cameras);
options = optimoptions('ga','PlotFcn', @gaplotbestf, 'FunctionTolerance',1e-7);
x = ga(fun,5*cameras,[],[],[],[],lb,ub,[],1:5*cameras, options);

%% 
% 6,0,2,134,98,0,0,3,44,112,6,6,3,225,112,6,0,2,133,98,6,6,3,226,112,6,6,3,225,112,0,0,2,45,99,6,0,3,134,113,0,0,3,44,112,0,0,3,42,112,6,6,3,224,113,6,6,3,225,112
x= [     0 ,    5  ,   0 ,  330 ,   76 ,    5 ,    5    , 3 ,  210,   104  ,   5 ,    0   ,  3 ,  155,   107    , 0 ,    5    , 3  , 335  , 111];
plot_result(x,6,6,4,52,52,25)