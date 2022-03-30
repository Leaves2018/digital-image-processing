function rgb=hsi2rgb(img)
% e.g.
%   img=imread('color.jpg');
%   hsi=rgb2hsi(img);
%   rgb=hsi2rgb(img);

img=im2double(img);
H=img(:,:,1)*2*pi;
S=img(:,:,2);
I=img(:,:,3);

R=zeros(size(H));
G=zeros(size(S));
B=zeros(size(I));

index=find((0<=H)&(H<2*pi/3));
B(index)=I(index).*(1-S(index));
R(index)=I(index).*(1+S(index).*cos(H(index))./cos(pi/3-H(index)));
G(index)=3*I(index)-(R(index)+B(index));

index=find((2*pi/3<=H)&(H<4*pi/3));
H(index)=H(index)-2/3*pi;
R(index)=I(index).*(1-S(index));
G(index)=I(index).*(1+S(index).*cos(H(index))./cos(pi/3-H(index)));
B(index)=3*I(index)-(R(index)+G(index));

index=find((4*pi/3<=H)&(H<=2*pi));
H(index)=H(index)-4/3*pi;
G(index)=I(index).*(1-S(index));
B(index)=I(index).*(1+S(index).*cos(H(index))./cos(pi/3-H(index)));
R(index)=3*I(index)-(G(index)+B(index));

rgb=im2uint8(cat(3,R,G,B));


