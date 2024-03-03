% Cleaning
clc;
clear;
clearvars;
close all;
tic 

% Initialization

I = imread('setup01.png');      % Reading image.
imshow(I);                       % Image display.


% Blur
Bfs = fspecial('motion', 0.9 , 0.7);
Ib = imfilter(I,Bfs);
imshow(Ib)

% Disk
Df = fspecial('disk', 50);
Dim = imfilter(Ib,Df, 'replicate');
imshow(Dim)

% Noise
Noi = imnoise(Dim,'salt & pepper', 0.50);
imshow(Noi);


% Filter Noise for blue and red
F = medfilt3(Noi);
imshow(F);

% Filter noise for green
Rs = Noi(:,:,1);
Gs = Noi(:,:,2);
Bs = Noi(:,:,3);
F_EG = F - Rs - Bs + Gs;
F_EG2 = medfilt3(F_EG);
imshow (F_EG2);




% Filter Blur

% Separation of the color channels
Fr = F(:,:,1);   % Red
Fg = F_EG2(:,:,2);   % Green
Fb = F(:,:,3);   % Blue

PSF = fspecial('gaussian',5,5);
Rlast = imfilter(Fr, PSF);
luc1r = deconvlucy(Rlast,PSF,5);
imshow(luc1r)
Glast = imfilter(Fg, PSF);
luc1g = deconvlucy(Glast,PSF,5);
imshow(luc1g)
Blast = imfilter(Fb, PSF);
luc1b = deconvlucy(Blast,PSF,5);
imshow(luc1b)



% Separation of the color channels
R = luc1r;   % Red
G = luc1g;   % Green
B = luc1b;   % Blue

% Definition of the area spected
spect_area = 2000;

%%RED%%

%imshow(R);
bw1 = im2bw(R,0.8); % Image binarization for red using 0.8 as threshold 
imshow(bw1);         % Show image binarized.

% Processing:

% Calculation of the area and the centroid.
moments1 = regionprops(bw1, 'Area', 'Centroid');

% Since the areas calculated are more than the needed, a
% threshold is needed to separate the true square areas from
% the ones that aren't, this way, stay_rectangleR identifies the
% true squares (higher area than 2000).
stay_rectangleR = [moments1.Area] >= spect_area;
% RED counts the amount of cubes that satisfy this >=2000 area 
% requisite.
RED = sum(stay_rectangleR)
% Creates a vector of lenght RED x 1, that will be used for 
% assigning the centroids in the for statement below:
matrix_red = cell(RED,1);
% Initialites the counter for the for used below:
counter = 1;

% From 1 to all the objects detected in the red regionprops. 
for i = 1:numel(moments1)
    % If the Area of i (the current evaluated object)
    % is bigger than the spected Area.
    if moments1(i).Area > spect_area 
        % The centroid of that object is asigned to centroid.
        centroid = moments1(i).Centroid;
        % A circle is displayed in the centroid of the object with
        % radius 5 and EdgeColor red.
        viscircles(centroid, 5, 'EdgeColor', 'r');
        % The index of matrix red is updated with the centroid of the
        % object detected.
        matrix_red{counter} = round(moments1(i).Centroid);
        % 1+ to counter so we go to the next index of matrix red.
        counter = counter + 1;   
    end
end

%%GREEN%%

%imshow(G)
bw2 = im2bw(G,0.75);    % Image binarization for red using 0.75 as threshold 
imshow(bw2);             % Show image binarized.

% Processing:

% Calculation of the area and the centroid.
moments2 = regionprops(bw2, 'Area','Centroid');

% Getting true squares.
stay_rectangleG = [moments2.Area] >= spect_area;
% Counts amount of true squares.
GREEN = sum(stay_rectangleG)
% Initiates the matrix for green cubes.
matrix_green = cell(GREEN,1);
% Counter for procedure.
counter = 1;

