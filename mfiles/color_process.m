function color_process

    close all, clear all, clc;
    im = imread('strawberries_coffee.tif');
    [x y z] = size(im);
    % RGB image
    imR = im(:,:,1);    % red channel ***
    imG = im(:,:,2);    % green channel ***
    imB = im(:,:,3);    % blue channel ***
    % HSI image
    imHSI = rgb2hsv(im);
    imH = imHSI(:,:,1);    % H channel
    imS = imHSI(:,:,2);    % S channel
    imI = imHSI(:,:,3);    % I channel ***
    
    % Smoothing - averaging filter 5x5
    f = [1,1,1,1,1; 1,1,1,1,1; 1,1,1,1,1; 1,1,1,1,1; 1,1,1,1,1]/25;
    imR_smth = conv2(imR, f, 'same');
    imG_smth = conv2(imG, f, 'same');
    imB_smth = conv2(imB, f, 'same');
    smthRGB = im;
    smthRGB(:,:,1) = imR_smth;
    smthRGB(:,:,2) = imG_smth;
    smthRGB(:,:,3) = imB_smth;
    figure, subplot(1,2,1), imshow(im,[]), title('Original Image');
    subplot(1,2,2), imshow(smthRGB,[]), title('Smoothen RGB Image');
    
    
    imI_smth = conv2(imI, f, 'same');
    smthHSI = imHSI;
    smthHSI(:,:,3) = imI_smth;
    smthHSI2RGB = hsv2rgb(smthHSI);
    figure, subplot(1,2,1), imshow(im,[]), title('Original Image');
    subplot(1,2,2), imshow(smthHSI2RGB,[]), title('Smoothen HSI Image');
    
    figure, subplot(1,2,1), imshow(smthRGB,[]), title('Smoothen RGB Image');
    subplot(1,2,2), imshow(smthHSI2RGB,[]), title('Smoothen HSI Image');
    
    % Image Enhancement
    
end