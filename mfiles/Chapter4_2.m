function Chapter4_2

% Assignment 4.2
% Description: Apply the Sobel and Laplacian filters to your original facial image separately,
% then comment on your results. 
% Further, attempt to enhance your image using the Laplacian filter. (See Chapter4_2.m)

close all, clear all;
%% Read Image --- you might work on another image
img = imread('child.jpg'); % Replace your own image here
gimg = rgb2gray(img);

%% Apply the Sobel and Laplacian filters

% 1. Sobel
mask1 = fspecial('Sobel');
mask2 = mask1';     %Transpose

gx = filter2(mask1, gimg, 'same');
gy = filter2(mask2, gimg, 'same');

gradientImg = sqrt(gx.^2 + gy.^2);

figure, 
subplot(1,2,1), imshow(gimg, []), xlabel('(a) Original image');
subplot(1,2,2), imshow(mat2gray(gradientImg), []), xlabel('(b) After applying Sobel filter');

% 2. Laplacian
mask = fspecial('Laplacian');

gradientImg = filter2(mask, gimg, 'same');

figure, 
subplot(1,2,1), imshow(gimg, []), xlabel('(a) Original image');
subplot(1,2,2), imshow(mat2gray(gradientImg), []), xlabel('(b) After applying Laplacian filter');

%% Further, attempt to enhance your image using the Laplacian filter 
weight = 0.1;
enhanceImg = double(gimg) - gradientImg * weight; %Enhance image with high pass filter

figure, 
subplot(1,2,1), imshow(gimg);
subplot(1,2,2), imshow(uint8(enhanceImg));
