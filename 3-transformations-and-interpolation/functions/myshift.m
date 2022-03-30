function RESULT=myshift(IMAGE,X,Y)
%MYSHIFT Shift image.
%   RESULT = myshift(IMAGE, X, Y) shifts image IMAGE by X pixels
%   horizontally to the right and Y pixels vertically down. To shift image
%   IMAGE horizontally to the left or vertically up, specify a negative
%   value for X or Y.
%
%   Example
%   -------
%   Shift 100 pixels horizontally to the right and 100 pixels vertically
%   down.
%
%       filename='color.jpg';
%       img=imread(filename);
%       x=100;y=100;
%       res=myshift(img,x,y);
%       imshow(res);
%       storagepath='results/shift';
%       mkdir(storagepath);
%       imwrite(res,[storagepath,'/',filename]);
[rows,cols,channels]=size(IMAGE);
RESULT=uint8(zeros(rows,cols,channels));

if X>0
    xstart=1;
    xend=cols-X;
else
    xstart=-X+1;
    xend=cols;
end

if Y>0
    ystart=1;
    yend=rows-Y;
else
    ystart=-Y+1;
    yend=rows;
end

RESULT(ystart+Y:yend+Y,xstart+X:xend+X,:)=IMAGE(ystart:yend,xstart:xend,:);