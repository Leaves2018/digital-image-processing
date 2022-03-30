function RESULT=myrotate(IMAGE,ANGLE,METHOD)
%MYROTATE Rotate image.
%   RESULT = myrotate(IMAGE, ANGLE, METHOD) rotates image IMAGE by ANGLE 
%   degrees in a clockwise direction around its center point.  To rotate 
%   the image counterclockwise, specify a negative value for ANGLE.  
%   MYROTATE makes the output image RESULT large enough to contain the 
%   entire rotated image. MYROTATE sets the values of pixels in RESULT that 
%   are outside the rotated image to 0 (zero).
%
%   MYROTATE rotates image IMAGE, using the interpolation method specified
%   by METHOD. METHOD is a string that can have one of the following
%   values. 
%
%        'nearest'    Nearest neighbor interpolation
%
%        'bilinear'   Bilinear interpolation
%
%        'bicubic'    Bicubic interpolation.
%
%   Note that you must specify METHOD argument, because there is
%   no default value for METHOD.
%
%   Example
%   -------
%   Rotates the color.jpg by 45 degrees in a clockwise direction.
%
%       filename='color.jpg';
%       img=imread(filename);
%       res=myrotate(img,45,'bilinear');
%       imshow(res);
%       storagepath='results/rotate';
%       mkdir(storagepath);
%       imwrite(res,[storagepath,'/',filename]);
[M,N,channels]=size(IMAGE);
theta=mod(ANGLE,360)/180*pi;
% preprocess the input image according to the used method
% and get the required method
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

rotationmatrix=[cos(theta),-sin(theta);sin(theta),cos(theta)];

northwest=[1,1]*rotationmatrix;
northeast=[1,N]*rotationmatrix;
southwest=[M,1]*rotationmatrix;
southeast=[M,N]*rotationmatrix;

M1=ceil(max([abs(northwest(1)-southeast(1)) abs(northeast(1)-southwest(1))]));    
N1=ceil(max([abs(northwest(2)-southeast(2)) abs(northeast(2)-southwest(2))]));   

RESULT=uint8(zeros(M1,N1,channels));

DY=abs(min([northwest(1) northeast(1) southwest(1) southeast(1)])); 
DX=abs(min([northwest(2) northeast(2) southwest(2) southeast(2)])); 


for i=1-DY:M1-DY
    for j=1-DX:N1-DX
        originalpoint=[i,j]/rotationmatrix;
        y=originalpoint(1);
        x=originalpoint(2);
        if 1<=y && y<=M && 1<=x && x<=N
            for k=1:channels
                RESULT(i+DY,j+DX,k)=interpolation(IMAGE,x+n,y+n,k);
            end
        end
    end
end