clear all
close all
clc
dy  = 0.01;
y = (-2:dy:2)'; %spatial coordinate

dt = 0.1;
Nt = 101;
tend = dt*(Nt-1);
t = 0:dt:tend; %time

% define function
amp1 = 1;
y01 = 0.5;
sigmay1  = 0.6;

amp2 = 1.2;
y02 = -0.5;
sigmay2  = 0.3;
omega1 = 1.3;
omega2 = 4.1;

v1 = amp1*exp(-(y-y01).^2/(2*sigmay1^2));
v2 = amp2*exp(-(y-y02).^2/(2*sigmay2^2));
X = v1*exp(1i*omega1*t) + v2*exp(1i*omega2*t);
