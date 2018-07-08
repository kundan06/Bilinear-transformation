% Bilinear transformation
clear all;
a=imread('cameraman.tif');
sf=2;
[rows,columns]=size(a);

a=double(a);
xdash = floor(rows*sf);
ydash = floor(columns*sf);

output=(zeros(xdash,ydash));

ycord=1:ydash; %cf
xcord=(1:xdash)'; %rf
% creating coordinateds for x and y
xx = repmat(xcord,size(ycord));
yy = repmat(ycord,size(xcord));

xx=xx/sf;
yy=yy/sf;

r=floor(xx);
c=floor(yy);

for i=1:size(r,1)
    for j=1:size(r,2)
        if r(i,j)<1
            r(i,j)=1;
        end
        if r(i,j)>rows-1
            r(i,j)=rows-1;
        end
    end
end    

for i=1:size(c,1)
    for j=1:size(c,2)
        if c(i,j)<1
            c(i,j)=1;
        end
        if c(i,j)>columns-1
            c(i,j)=columns-1;
        end
    end
end    


deltar=xx-r;
deltac=yy-c;

ind1=sub2ind([rows, columns], r, c);
ind2=sub2ind([rows, columns], r, c+1);
ind3=sub2ind([rows, columns], r+1, c);
ind4=sub2ind([rows, columns], r+1, c+1);

output = a(ind1).*(1 - deltar).*(1 - deltac)+ a(ind2).*(1 - deltar).*(deltac)+a(ind3).*(deltar).*(1 - deltac)+a(ind4).*(deltar).*(deltac);  
 
final_image=imresize(a,sf,'bilinear');
diff=double(final_image-output);
mse=(diff.*diff)/(rows*columns);
rmse=sqrt(sum(sum(mse,1),2));
disp('Error is');
disp(rmse);

figure;
imshow(uint8(a));
title('Original image');
figure;
imshow(uint8(output));
title('Interpolation using Bilinear Transformation');