% From 1 to all the objects detected in the green regionprops. 
for i = 1:numel(moments2)
    % If the Area of i (the current evaluated object)
    % is bigger than the spected Area.
    if moments2(i).Area > spect_area
        % The centroid of that object is asigned to centroid.
        centroid = moments2(i).Centroid;
        % A circle is displayed in the centroid of the object with
        % radius 5 and EdgeColor green.
        viscircles(centroid, 5, 'EdgeColor', 'g'); 
        % The index of matrix green is updated with the centroid of the
        % object detected.
        matrix_green{counter} = round(moments2(i).Centroid);
        % 1+ to counter so we go to the next index of matrix green.
        counter = counter + 1;   
    end
end

%%BLUE%%

%imshow(B);
bw3 = im2bw(B,0.8); % Image binarization for red using 0.8 as threshold 
imshow(bw3);         % Show image binarized.

% Processing:

% Calculation of the area and the centroid.
moments3 = regionprops(bw3, 'Area','Centroid');

% Getting true squares.
stay_rectangleB = [moments3.Area] >= spect_area;
% Counts amount of true squares.
BLUE = sum(stay_rectangleB)
% Initiates the matrix for blue cubes.
matrix_blue = cell(BLUE,1);
% Counter for procedure.
counter = 1;

% From 1 to all the objects detected in the blue regionprops. 
for i = 1:numel(moments3)
    % If the Area of i (the current evaluated object)
    % is bigger than the spected Area.
    if moments3(i).Area > spect_area
        % The centroid of that object is asigned to centroid.
        centroid = moments3(i).Centroid;
        % A circle is displayed in the centroid of the object with
        % radius 5 and EdgeColor blue.
        viscircles(centroid, 5, 'EdgeColor', 'b'); 
        % The index of matrix blue is updated with the centroid of the
        % object detected.
        matrix_blue{counter} = round(moments3(i).Centroid);
        % 1+ to counter so we go to the next index of matrix blue.
        counter = counter + 1;        
    end
end

% MASK

% Image for mask.
I_mask = imread('setup01.png');
% imshow(I_mask);

% Red masK
R_mask = I_mask(:,:,1); 
% Green mask
G_mask = I_mask(:,:,2); 
% Blue mask
B_mask = I_mask(:,:,3);

% Red binarized mask
bw1_mask = im2bw(R_mask,0.8);
% Green binarized mask
bw2_mask = im2bw(G_mask,0.75);
% Blue binarized mask
bw3_mask = im2bw(B_mask,0.8);

% Binarized: Adding red and blue mask.
comb = imadd(bw1_mask,bw3_mask);
% Binarized: Adding previous (red and blue mask) with green mask.
combination = imadd(im2bw(comb),bw2_mask);
% Reecombinating in order to have the full mask.
combination = im2bw(combination);
% Displaying the full mask.
imshow(combination)

% POSITIONS

% Obtain all the properties of the mask.
moments4 = regionprops(combination, 'all');

% Getting true squares.
stay_rectanglecomb = [moments4.Area] >= spect_area;

% Counts amount of true squares.
Total = sum(stay_rectanglecomb)

% Initiates the matrix for all the cubes, using the
% previous total calculated cubes for rows and 3 columns
% that will be used for pixelList, BoundingBox and Centroid.
fullmatrix= cell(Total,3);

% Counter for full matrix.
counter2 = 1;

