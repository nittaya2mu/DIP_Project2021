function mean_filt2
%% Linear Filtering
% Mean filtering (Averaging filter)

%Define an input image f
img = [6 6 6 6 6 6 6;...
       5 5 5 5 5 5 5;...
       4 4 4 4 4 4 4;...
       3 3 3 10 3 3 3;...
       2 2 2 2 2 2 2;...
       1 1 1 1 1 1 1;...
       0 0 0 0 0 0 0];
   
%Define a mask for filtering in two ways
mask = fspecial('average',3);   % 1st way
mask = [1 1 1; 1 1 1; 1 1 1]/9; % 2nd way

% Filtering in two ways
output1 = filter2(mask,img,'same');  %correlation
output2 = conv2(img,mask,'same');    %convolution -- mask flipped

% Display 2 filtering results
figure,
subplot(2,2,1), imshow(img,[]), title('Input image');
subplot(2,2,3), imshow(output1,[]), title('After Filtering -- correlation');
subplot(2,2,4), imshow(output2,[]), title('After Filtering -- convolution');
