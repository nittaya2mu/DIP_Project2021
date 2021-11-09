% threshdemo.m
% Demonstration of global and local threshold operations of an image
% (C) 2003 by Yu Hen Hu
% created: 12/7/2003
% call kmeansf.m, kmeantest.m

clear all
[tmp,idx]=imread('lena.bmp');
a=ind2gray(tmp,idx); % gray scale image of lena, value between 0 and 1
clear tmp idx
figure(1),clf,colormap('gray'),imshow(a),title('original Lena image')
[m,n]=size(a); % size of image a
b=reshape(a,m*n,1); % into a column vector
figure(2),hist(b,50),title('histogram of image')
% first do global thresholding
mu=rand(2,1); % value betwen 0 and 1, two clusters only
[W,iter,Sw,Sb,Cova]=kmeansf(b,mu);% W is the mean, 
% Cova is the covariance matrices
% member: membership of each X:  K by 1 vector of elements 1 to c
[d,member]=kmeantest(b,sort(W));
c=reshape(member-1,m,n);
clear d member b
figure(3),clf,colormap('gray'),imshow(c)
title('global threshold')

% next do local threshold, partition the image into 64 x 64 blocks
% and do threshold within each block
c=zeros(512,512); trials=0;
for i=1:8,
   for j=1:8,
      trials=trials+1;
      disp([int2str(trials) ' of 64 iterations ...']);
      tmp=a(64*(i-1)+1:64*i,64*(j-1)+1:64*j);
      tmpi=reshape(tmp,64*64,1);
      mu=sort(rand(2,1)); % value betwen 0 and 1, two clusters only
      [W,iter,Sw,Sb,Cova]=kmeansf(tmpi,mu);% W is the mean, 
      % Cova is the covariance matrices
      % member: membership of each X:  K by 1 vector of elements 1 to c
      [d,member]=kmeantest(tmpi,sort(W));
      c(64*(i-1)+1:64*i,64*(j-1)+1:64*j)=reshape(member,64,64);
   end
end
figure(4),clf,colormap('gray'),imshow(c-1),
title('local threshold, 64x64 block');
