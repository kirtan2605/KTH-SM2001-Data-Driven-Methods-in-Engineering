clear all
close all
clc

%% Prepare the data
X = load('DataHw3Q1.mat').x;
t = load('DataHw3Q1.mat').t;
n = size(X,2);      % state dimension i.e. number of states

dt = t(2) - t(1);
dx_dt = diff(X) / dt;   % slope between 2 points, NOT at
x = (X(1:end-1,:) + X(2:end,:))/2; % datapoints at midpoint
% we will form SINDy using x and dx_dt


%% Build library and compute sparse regression
order = 3;
Theta = poolData(x,n,order,0); % up to third order polynomials
% Theta for order 3 gives the poolData as (x = x1, y = x2)
% [1, x, y, x*x, x*y, y*y, x*x*x, x*x*y, x*y*y, y*y*y]
% where column 1 contains variables c, and column 2 contain variables d
% [c0,0 c1,0 c0,1 c2,0 c1,1 c0,2 c3,0 c2,1 c1,2 c0,3]
% [d0,0 d1,0 d0,1 d2,0 d1,1 d0,2 d3,0 d2,1 d1,2 d0,3]
lambda = 0.025;
% lambda is our sparsification knob.
Xi = sparsifyDynamics(Theta,dx_dt,lambda,n);
%disp(Xi);

rowNames={'1','x','y','xx','xy','yy','xxx','xxy','xyy','yyy'};
colNames = {'x1dot','x2dot'};
sTable = array2table(Xi,'RowNames',rowNames,'VariableNames',colNames);
disp(sTable);
