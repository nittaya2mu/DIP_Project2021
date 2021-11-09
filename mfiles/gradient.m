function gradient
    %% This function is for applying morphological gradient
    
    close all, clear all;
    img = imread('headCT.tif');
    
    % 1) Gradient by morphological operation
    B = strel('square',3);      % structure element B
    im_dilate = imdilate(img, B);   % Dilation
    im_erode = imerode(img, B);     % Erosion
    morph_grad = double(im_dilate) - double(im_erode);  % result1
    
    % 2) Gradient by Sobel operators
    mask1 = fspecial('Sobel');
    mask2 = mask1';     % the Sobel operators has two masks
    fx = filter2(mask1, double(img), 'same');
    fy = filter2(mask2, double(img), 'same');
    
    sobel_grad = sqrt(fx.^2 + fy.^2);   % result2
    
    % 3) Display results in comparison
    figure,
    subplot(1,2,1), imshow(morph_grad,[]), xlabel('Gradient by Morphological');
    subplot(1,2,2), imshow(sobel_grad,[]), xlabel('Gradient by Sobel');
    
end
