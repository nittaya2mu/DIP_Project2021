function median_filt
% Exercise 6: Median filter
% Description -- using cross-shaped median filter for image shading
% correction

close all; clear all;
% 1. Read image
img = imread('im0022.jpg');
gimg = rgb2gray(img);

% 2. Apply 3-by-3 cross-shaped Median filtering
output=ordfilt2(gimg,3,[0 1 0; 1 1 1; 0 1 0]);
% output = medfilt2(gimg,[3 3]);
shading = gimg + (gimg - output) * 0.5;

% 3. Show results
figure,
subplot(1,2,1), imshow(gimg,[]), title('Original Image');
subplot(1,2,2), imshow(shading), title('After shading correction');
