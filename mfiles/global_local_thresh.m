function global_local_thresh
    %=======Global Thresholding==========
    img = imread('tshape.png');
    img = mat2gray(img);
    [vsize hsize]=size(img);
    %num_of_pixels=vsize*hsize;
    
    T = graythresh(img);
    buf=im2bw(img,T);
    [co,x]=imhist(img);
    pk=max(co);
    
    figure(10)    
    subplot(1,2,1),plot(x,co),line([T T],[0 pk],'Color','r'),title('Global threshold histogram');
    %subplot(1,2,1),imhist(img),title('Original image histogram');
    subplot(1,2,2),imshow(buf),title('After global thresholding');
    
    %=======Local Thresholding===========
    w=11;
    n=w*3;
    
    mfilter=fspecial('average',n);
    mIM=conv2(double(img),double(mfilter),'same');
    mdIM=medfilt2(img,[n n]);
    [a1 b1]=imhist(mIM);
    [a2 b2]=imhist(mdIM);
    
    T1= mIM*0.809;
    T2=mdIM*0.809;
    [x1 y1]=imhist(T1);
    [x2 y2]=imhist(T2);
         
    figure(20)
    subplot(1,2,1),plot(b1,a1),title('Mean Filtered Histogram');
    subplot(1,2,2),plot(b2,a2),title('Median Filtered Histogram');
    
    figure(30)
    subplot(1,2,1),plot(y1,x1),title('After weighted Mean Filtered histogram');
    subplot(1,2,2),plot(y2,x2),title('After weighted Median Filtered histogram');
    
    img1=zeros(vsize,hsize);
    for i=1:vsize
         for j=1:hsize
            if (img(i,j)>T1(i,j))
                 img1(i,j)=1;
            end
         end
    end
    
    img2=zeros(vsize,hsize);
    for i=1:vsize
         for j=1:hsize
            if (img(i,j)>T2(i,j))
                 img2(i,j)=1;
            end
         end
    end
        
    figure(40)
    subplot(1,2,1),imshow(img1),title('Local thresholding with Mean filtered');
    subplot(1,2,2),imshow(img2),title('Local thresholding with Median filtered');
    
