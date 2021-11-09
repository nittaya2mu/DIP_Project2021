function chap4_5
% Apply Laplacian (2nd derivatives)

% 1. obtain input image
%     img = imread('contact_lens_original.tif');
    img = imread('moon.bmp');

% 2. obtain Laplacian masks
mask = fspecial('Laplacian');

% 3. Apply Laplacian to input image
gradientImg = filter2(mask, img, 'same');

enhanceImg = double(img) - gradientImg * 0.1; %Enhance image high pass filter

% 4. Display gradient image
figure, 
subplot(1,2,1), imshow(img);
% subplot(1,2,2), imshow(mat2gray(gradientImg));
subplot(1,2,2), imshow(uint8(enhanceImg));