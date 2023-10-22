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



%% SVD analysis
% compute SVD
[U, S, V] = svd(X);

% plot singular values
semilogy(diag(S)/sum(diag(S)),'o')

% plot first two left singular vectors against the spatial coordinate y
figure(1)
plot(real(U(:,1:2)), 1:length(U(:,1:2)),'Linewidth',[2])



%% DMD analysis
%% DMD
r = 100;
X1=X(:,1:end-1);
X2=X(:,2:end);

[U_X1,S_X1,V_X1]=svd(X1,'econ');
Ur=U_X1(:,1:r);
Sr=S_X1(1:r,1:r);
Vr=V_X1(:,1:r);



% Build A
A = Ur'*X2*Vr/Sr;
[W,D]=eig(A);

%% spectrum
% alternate scaling of DMD modes
%Ahat = (S_X1^(-1/2))*Atilde*(S_X1^(1/2));
%[What,D]=eig(Ahat); %solve eigenvalue problem
%W_r = Sr^(1/2)*What;
%Phi = X2*Vr/Sr*W_r;

% plot DMD modes
figure(2)
plot(real(W(1:10,1:2)),'Linewidth',[2])