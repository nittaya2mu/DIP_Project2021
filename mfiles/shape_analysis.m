function shape_analysis
    close all, clear all, clc;
    % Load a binary image
%     img = imread('dark_blobs_on_light_background.tif');
    bwimg = imread('licoln_from_penny.tif');
    
    % Obtain the row and column indexes of a white region
    [r c] = find(bwimg == 1);
    
    % Start tracing of the boundary from the initial point.
    contour = bwtraceboundary(bwimg,[r(1) c(1)],'S');
    
    % Count the number of pixels on the boundary
    len = length(contour)
    
    % Plot object contour
    figure, imshow(bwimg,[]);
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
    S = regionprops(bwimg, 'Perimeter','Area','Centroid');
    S.Perimeter
    S.Area
    centroid = S.Centroid
    hold on;
    plot(centroid(1),centroid(2),'.g','LineWidth',3);
end