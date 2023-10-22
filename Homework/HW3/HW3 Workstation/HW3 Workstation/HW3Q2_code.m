clear all
close all
clc

%% Load the data
labelledData = load('labelledNonLinearDataset.mat').data;
% 1200x4 data matrix
% Column1 : labels
% Column2 : X coordinates
% Column3 : Y coordinates
% Column4 : Z coordinates

label = labelledData(:,1);  % this is the true classification
X = labelledData(:,2:4);

% number of true classes in the data
K = 3;

% Plot the data with tru label
colors = ['r', 'g', 'b', 'c', 'm', 'y', 'k'];
figure;
hold on;
for i = 1:K
    cluster_points = X(label == i, :);
    scatter3(cluster_points(:, 1), cluster_points(:, 2), cluster_points(:, 3), 50, colors(i),'filled', 'DisplayName', ['Cluster ',num2str(i,'%d') ], 'MarkerEdgeColor', 'k');
end
colormap('jet');  % Set the colormap as needed
title(['Data with True Classification;  K=',num2str(K,'%d')]);
%legend('Location', 'Best');
grid on;
hold off;

% Set the perspective view
view(-30, -30); % Azimuth: 30 degrees, Elevation: 45 degrees




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
upscaledCentroids = bestCentroids.*stdDev + mean;
colors = ['r', 'g', 'b', 'c', 'm', 'y', 'k'];
figure;
hold on;
for i = 1:K
    cluster_points = X(bestIdx == i, :);

    scatter3(cluster_points(:, 1), cluster_points(:, 2), cluster_points(:, 3), 50, colors(i),'filled', 'DisplayName', ['Cluster ',num2str(i,'%d') ], 'MarkerEdgeColor', 'k');
end
colormap('jet');  % Set the colormap as needed
scatter3(upscaledCentroids(:, 1), upscaledCentroids(:, 2), upscaledCentroids(:, 3), 200, 'k', 'Marker', 'x', 'LineWidth',2, 'DisplayName', 'Centroid');
title(['K-means Clustering Classification of the data;  K=',num2str(K,'%d')]);
%legend('Location', 'Best');
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

% Create Confusion Matrix to check Classification of Non-Linear Dataset
trueClassifications = label;
predictedClassifications = bestIdx;

% Create a confusion matrix
C = confusionmat(trueClassifications, predictedClassifications);

% Display the confusion matrix
disp('Confusion Matrix:');
disp(C);



% But this might lead to false inference since the numbering of the
% newly formed clusters can be changed to ensure that the number 
% assigned to the cluster is such that it maximizes diagonal elements.
% i.e. we can get better inference by row and column swapping

% Calculate the sum of diagonal elements
initial_diagonal_sum = sum(diag(C));

% Generate all possible permutations of row indices and column indices
n = size(C, 1); % Assuming a square matrix
row_permutations = perms(1:n);
col_permutations = perms(1:n);

max_diagonal_sum = initial_diagonal_sum;
best_row_permutation = 1:n;
best_col_permutation = 1:n;

% Iterate through all row and column permutations to find the best diagonal sum
for i = 1:size(row_permutations, 1)
    for j = 1:size(col_permutations, 1)
        B = C(row_permutations(i, :), col_permutations(j, :));
        diagonal_sum = sum(diag(B));
        if diagonal_sum > max_diagonal_sum && B(1,1) > B(2,2) && B(2,2) > B(3,3) 
            max_diagonal_sum = diagonal_sum;
            best_row_permutation = row_permutations(i, :);
            best_col_permutation = col_permutations(j, :);
        end
    end
end

% Reorder the best row and column permutation
C_mod = C(best_row_permutation, best_col_permutation);
disp('Matrix with Maximized Diagonal:');
disp(C_mod);


% Define the minimum and maximum values for the color scale
min_val = min(C_mod(:));  % Set the minimum value
max_val = max(C_mod(:)); % Set the maximum value

% Create a figure
figure(3);
set(gcf, 'Position', [100, 100, 400, 400]);

% Create the heatmap
imagesc(C_mod, [min_val, max_val]);
colormap('sky');

% Add labels and colorbar
title('Confusion Matrix : K-means Clustering');
xlabel('Predicted Classes');
ylabel('True Classes');
set(gca, 'XTick', 1:size(C_mod, 2));
set(gca, 'YTick', 1:size(C_mod, 1));

