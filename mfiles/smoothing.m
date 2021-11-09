function smoothing
%% This function is for testing on morphological smoothing compare to Mean filtering

close all, clear all;
% read image
img = imread('cygnusloop_Xray_original.tif');

% 1) Morphological smoothing
B = strel('square',5);  % Structure element B
im_open = imopen(img, B);   % Opening
im_morph = imclose(im_open, B);     % Closing

% 2) Mean filtering
mask = fspecial('average',5);
im_average = round(filter2(mask,double(img),'same'));

% Display result comparison
figure,
subplot(1,2,1), imshow(im_morph,[]), xlabel('Smoothing by Morphological approach');
subplot(1,2,2), imshow(im_average,[]), xlabel('Smoothing by Mean filtering');

end
