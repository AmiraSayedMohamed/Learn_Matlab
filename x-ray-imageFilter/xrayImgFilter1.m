close all
clear
clc

% Read the original image
originalImage = imread('xrayImg.jpg');

% Convert to grayscale
grayImage = rgb2gray(originalImage);

% Apply FFT to the grayscale image
fftImage = fft2(double(grayImage)); % Compute 2D FFT
fftShifted = fftshift(fftImage); % Shift zero-frequency component to center
magnitudeSpectrum = log(1 + abs(fftShifted)); % Compute magnitude spectrum (log scale for better visualization)

% Create a figure
figure;
set(gcf, 'Position', [100, 100, 1400, 800]); % Resize the figure window

% Display the original image
subplot(2, 3, 1);
imshow(originalImage);
title('Original Image', 'FontSize', 12);

% Display the grayscale image
subplot(2, 3, 2);
imshow(grayImage);
title('Grayscale Image', 'FontSize', 12);

% Display the histogram of the original image
subplot(2, 3, 3);
imhist(originalImage);
title('Histogram of Original Image', 'FontSize', 12);

% Display the histogram of the grayscale image
subplot(2, 3, 4);
imhist(grayImage);
title('Histogram of Grayscale Image', 'FontSize', 12);

% Display the magnitude spectrum of the FFT
subplot(2, 3, 5);
imshow(magnitudeSpectrum, []);
title('FFT Magnitude Spectrum', 'FontSize', 12);

% Display the frequency domain in 3D
subplot(2, 3, 6);
surf(abs(fftShifted), 'EdgeColor', 'none'); % Use abs to display real-valued data
title('Frequency Domain (3D)', 'FontSize', 12);
view(45, 30); % Adjust the viewing angle
colormap jet; % Set the colormap
colorbar;

% Ensure proper spacing and avoid overlapping
set(gcf, 'Color', 'w'); % Set background to white for better visuals
