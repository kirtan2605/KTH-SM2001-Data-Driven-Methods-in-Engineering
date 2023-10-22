clear all
close all
clc

b = readmatrix('hw1Q5b.dat');
C = readmatrix('hw1Q5C.dat');

%% non-sparse solution using pseudo inverse
xL2 = pinv(C)*b;

%% sparse solution using LASSO regularization
xL1 = lassoglm(C,b);

%% Method 1 of analyszing LASSO solutions
% Find the indices of non-zero values
nonZeroIndices = find(xL1(:,1));

% Display the non-zero indices
disp('Indices of non-zero values, hence the faulty coins :');
disp(nonZeroIndices);

%% Method 2 of analyszing LASSO solutions
% Convert non-zero values to 1 using logical indexing
xL1(xL1 ~= 0) = 1;

% Calculate the sum of rows
rowSums = sum(xL1, 2);

% Create a histogram
figure(1)
bar(rowSums);
title('Frequency of coin detected faulty across hyperparameters')
xlabel('Coin number')
ylabel('Frequency')