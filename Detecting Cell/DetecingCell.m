clc;
clear all;
close all;
warning off;

% Read the input image
x = imread('cell.jpg');

% Display the input image
subplot(2, 2, 1);
imshow(x);
title('Input Image');

% Convert the image to grayscale
x_gray = rgb2gray(x);

% Apply Sobel filter
subplot(2, 2, 2);
sobel_edges = edge(x_gray, 'sobel');
imshow(sobel_edges);
title('Sobel Filter');

% Apply Prewitt filter
subplot(2, 2, 3);
prewitt_edges = edge(x_gray, 'prewitt');
imshow(prewitt_edges);
title('Prewitt Filter');

% Apply Canny filter
subplot(2, 2, 4);
canny_edges = edge(x_gray, 'canny');
imshow(canny_edges);
title('Canny Filter');

% Further processing with dilation
figure;
imshow(sobel_edges);
title('Edge Detected Image (Sobel)');

% Morphological processing using dilation
se_horizontal = strel('line', 3, 0);   % Horizontal line structuring element
se_vertical = strel('line', 3, 90);   % Vertical line structuring element
processed_image = imdilate(imdilate(sobel_edges, se_horizontal), se_vertical);

% Display the processed image
figure;
imshow(processed_image);
title('Processed Image');