% From 1 to all the objects detected in the combination regionprops.     
for i = 1:numel(moments4)
    % If the Area of i (the current evaluated object)
    % is bigger than the spected Area.
    if moments4(i).Area > spect_area
        % In the actual counter row and the first column, the pixels
        % of the object of the counter is assignated.
        fullmatrix{counter2, 1} = moments4(i).PixelList;
        % In the actual counter row and the second column, the limitating
        % box of the object of the counter is assignated.
        fullmatrix{counter2, 2} = moments4(i).BoundingBox;
        % In the actual counter row and the third column, the limitating
        % Centroid of the object of the counter is assignated.
        fullmatrix{counter2, 3} = moments4(i).Centroid;
        
        % Numbering:
        
        % Each bounding box is obtained.
        boundingBox = moments4(i).BoundingBox;
        
        % Obtain the middle point of the horizontal line of the cube.
        x = boundingBox(1) + boundingBox(3) / 2; 
        % Obtain the middle point of the vertical line of the cube.
        y = boundingBox(2) + boundingBox(4) / 2; 
        % Convert counter 2 to string and assign it to texto.
        texto = num2str(counter2); 
        % Write in the middle horizontal and vertical point of each
        % bounding box the texto string with 'color = blue', 
        % 'FontSize = 12', 'HorizontalAligment = center' and 
        % 'VerticalAlignment = middle).
        text(x, y, texto, 'Color', 'blue', 'FontSize', 12, ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
        
        % Update counter.
        counter2 = counter2 + 1;
    end
end

% CHART

Numerate = cell(10,2);

Numerate{1,2} = "v7";
Numerate{2,2} = "v4";
Numerate{3,2} = "v8";
Numerate{4,2} = "v2";
Numerate{5,2} = "v5";
Numerate{6,2} = "v1";
Numerate{7,2} = "v9";
Numerate{8,2} = "v3";
Numerate{9,2} = "v6";
Numerate{10,2} = "v10";

%Coordinates numerate in the wanted order 

% from i equal to from 1 to all the objects in matrix red.
for i = 1:numel(matrix_red)
    % and for 1 to 10 (knowing those are the labels specified "v")
    for j = 1:10
           % if the centroid of the red cube is equal to any pair of
           % pixels found in the region detected from the mask,
           % then assign the RED label.
        if ismember(matrix_red{i,1},fullmatrix{j,1}, 'rows') == [1,1]
            Numerate{j,1} = "Red_07";
        end
    end
end

% from i equal to from 1 to all the objects in matrix green.
for i = 1:numel(matrix_green)
    % and for 1 to 10 (knowing those are the labels specified "v")
    for j = 1:10
        % if the centroid of the green cube is equal to any pair of
           % pixels found in the region detected from the mask,
           % then assign the GREEN label.
        if ismember(matrix_green{i},fullmatrix{j,1}, 'rows') == [1,1]
            Numerate{j,1} = "Green_06";
        end
    end
end

% from i equal to from 1 to all the objects in matrix blue.
for i = 1:numel(matrix_blue)
    % and for 1 to 10 (knowing those are the labels specified "v")
    for j = 1:10
        % if the centroid of the blue cube is equal to any pair of
           % pixels found in the region detected from the mask,
           % then assign the blue label.
        if ismember(matrix_blue{i,1},fullmatrix{j,1}, 'rows') == [1,1]
            Numerate{j,1} = "Blue_05";
        end
    end
end


% ORDERED CHART

Numerate_Or = cell(10,3);

Numerate_OR{1,1} = Numerate{6,2};
Numerate_OR{1,2} = Numerate{6,1};
Numerate_OR{1,3} = "6";
Numerate_OR{2,1} = Numerate{4,2};
Numerate_OR{2,2} = Numerate{4,1};
Numerate_OR{2,3} = "4";
Numerate_OR{3,1} = Numerate{8,2};
Numerate_OR{3,2} = Numerate{8,1};
Numerate_OR{3,3} = "8";
Numerate_OR{4,1} = Numerate{2,2};
Numerate_OR{4,2} = Numerate{2,1};
Numerate_OR{4,3} = "2";
Numerate_OR{5,1} = Numerate{5,2};
Numerate_OR{5,2} = Numerate{5,1};
Numerate_OR{5,3} = "5";
Numerate_OR{6,1} = Numerate{9,2};
Numerate_OR{6,2} = Numerate{9,1};
Numerate_OR{6,3} = "9";
Numerate_OR{7,1} = Numerate{1,2};
Numerate_OR{7,2} = Numerate{1,1};
Numerate_OR{7,3} = "1";
Numerate_OR{8,1} = Numerate{3,2};
Numerate_OR{8,2} = Numerate{3,1};
Numerate_OR{8,3} = "3";
Numerate_OR{9,1} = Numerate{7,2};
Numerate_OR{9,2} = Numerate{7,1};
Numerate_OR{9,3} = "7";
Numerate_OR{10,1} = Numerate{10,2};
Numerate_OR{10,2} = Numerate{10,1};
Numerate_OR{10,3} = "10";

Numerate_OR

toc