% Manually set the color scale limits
clim([min_val, max_val]);

% Display the values in each cell
textStrings = num2str(C_mod(:),'%d');
textStrings = strtrim(cellstr(textStrings));
[x, y] = meshgrid(1:size(C_mod, 2), 1:size(C_mod, 1));
hStrings = text(x(:), y(:), textStrings(:), 'HorizontalAlignment', 'center');
colorbar;

% Adjust axis settings for better display
set(gca, 'XTickLabel', {'Class 1', 'Class 2', 'Class 3'});
set(gca, 'YTickLabel', {'Class 1', 'Class 2', 'Class 3'});























%% Part (b) : Hierarchical clustering

% Perform hierarchical clustering
Z = linkage(zNormalData, 'ward'); % You can choose different linkage methods

%{
% Visualize the hierarchical clustering using a dendrogram
figure;
dendrogram(Z);

title('Hierarchical Clustering Dendrogram');
xlabel('Data Points');
ylabel('Distance');
%}

% Use Hierarchical Clustering to form Clusters
T = cluster(Z,"maxclust",3);

% Display the clusters using different colors in a scatter plot
figure;
scatter3(X(:, 1), X(:, 2), X(:, 3), 50, T, 'filled', 'MarkerEdgeColor', 'k');
title('Classification Clusters from Hierarchical Clustering');
colormap('jet');

% Set the perspective view
view(-30, -30); % Azimuth: 30 degrees, Elevation: 45 degrees


% Create Confusion Matrix to check Classification of Non-Linear Dataset
trueClassifications = label;
predictedClassifications = T;

% Create a confusion matrix
C2 = confusionmat(trueClassifications, predictedClassifications);

% Display the confusion matrix
disp('Confusion Matrix:');
disp(C2);



% But this might lead to false inference since the numbering of the
% newly formed clusters can be changed to ensure that the number 
% assigned to the cluster is such that it maximizes diagonal elements.
% i.e. we can get better inference by row and column swapping

% Calculate the sum of diagonal elements
initial_diagonal_sum = sum(diag(C2));

% Generate all possible permutations of row indices and column indices
n = size(C2, 1); % Assuming a square matrix
row_permutations = perms(1:n);
col_permutations = perms(1:n);

max_diagonal_sum = initial_diagonal_sum;
best_row_permutation = 1:n;
best_col_permutation = 1:n;

% Iterate through all row and column permutations to find the best diagonal sum
for i = 1:size(row_permutations, 1)
    for j = 1:size(col_permutations, 1)
        B = C2(row_permutations(i, :), col_permutations(j, :));
        diagonal_sum = sum(diag(B));
        if diagonal_sum > max_diagonal_sum && B(1,1) > B(2,2) && B(2,2) > B(3,3) 
            max_diagonal_sum = diagonal_sum;
            best_row_permutation = row_permutations(i, :);
            best_col_permutation = col_permutations(j, :);
        end
    end
end

% Reorder the best row and column permutation
C_mod = C2(best_row_permutation, best_col_permutation);
disp('Matrix with Maximized Diagonal:');
disp(C_mod);


% Define the minimum and maximum values for the color scale
min_val = min(C_mod(:));  % Set the minimum value
max_val = max(C_mod(:)); % Set the maximum value

% Create a figure
figure(5);
set(gcf, 'Position', [100, 100, 400, 400]);

% Create the heatmap
imagesc(C_mod, [min_val, max_val]);
colormap('sky');

% Add labels and colorbar
title('Confusion Matrix : Hierarchical Clustering');
xlabel('Predicted Classes');
ylabel('True Classes');
set(gca, 'XTick', 1:size(C_mod, 2));
set(gca, 'YTick', 1:size(C_mod, 1));

% Manually set the color scale limits
clim([min_val, max_val]);

% Display the values in each cell
textStrings = num2str(C_mod(:),'%d');
textStrings = strtrim(cellstr(textStrings));
[x, y] = meshgrid(1:size(C_mod, 2), 1:size(C_mod, 1));
hStrings = text(x(:), y(:), textStrings(:), 'HorizontalAlignment', 'center');
colorbar;

% Adjust axis settings for better display
set(gca, 'XTickLabel', {'Class 1', 'Class 2', 'Class 3'});
set(gca, 'YTickLabel', {'Class 1', 'Class 2', 'Class 3'});

