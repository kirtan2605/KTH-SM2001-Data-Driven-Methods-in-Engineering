clear all
close all
clc

%% Load the data
X = load('data.mat').X;
% 30x3 data matrix for 30 different
% Column1 : strength [MPa]
% Column2 : strain to failure [%]
% Column3 : elastic modulus [GPa]

%% Normalize dataset
mean = mean(X);
stdDev = std(X);
zNormalData = normalize(X);
%X_reconstructed = zNormalData.*stdDev + mean;


%% Part (a) : K-means clustering
K = 3;
numInitializations = 1000;       % define the number of random initializations
choiceMultiple = 10;    
% random centroids generated are numInitializations*choiceMultiple
% this is done to further increase randomness by using datasample
paddedNumInits = choiceMultiple*numInitializations;

% Variables to store the results
bestIdx = [];
bestCentroids = [];
bestWCSS = Inf;
randomCentroids = [randn(paddedNumInits, 1), randn(paddedNumInits, 1), randn(paddedNumInits, 1)];

for i = 1:numInitializations
    % Randomly initialize cluster centroids
    initialCentroids = datasample(randomCentroids, K, 'Replace', false);
    
    % Perform K-means clustering with these initial centroids
    [idx, centroids, sumd] = kmeans(zNormalData, K, 'Start', initialCentroids);
    
    % Calculate the total within-cluster sum of squares (WCSS)
    wcss = sum(sumd);
    
    % Check if this initialization results in a lower WCSS
    if wcss < bestWCSS
        bestIdx = idx;
        bestCentroids = centroids;
        bestWCSS = wcss;
        %disp(bestWCSS);
    end
end


% Plot the best clustered data
colors = ['r', 'g', 'b', 'c', 'm', 'y', 'k'];
figure;
hold on;
for i = 1:K
    cluster_points = zNormalData(bestIdx == i, :);

    scatter3(cluster_points(:, 1), cluster_points(:, 2), cluster_points(:, 3), 50, colors(i),'filled', 'DisplayName', ['Cluster ',num2str(i,'%d') ]);
end
colormap('jet');  % Set the colormap as needed
scatter3(bestCentroids(:, 1), bestCentroids(:, 2), bestCentroids(:, 3), 200, 'k', 'Marker', 'x', 'LineWidth',2, 'DisplayName', 'Centroid');
title(['K-means clustering of z-normalized data;  K=',num2str(K,'%d')]);
legend('Location', 'Best');
grid on;
hold off;

% Set the perspective view
view(-30, -30); % Azimuth: 30 degrees, Elevation: 45 degrees


%{
% Plot reconstructed data
X_reconstructed = zNormalData.*stdDev + mean;
bestCentroidsScaled = bestCentroids.*stdDev + mean;

% Plot the best clustered data
colors = ['r', 'g', 'b', 'c', 'm', 'y', 'k'];
figure;
hold on;
for i = 1:K
    cluster_points = X_reconstructed(bestIdx == i, :);
    scatter3(X_reconstructed(:, 1), X_reconstructed(:, 2), X_reconstructed(:, 3), 50, colors(i),'filled', 'DisplayName', ['Cluster ',num2str(i,'%d') ]);
end
colormap('jet');  % Set the colormap as needed
scatter3(bestCentroidsScaled(:, 1), bestCentroidsScaled(:, 2), bestCentroidsScaled(:, 3), 200, 'k', 'Marker', 'x', 'LineWidth',2, 'DisplayName', 'Centroid');
title(['K-means clustering of data;  K=',num2str(K,'%d')]);
legend('Location', 'Best');
grid on;
hold off;
% Set the perspective view
view(-30, -30); % Azimuth: 30 degrees, Elevation: 45 degrees
%}

%% Part (b) : Hierarchical clustering

% Perform hierarchical clustering
Z = linkage(zNormalData, 'ward'); % You can choose different linkage methods

% Visualize the hierarchical clustering using a dendrogram
figure;
dendrogram(Z);

title('Hierarchical Clustering Dendrogram');
xlabel('Data Points');
ylabel('Distance');

% Use Hierarchical Clustering to form Clusters
T = cluster(Z,"maxclust",3);

% Display the clusters using different colors in a scatter plot
figure;
scatter3(zNormalData(:, 1), zNormalData(:, 2), zNormalData(:, 3), 50, T, 'filled');
title('Clusters from Hierarchical Clustering');
colormap('jet');

% Set the perspective view
view(-30, -30); % Azimuth: 30 degrees, Elevation: 45 degrees
