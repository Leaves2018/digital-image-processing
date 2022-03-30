function hsi=rgb2hsi(img)
% e.g.
%   img=imread('color.jpg');
%   hsi=rgb2hsi(img);
%   rgb=hsi2rgb(img);
rows=length(img(:,1));
cols=length(img(1,:)) / length(img(1,1,:));
img=im2double(img);
hsi=img;
for i=1:rows
    for j=1:cols
        % get r g b
        r=img(i,j,1);
        g=img(i,j,2);
        b=img(i,j,3);
        % cal h
        num=0.5*((r-g)+(r-b));
        den=sqrt(power(r-g,2)+(r-b)*(g-b));
        theta=acos(num/(den+eps));
        if b<=g
            hsi(i,j,1)=theta;
        else
            hsi(i,j,1)=2*pi-theta;
        end
        % cal s
        if r+g+b==0
            hsi(i,j,2)=1-3*min(min(r,g),b)/(r+g+b+eps);
        else
            hsi(i,j,2)=1-3*min(min(r,g),b)/(r+g+b);
        end
        if hsi(i,j,2)==0
            hsi(i,j,1)=0;
        end
        % cal i
        hsi(i,j,3)=1/3*(r+g+b);
    end
end
hsi=im2uint8(hsi);