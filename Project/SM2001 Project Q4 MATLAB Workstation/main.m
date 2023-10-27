clear all
close all  
clc

%%
A=imread('KTH_photo.jpg'); % Original image: 1704*2272 pixels

%% SVD of RGB image : Multi-Channel Compression
SVD_RGB(A);         

%% Fourier of RGB image : Multi-Channel 2D FFT
FFT_RGB(A); 

