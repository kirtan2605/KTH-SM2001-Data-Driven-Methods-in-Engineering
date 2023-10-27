function [] = FFT_RGB(A)
%SVD_RGB
%   A function to reconstruct an RGB image after
%   performing SVD on the color channels seperately
%   and then recombining the RGB image

nx = size(A,1); ny = size(A,2);

% Extract RGB Channels and convert to double precision from uint8
R=double(A(:,:,1));         % red plane
G=double(A(:,:,2));         % green plane
B=double(A(:,:,3));         % blue plane

% Perform FFT
R_fft = fft2(R);
G_fft = fft2(G);
B_fft = fft2(B);


Rfft_sort = sort(abs(R_fft(:)));
Gfft_sort = sort(abs(G_fft(:)));
Bfft_sort = sort(abs(B_fft(:)));

for keep = [0.1027 0.0257 0.0103 0.0051 0.0021 0.001]    % storage fraction to use
    %disp('Storage Fraction')
    %disp(keep)
    %disp(' ')
    figure;
    % Red Channel
    thresh = Rfft_sort(floor((1-keep)*length(Rfft_sort)));
    ind = abs(R_fft)>thresh;
    Rtlow = R_fft.*ind;
    Rlow = uint8(ifft2(Rtlow));
    %disp('Number of Coeff in R')
    %disp(nnz(ind))
    
    % Green Channel
    thresh = Gfft_sort(floor((1-keep)*length(Gfft_sort)));
    ind = abs(G_fft)>thresh;
    Gtlow = G_fft.*ind;
    Glow = uint8(ifft2(Gtlow));
    %disp('Number of Coeff in G')
    %disp(nnz(ind))
    
    % Blue Channel
    thresh = Bfft_sort(floor((1-keep)*length(Bfft_sort)));
    ind = abs(B_fft)>thresh;
    Btlow = B_fft.*ind;
    Blow = uint8(ifft2(Btlow));
    %disp('Number of Coeff in B')
    %disp(nnz(ind))

    Mk(:,:,1) = Rlow;
    Mk(:,:,2) = Glow;
    Mk(:,:,3) = Blow;

    imshow(Mk), axis off
    title(['Retained=',num2str((keep*100),'%d'),'%']);
    filename = ['CompressedImage Storage=',num2str((keep*100),'%d'),'%.bmp'];
    imwrite(uint8(Mk),filename)
end




%% Plot Singular & Cummulative Energy vs rank 'r'
singular_values = figure;
semilogy(flip(Rfft_sort),'LineWidth',1.2,'Color','Red')
hold on
semilogy(flip(Gfft_sort),'LineWidth',1.2,'Color','Green')
semilogy(flip(Bfft_sort),'LineWidth',1.2,'Color','Blue')
grid on
xlabel('Number of Coefficients')
ylabel('FFT Coefficients')
%xlim([-50 1500])
legend('Red Channel', 'Green Channel', 'Blue Channel')
hold off
saveas(singular_values,'FFT_Coefficients sorted.bmp')


cummulative_energy = figure;
semilogy((cumsum(flip(Rfft_sort)))/sum(flip(Rfft_sort)),'LineWidth',1.2,'Color','Red')
hold on
semilogy((cumsum(flip(Gfft_sort)))/sum(flip(Gfft_sort)),'LineWidth',1.2,'Color','Green')
semilogy((cumsum(flip(Bfft_sort)))/sum(flip(Bfft_sort)),'LineWidth',1.2,'Color','Blue')
grid on
xlabel('Number of Coefficients')
ylabel('Cumulative Energy') 
xlim([-50 3000000]); ylim([0 1.0001])
legend('Red Channel', 'Green Channel', 'Blue Channel')
hold off
saveas(cummulative_energy,'CummulativeEnergy_vs_N.bmp')
%}
