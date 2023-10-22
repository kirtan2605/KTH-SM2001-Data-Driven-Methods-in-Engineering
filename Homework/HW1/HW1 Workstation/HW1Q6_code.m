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


%% Part (a) : SVD analysis
% compute SVD
[U, S, V] = svd(X);

% plot singular values
semilogy(diag(S)/sum(diag(S)),'o')

% plot first two left singular vectors against the spatial coordinate y
figure(1)
plot(real(U(:,1:2)), 1:length(U(:,1:2)),'Linewidth',2)
ylim([0 length(U)])
title('Left Singular Vectors')
legend({'First','Second'},'Location','best')


%% Part (b) : DMD analysis
%% DMD
X1=X(:,1:end-1);
X2=X(:,2:end);

[U_X1,S_X1,V_X1]=svd(X1,'econ');

% Truncate to rank r
r = 10;  % Adjust as needed

Ur = U_X1(:, 1:r);
Sr = S_X1(1:r, 1:r);
Vr = V_X1(:, 1:r);

% Compute the approximate DMD matrix A
A_tilda = Ur'*X2*Vr/Sr;

% Compute the eigenvalues and eigenvectors of A
[eig_vec, eig_val] = eig(A_tilda);

% plot eigen values (same for A and A_tilda)
figure(2)
semilogy(real(diag(eig_val)),'ro','Linewidth',1.5)
title(['First ', num2str(r), ' Singular Values'])

% Compute eigen vectors of A
A = Ur * A_tilda * Ur';
[eig_vec_A, eig_val_A] = eig(A);
figure(3)
plot(real(eig_vec_A(:,1:2)), 1:length(eig_vec_A(:,1:2)),'Linewidth',1.5)
ylim([0 length(eig_vec_A)])
title('Eigen Vectors of A')
legend({'First','Second'},'Location','best')


%% Part (c) : Analysing eigenvalues of A
% Compute the DMD modes and frequencies
DMD_modes = X2 * Vr / Sr * eig_vec;
DMD_frequencies = log(diag(eig_val)) / dt;  % dt is the time step

% display frequencies corresponding to non-zero eigen values
disp(DMD_frequencies(1:2,:));


%% Part (d) : best two spatial locations using QR pivoting method
% the tailored basis would be DMD modes
% Perform QR decomposition with pivoting
[Q, R, pivot] = qr(DMD_modes', 'vector');

% Q is the orthogonal matrix
% R is the upper triangular matrix,
% P is a permutation vector that indicates the column permutation
r = 2;          % we want best r spatial locations for sensors
sensors = pivot(1:r);
disp(sensors)