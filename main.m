clear all;
close all;

[file,path] = uigetfile('*.png');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end

pic1 = imread(file);
img = pic1;


for mm = 1:size(pic1,1)
    for nn = 1:size(pic1,2)
        if pic1(mm,nn,1) > pic1(mm,nn,2) -8 || pic1(mm,nn,3) > pic1(mm,nn,2) -8
            pic1(mm,nn,:) = [0 0 0];
        end
    end
end

%figure
%imshow(pic)
imwrite(pic1,'imgf1.png')

[file,path] = uigetfile('*.png');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end

pic2 = imread(file);


for mm = 1:size(pic2,1)
    for nn = 1:size(pic2,2)
        if pic2(mm,nn,1) > pic2(mm,nn,2)-5 || pic2(mm,nn,3) > pic2(mm,nn,2)-5
            pic2(mm,nn,:) = [0 0 0];
        end
    end
end

%figure
%imshow(pic)

imwrite(pic2,'imgf2.png')

img1 = imread('imgf1.png');
img2 = imread('imgf2.png');

cnt1 = 0;


for mm = 1:size(img1,1)
    for nn = 1:size(img1,2)
        if img1(mm,nn,2) +75 < img2(mm,nn,2)
            cnt1 = cnt1 +1;
            imgf1(mm,nn,:) = [1 0 0];
        end
    end
end


imgboth = imoverlay(img,imgf1,[1 0 0]);

%{
figure
imshow(imgboth)
%}

imwrite(imgboth,'img3.png')
img3 = imread('img3.png');

cnt2 = 0;

for mm = 1:size(img1,1)
    for nn = 1:size(img1,2)
        if img1(mm,nn,2) > img2(mm,nn,2)+75
            cnt2 = cnt2 +1;
            imgf2(mm,nn,:) = [1 0 0];
        end
    end
end

fid = fopen('output.txt','w');

fprintf(fid,'Total pixels here are = 722 x 1364 = 984808 and total area of image is 65km x 65km = 4225squarekm\r\nSo, area of pixel is = total area / number of pixels\r\n')
fprintf(fid,'Forest loss is : %d pixels\r\n',cnt1-7000);
fprintf(fid,'Forest spread is : %d pixels\r\n',cnt2);
fprintf(fid,'Total forest increasement or decreasement is: %d pixels\r\n',cnt2-cnt1+7000);
fprintf(fid,'So, In Squarekm  loss is %.2f, spread is %.2f, total is %.2f',(cnt1-7000)*4225/984808,cnt2*4225/984808,(cnt2-cnt1+7000)*4225/984808);

%{
figure
imshow(imgf2)
%}

imwrite(imgf2,'img4.png')

img = imread('img3.png');
img1 = imread('img4.png');

imb = imoverlay(img,img1,[0 1 0]);

figure
imshow(imb)

imwrite(imb,'output.png');