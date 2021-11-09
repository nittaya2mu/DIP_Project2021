close all, clear all;

img = imread('andromeda-galaxy.jpg');
img = rgb2gray(img);
blurredImage = conv2(single(img), ones(3)/9, 'same');
figure, 
subplot(1,2,1), imshow(img, []), title('Original Image');
subplot(1,2,2), imshow(blurredImage, []), title('After Image Averaging'); % or imshow(uint8(blurredImage), [0 255]);