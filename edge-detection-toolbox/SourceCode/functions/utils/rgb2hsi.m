function hsi=rgb2hsi(img)
% e.g.
%   img=imread('color.jpg');
%   hsi=rgb2hsi(img);
%   rgb=hsi2rgb(img);
img=im2double(img);
R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);
% cal h
num=0.5*((R-G)+(R-B));
den=sqrt(((R-G).^2)+(R-B).*(G-B));
theta=acos(num./(den+eps));
H=theta;
H(B>G)=2*pi-H(B>G);
H=H/(2*pi);
% cal s
num=min(min(R,G),B);
den=R+G+B;
den(den==0)=eps;
S=1-3*(num./den);
H(S==0)=0;
% cal i
I=1/3*(R+G+B);
% save h s i
hsi=im2uint8(cat(3,H,S,I));