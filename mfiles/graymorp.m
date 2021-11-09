function graymorp
%% Description: This function is for showing morphological operation examples

% read image
img = imread('variety_size_of_square.tif');

% apply gray scale morphological operation
B=strel('square',13);    % Structure Element

test1=imdilate(img,B); 		%Dilation
test2=imerode(img,B);		%Erosion
test3=imopen(img,B);		%Opening
test4=imclose(img,B);		%Closing
% test5=imtophat(img,B);		%Top-hat
% test6=imbothat(img,B);		%Bottom-hat

% display outputs
figure,
subplot(2,2,1), imshow(test1,[]), xlabel('After Dilation');
subplot(2,2,2), imshow(test2,[]), xlabel('After Erosion');
subplot(2,2,3), imshow(test3,[]), xlabel('After Opening');
subplot(2,2,4), imshow(test4,[]), xlabel('After Closing');

end
