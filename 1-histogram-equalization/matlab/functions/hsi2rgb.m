function rgb=hsi2rgb(img)
% e.g.
%   img=imread('color.jpg');
%   hsi=rgb2hsi(img);
%   rgb=hsi2rgb(img);
rows=length(img(:,1));
cols=length(img(1,:)) / length(img(1,1,:));
img=im2double(img);
rgb=img;
for k=1:rows
    for j=1:cols
        % get h s i
        h=img(k,j,1);
        s=img(k,j,2);
        i=img(k,j,3);
        % set r g b
        r=0;
        g=0;
        b=0;
        if 0 <=h<=2/3*pi
            b=i*(1-s);
            r=i*(1+s*cos(h)/cos(pi/3-h));
            g=3*i-(b+r);
        elseif 2/3*pi<h<=4/3*pi
            r=i*(1-s);
            g=i*(1+s*cos(h-2/3*pi)/cos(pi-h));
            b=3*i-(r+g);
        elseif 4/3*pi<h<=5/3*pi
            g=i*(1-s);
            b=i*(1+s*cos(h-4/3*pi)/cos(5/3*pi-h));
            r=3*i-(g+b);
        end
        rgb(k,j,1)=r;
        rgb(k,j,2)=g;
        rgb(k,j,3)=b;
    end
end
rgb=im2uint8(rgb);
