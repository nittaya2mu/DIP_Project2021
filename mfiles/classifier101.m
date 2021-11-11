function labeled=classifier101(input_path)
    % read a test image
    img = imread(input_path);
    gimg = rgb2gray(img);

    % extract image features
    B = strel('square',3);  % Structure element B
    im_open = imopen(gimg, B);   % Opening
    im_morph = imclose(im_open, B);     % Closing

    % mean intensity
    avg_intensity = mean(mean(im_morph));

    % std of intensity
    std_intensity = std(std(double(im_morph)));

    % edge feature
    % 2. obtain Sobel masks
    mask1 = fspecial('Sobel');
    mask2 = mask1';     %Transpose

    % 3. Apply Sobel operators to input image
    gx = filter2(mask1, im_morph, 'same');
    gy = filter2(mask2, im_morph, 'same');

    % 4. Calculate magnitude
    gradientImg = sqrt(gx.^2 + gy.^2); % original
    
    % 5. Segment ROI
    segmented_im = imbinarize(gradientImg,"global");
    figure,
    subplot(1,2,1), imshow(im_morph, []);
    subplot(1,2,2), imshow(segmented_im, []);

    segmented_wb = imcomplement(segmented_im);

    % 6. Extract Area and Compactness
    CC = bwconncomp(segmented_wb);
    S = regionprops(CC, 'Perimeter','Area','Centroid','BoundingBox','PixelList','Eccentricity');
    idx = find([S.Area] > 6000 & [S.Eccentricity] > 0.8); 
 
    perim = S(idx).Perimeter
    area = S(idx).Area

    %Compactness = (Perimeter)^2 / (4*Pi*Area)
    compactness = (perim^2) / (4*pi*area)

    % 7. Classifying
    if (avg_intensity > 240 && compactness > 0.8)
        labeled = 'tomato'
    elseif (avg_intensity > 140 && area > 5000)
        labeled = 'cabbage'
    end
end