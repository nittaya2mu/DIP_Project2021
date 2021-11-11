function main
    % Author: Nittaya Muangnak
    % ID: xxxxxxx
    % Date: 10 November 2021
    % DIP workshop mfile
    close all, clear all;
    %% Load Image
    oimg = imread("Strawberry.jpg");
    %img = mat2gray(oimg);
    img = rgb2gray(oimg);
    figure, 
    subplot(1,2,1), imshow(oimg, []);
    subplot(1,2,2), imshow(img, []);
    %% Image Enhancement using Smoothing Filter
    % Smoothing using Mean Filter vs. Morphological Smoothing
    mask = fspecial('average',3);
    im_average = filter2(mask,double(img),'same');

    B = strel('square',3);  % Structure element B
    im_open = imopen(img, B);   % Opening
    im_morph = imclose(im_open, B);     % Closing

    % Histogram Processing
    im_histeq = histeq(img);

    % Median Filtering
    im_medfilt = medfilt2(img,[5 5]);

    figure, 
    subplot(1,2,1), imshow(im_average, []);
    subplot(1,2,2), imshow(im_morph, []);
    %% Basic Feature Extraction: Mean, STD intensity
    % img, im_average, im_morph, im_histeq, im_medfilt
    img_mean = mean(mean(img))
    mea_mean = mean(mean(im_average))
    med_mean = mean(mean(im_medfilt))

    img_mean = std(std(double(img)))
    mea_mean = std(std(double(im_average)))
    med_mean = std(std(double(im_medfilt)))

    %% Edge Detection: Sobel, Laplacian
    % Sobel
    % 2. obtain Sobel masks
    mask1 = fspecial('Sobel');
    mask2 = mask1';     %Transpose

    % 3. Apply Sobel operators to input image
    gx1 = filter2(mask1, img, 'same');
    gy1 = filter2(mask2, img, 'same');

    gx2 = filter2(mask1, im_morph, 'same');
    gy2 = filter2(mask2, im_morph, 'same');

    % 4. Calculate magnitude
    gradientImg1 = sqrt(gx1.^2 + gy1.^2); % original
    gradientImg2 = sqrt(gx2.^2 + gy2.^2); % morph smoothing

    % 5. Display gradient image
    figure, 
    subplot(1,2,1), imshow(mat2gray(gradientImg1), []);
    subplot(1,2,2), imshow(mat2gray(gradientImg2), []);

    % Laplacian
    % 2. obtain Laplacian masks
    mask = fspecial('Laplacian');

    % 3. Apply Laplacian to input image
    gradientImg = filter2(mask, img, 'same');
    figure,
    subplot(1,2,1), imshow(img, []);
    subplot(1,2,2), imshow(mat2gray(gradientImg), []);

    %% Image Segmentation
    t_value = graythresh(im_morph)
    segmented_im = imbinarize(im_morph,"global");
    figure,
    subplot(1,2,1), imshow(im_morph, []);
    subplot(1,2,2), imshow(segmented_im, []);

    segmented_wb = imcomplement(segmented_im);

    % boundary extraction
    % Obtain the row and column indexes of a white region
    [r c] = find(segmented_wb == 1);
    
    % Start tracing of the boundary from the initial point.
    contour = bwtraceboundary(segmented_wb,[r(1) c(1)],'S');
    
    % Count the number of pixels on the boundary
    len = length(contour)
    
    % Plot object contour
    figure, imshow(segmented_wb,[]);
    hold on;
    plot(contour(:,2),contour(:,1),'.r','LineWidth',3);
    
    % Length of the Perimeter
    perim = 0; % Initialization of perimeter length
    for n=1:len-1
        dx = abs(contour(n,1)-contour(n+1,1)); %r
        dy = abs(contour(n,2)-contour(n+1,2)); %c
        
        if (dx+dy)==1
            perim = perim+1;
        else
            perim = perim+sqrt(2);
        end
    end
    perim

    % Alternative feature extraction - regionprops
    CC = bwconncomp(segmented_wb);
    S = regionprops(CC, 'Perimeter','Area','Centroid','BoundingBox','PixelList','Eccentricity');
    idx = find([S.Area] > 80000 & [S.Eccentricity] > 0.6); 
    
    BW2 = ismember(labelmatrix(CC),idx);   % segmented result
    figure, imshow(BW2,[]);

    % Start tracing of the boundary from the initial point.
    contour = bwtraceboundary(BW2,[r(1) c(1)],'S');
    
    % Count the number of pixels on the boundary
    len = length(contour)
    
    % Plot object contour
    hold on;
    plot(contour(:,2),contour(:,1),'.r','LineWidth',3);

    imwrite(BW2,'segmented_im1.bmp');

    perim = S(idx).Perimeter
    area = S(idx).Area
    pixelList = S(idx).PixelList;
    save pixelList.mat pixelList

    %Compactness = (Perimeter)^2 / (4*Pi*Area)
    compactness = (perim^2) / (4*pi*area)
    centroid = S(idx).Centroid
    hold on;
    plot(centroid(1),centroid(2),'.g','LineWidth',3);
    
    %% Evaluating Segment Results
    acc = eval(BW2, BW2)        % GT , Segmented
end