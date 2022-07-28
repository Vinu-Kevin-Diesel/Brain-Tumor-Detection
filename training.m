%Morphological operations to detect Brain Tumor.

close all;
clear all;
clc;
folder = dir("brain_tumor_dataset/yes/*.jpg"); 
nfiles = length(folder);
y = 0;
n = 0;

for k = 1 : nfiles
    img = imread(['brain_tumor_dataset/yes/' folder(k).name])                  %Reading Image
    if(size(img,3)>2)
        img = rgb2gray(img);
    end
    bw=im2bw(img,0.5);                            %converting to binary
    label=bwlabel(bw);
    stats=regionprops(label,'Solidity','Area');   %measuring area
    density=[stats.Solidity];                     %Storing solidity property in a variable
    area=[stats.Area];                            %Storing area property in a variable
    high_dense_area=density>0.5;                  %Comparing density of img with a threshold(tumor)
    max_area=max(area(high_dense_area));          %Calculating the max area of the tumor
    tumor_label=find(area==max_area);             %Finding the outermost path and storing it in a variable
    tumor=ismember(label,tumor_label);            %Checking whether the tumor label is in overall label
    se=strel('disk',5);                         %creating a circular structuring element whose radius is 5 pixels.
    tumor=imdilate(tumor,se);                     %Dialating only the tumor region
    if max_area>100
        y = y+1;
    else
        n = n+1;
    end
    
end

fprintf('# of Images which has Tumor %d.\n',y);
fprintf('# of Images which doesnt have Tumor %d.\n',n)

%Accuracy for YES
a1 = (y/(y+n))*100;
fprintf('Accuracy : %d',a1);

% %Accuracy for No
% a2 = (n/(y+n))*100;
% fprintf('Accuracy : %d',a2);