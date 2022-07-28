%Morphological operations to detect Brain Tumor.

close all;
clear all;
clc;
folder = dir("*.jpg");   
nfiles = length(folder)

for k = 1 : nfiles
    img = imread(folder(k).name)                  %Reading Image
    if(size(img,3)>2)
        img = rgb2gray(img);
    end
   
    bw=im2bw(img,0.5);                            %converting to binary
    label=bwlabel(bw);
    stats=regionprops(label,'Solidity','Area');   %property of the label
    density=[stats.Solidity];                     %Storing solidity property in a variable
    area=[stats.Area];                            %Storing area property in a variable
    high_dense_area=density>0.5;                  %Comparing density of img with a threshold(tumor)
    max_area=max(area(high_dense_area));          %Calculating the max area of the tumor
    tumor_label=find(area==max_area);             %Finding the outermost path and storing it in a variable
    tumor=ismember(label,tumor_label);            %Checking whether the tumor label is in overall label
    se=strel('disk',5);                         %creating a circular structuring element whose radius is 5 pixels.
    tumor=imdilate(tumor,se);                     %Dialating only the tumor region
    figure;
    subplot(1,3,1);
    imshow(img,[]);                               %Original Image
    title('Input Image');
    if max_area>100
        subplot(1,3,2);
        imshow(tumor,[]);                             %Showing only the dialated tumor region
        title('Tumor Alone'); 

        [B,L]=bwboundaries(tumor,'noholes');          %Using bwboundaries for higlighting the tumor
        subplot(1,3,3);
        imshow(img,[]);
        hold on
        for i=1:length(B)
            plot(B{i}(:,2),B{i}(:,1), 'r' ,'linewidth',1.45);
        end
        title('Detected Tumor');
        hold off;
    else
        imshow(img);
        title("No Tumor!");
    end
end