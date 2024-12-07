clc; % Clears the command window
clear all; % Clears variables from workspace.
close all; % Closes all open figure windows
warning off; % Disables all warning messages.

% Read PCB images
imageWithoutDefects = imread("withoutDefects.jpg"); 
imageWithDefects = imread("WithDefects.jpg"); 

% Resize the defective image to match the reference image dimensions
[rows, cols, ~] = size(imageWithoutDefects);
imageWithDefects = imresize(imageWithDefects, [rows, cols]);

% Create a figure and adjust its size for better visualization
figure; % Create a new figure window.
% Get Current Figure > gcf
set(gcf, 'Position', [100, 100, 1200, 400]); % 100, 100 starting position on x and y axiz , 1200 width, 400 height
% Display the first image (reference image without defects)
subplot(1, 3, 1); % create a grid of subplots 1 row, 3 columns 1 position
imshow(imageWithoutDefects); % Display the reference image.
title('PCB Image without any defect', 'FontSize', 12);

% Display the second image (defective image)
subplot(1, 3, 2); % Select the second position in the subplot grid.
imshow(imageWithDefects); % Display the defective PCB image.
title('Image of PCB with defects', 'FontSize', 12); % Add a title to the second subplot.

% Display the difference between the two images (error image)
subplot(1, 3, 3); % Select the third position in the subplot grid.
imshow(imageWithoutDefects - imageWithDefects); % Subtract the defective image from the reference image and display the result.
title('Error Image', 'FontSize', 12); % Add a title to the third subplot.

% Adjust spacing between subplots for better visibility
subplotHandles = findobj(gcf, 'Type', 'axes'); % Find all subplot axes objects in the current figure.
for i = 1:length(subplotHandles) % Loop through each subplot handle.
    subplotHandles(i).Position = subplotHandles(i).Position .* [1, 1, 1.1, 1.1]; % Scale the position to slightly increase spacing.
end
