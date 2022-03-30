function RESULT=myresize(IMAGE,XSCALE,YSCALE,METHOD)
%MYRESIZE Resize image.
%   RESULT = myresize(IMAGE, XSCALE, YSCALE, METHOD) returns an image
%   that is XSCALE times the column size and YSCALE times the row size of
%   IMAGE, which is a grayscale, RGB, or binary image. If A has more than
%   two dimensions, only the first two dimensions are resized.
%
%   To control the interpolation method used by MYRESIZE, use the METHOD
%   argument. METHOD can be a string naming a general interpolation method:
%  
%       'nearest'    - nearest-neighbor interpolation
% 
%       'bilinear'   - bilinear interpolation
% 
%       'bicubic'    - cubic interpolation; the default method
%
%
%   Note that you must specify METHOD argument, because there is
%   no default value for METHOD.
%
%   Examples
%   --------
%   Shrink by factor of two using bilinear interpolation
%
%       filename='color.jpg';
%       img=imread(filename);
%       xscale=0.5; yscale=0.5;
%       res=myresize(img,xscale,yscale,'bilinear');
%       imshow(res);
%       storagepath='results/resize';
%       mkdir(storagepath);
%       imwrite(res,[storagepath,'/',filename]);

% get the size of input image and create the result image
[rows,cols,channels]=size(IMAGE);
RESULT=uint8(zeros(round(rows*YSCALE),round(cols*XSCALE),channels));
% preprocess the input image according to the used method
switch METHOD
    case 'nearest'
        n=1;
        interpolation=@nearestinterpolation;
    case 'bilinear'
        n=1;
        interpolation=@bilinearinterpolation;
    otherwise 
        n=2;
        interpolation=@bicubicinterpolation;
end
IMAGE=preprocessimage(IMAGE,n);
% resize the image
for k=1:channels
    for i=1:size(RESULT,1)
        for j=1:size(RESULT,2)
            x=j/XSCALE;
            y=i/YSCALE;
            RESULT(i,j,k)=interpolation(IMAGE,x+n,y+n,k);
        end
    end
end