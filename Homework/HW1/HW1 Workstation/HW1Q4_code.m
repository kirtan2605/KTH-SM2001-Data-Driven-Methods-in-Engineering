clear all
close all
clc

X = readmatrix('HW1Q4.csv');

% compute economy SVD
[Ue, Se, Ve] = svd(X,'econ');

% plot singular values
figure(1)
semilogy(diag(Se),'ro','Linewidth',1.5)
title('Singular values')
%xlabel('') 
%ylabel('Sine and Cosine Values')
figure(2)
semilogy(diag(Se),'ro','Linewidth',1.5)
xlim([0 10])
ylim([5 200])
title('First 10 Singular values')

%% reduce rank to 3 i.e projection of data in first 3 singular vectors
r = 3;
Ur=Ue(:,1:r);
Sr=Se(1:r,1:r);
Vr=Ve(:,1:r);

% plot first three left and right singular vectors
figure(3)
subplot(2,1,1), plot(real(Ur),'Linewidth',1)
xlim([0 length(Ur)])
title('Left Singular Vectors')
legend({'First','Second','Third'},'Location','bestoutside')

subplot(2,1,2), plot(real(Vr),'Linewidth',1)
xlim([0 length(Vr)])
title('Right Singular Vectors')
legend({'First','Second','Third'},'Location','bestoutside')

% reconstruct projected data to calculate Frobenius norm
X_r = Ur*Sr*Vr';
frobenius_norm = norm(X_r,"fro");
fprintf('Square of Frobenius norm of projected data : %f \n', frobenius_norm*frobenius_norm)
sum_singular_values = sum(diag(Sr*Sr));
fprintf('Sum of squares of singular values of projected space : %f \n \n', sum_singular_values)
