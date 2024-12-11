close all;
clear;
clc;

% Read the original noisy image
noisyImage = imread('imgNoise.jpg'); % Replace with your noisy image filename

% Convert to grayscale if it's a color image
if size(noisyImage, 3) == 3
    noisyImage = rgb2gray(noisyImage);
end

% Apply a Gaussian filter for denoising
sigma =1.0; % Standard deviation (adjust as needed)
denoisedImage = imgaussfilt(noisyImage, sigma);

% Create a figure with adjusted layout
figure;
set(gcf, 'Position', [100, 100, 800, 400]); % Resize the figure window

% Display the noisy image
subplot(1, 2, 1);
imshow(noisyImage);
title('Noisy Image', 'FontSize', 14);

% Display the denoised image
subplot(1, 2, 2);
imshow(denoisedImage);
title('Denoised Image', 'FontSize', 14);

% Adjust the layout so that the titles and images don't overlap
set(gcf, 'Color', 'w'); % Set the background to white
