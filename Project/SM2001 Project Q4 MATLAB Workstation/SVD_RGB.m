function [] = SVD_RGB(A)
%SVD_RGB
%   A function to reconstruct an RGB image after
%   performing SVD on the color channels seperately
%   and then recombining the RGB image

nx = size(A,1); ny = size(A,2);

% Extract RGB Channels and convert to double precision from uint8
R=double(A(:,:,1));         % red plane
G=double(A(:,:,2));         % green plane
B=double(A(:,:,3));         % blue plane

% Perform SVD
[UR,SR,VR] = svd(R,'econ');
[UG,SG,VG] = svd(G,'econ'); 
[UB,SB,VB] = svd(B,'econ'); 


%% Plot and Save Original and Compressed Images
figure; 
imshow(A)
title('Original')
imwrite(uint8(A),'OriginalImage.bmp')

for r=[1 2 5 10 25 100]  % Truncation value
    figure;
    Mk(:,:,1) = UR(:,1:r)*SR(1:r, 1:r)* VR(:,1:r)';
    Mk(:,:,2) = UG(:,1:r)*SG(1:r, 1:r)* VG(:,1:r)';
    Mk(:,:,3) = UB(:,1:r)*SB(1:r, 1:r)* VB(:,1:r)';
    imshow(uint8(Mk));
    % check + r
    title(['r=',num2str(r,'%d'),', ',num2str(100*(r*(nx+ny) + r)/(nx*ny),'%2.2f'),'% storage']);
    filename = ['CompressedImage r=',num2str(r,'%d'),'.bmp'];
    imwrite(uint8(Mk),filename)
end


%% Plot Singular & Cummulative Energy vs rank 'r'
singular_values = figure;
semilogy(diag(SR),'LineWidth',1.2,'Color','Red')
hold on
semilogy(diag(SG),'LineWidth',1.2,'Color','Green')
semilogy(diag(SB),'LineWidth',1.2,'Color','Blue')
grid on
xlabel('r')
ylabel('Singular value, \sigma_r')
xlim([-50 1500])
legend('Red Channel', 'Green Channel', 'Blue Channel')
hold off
saveas(singular_values,'SingularValues_vs_r.bmp')

cummulative_energy = figure;
semilogy(cumsum(diag(SR).^2)/sum(diag(SR).^2),'LineWidth',1.2,'Color','Red')
hold on
semilogy(cumsum(diag(SG).^2)/sum(diag(SG).^2),'LineWidth',1.2,'Color','Green')
semilogy(cumsum(diag(SB).^2)/sum(diag(SB).^2),'LineWidth',1.2,'Color','Blue')
grid on
xlabel('r')
ylabel('Cumulative Energy') 
xlim([-50 1500]); ylim([0 1.1])
legend('Red Channel', 'Green Channel', 'Blue Channel')
hold off
saveas(cummulative_energy,'CummulativeEnergy_vs_r.bmp')

end