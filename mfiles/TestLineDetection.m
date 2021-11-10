function TestLineDetection

    close all, clear all;
    img=imread('./image_dataset/Anthracnose/2.jpg');
    img = rgb2gray(img);
    ic = img; %mat2gray(img);
    
    %Edge detection using Laplacian
    px = [-1 0 1;-1 0 1; -1 0 1];
    icx = filter2(px,ic);
    
    py = px';
    icy = filter2(py, ic);
%     figure, imshow(icy/255);
    
    edge_p = sqrt(icx.^2 + icy.^2);
%     figure, imshow(edge_p/255);
    
    edge_t = im2bw(edge_p/255, graythresh(edge_p/255));
    figure,
    subplot(2,2,1), imshow(icx/255), title('horizontal edges');
    subplot(2,2,2), imshow(icy/255), title('vertical edges');
    subplot(2,2,3), imshow(edge_p/255), title('final edges');
    subplot(2,2,4), imshow(edge_t, []), title('edges after thresholding');
    
    % Or you can apply command 'edge' by using 3 filter
    % Prewitt, Roberts, and Sobel
    edge_p = edge(ic, 'prewitt');
    edge_r = edge(ic, 'roberts');
    edge_s = edge(ic, 'sobel');
    figure,
    subplot(2,2,1), imshow(ic), title('Original image');
    subplot(2,2,2), imshow(edge_p, []), title('edge detection using Prewitt');
    subplot(2,2,3), imshow(edge_r, []), title('edge detection using Roberts');
    subplot(2,2,4), imshow(edge_s, []), title('edge detection using Sobel');
    
end