function RESULT=myflip(IMAGE,DIM)
%MYFLIP Flip image.
%   RESULT = myflip(IMAGE, DIM) flips image IMAGE horizontally by
%   specifying 2 fod DIM or vertically by specifying 1 for DIM.
%
%   Example
%   -------
%   Flip vertically.
%
%       filename='color.jpg';
%       img=imread(filename);
%       dim=1;
%       res=myflip(img,dim);
%       imshow(res);
%       mode={'vertical','horizontal'};
%       storagepath=['results/flip/',mode{dim}];
%       mkdir(storagepath);
%       imwrite(res,[storagepath,'/',filename]);

[rows,cols,channels]=size(IMAGE);
RESULT=uint8(zeros(rows,cols,channels));
switch DIM
    case 1
        for i=1:rows
            RESULT(i,:,:)=IMAGE(rows-i+1,:,:);
        end
    case 2
        for j=1:cols
            RESULT(:,j,:)=IMAGE(:,cols-j+1,:);
        end
    otherwise
        warning("Only horizontal flip or vertical flip is supported.");
end