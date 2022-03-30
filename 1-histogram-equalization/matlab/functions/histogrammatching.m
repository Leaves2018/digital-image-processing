function histogrammatching(img,filename,refimg,refimgfilename)
% e.g.
%   img=imread('color.jpg');
%   filename='color';
%   refimg=imread('grey_equalization.jpg');
%   refimgfilename='grey_equalization';
%   histogrammatching(img,filename,refimg,refimgfilename);
img=im2uint8(img);
rows=length(img(:,1));
cols=length(img(1,:))/length(img(1,1,:));
iscolorful=false;
if img(1,1,1)~=img(1,1,2)
    iscolorful=true;
    img=rgb2hsi(img);
end
% (1)$n_j$
n_j=drawgrayscalehistogram(img,filename);
% (2)$P_f\left(f_j\right)=\frac{n_j}{n}$
p_f=n_j/(rows*cols);
% (3)$C_\left(f\right)$
c=p_f;
for i=2:length(p_f)
    c(i)=c(i) + c(i-1);
end
% (4)$ \left \lfloor 255C\left(f\right)+0.5 \right \rfloor $
g=round(255*c);

% rules
z_i=drawgrayscalehistogram(refimg,refimgfilename);
[rowss,colss,ss]=size(refimg);
p_z=z_i/(rowss*colss);
% (5)$ C\left(z\right)=\sum_{i=0}^{k} P_z\left(Z_i\right) $
c_z=p_z;
for i=2:length(p_z)
    c_z(i)=c_z(i)+c_z(i-1);
end
% (6)$ \left \lfloor 255C\left(f\right)+0.5 \right \rfloor $
y_n=round(255*c_z); 
% (7)$f_i \rightarrow Z_i$
mapping=zeros(1,256);
for i=1:length(g)
    gs=abs(g(i));
    % find a grayscale in y_n which is closest to gs
    [temp,mapping(i)]=findclosest(gs, y_n);
end

h=figure;
ind=0:255;
plot(ind, mapping, '-');
title(['Mapping relation (refers to ', refimgfilename, '): $f_i {\rightarrow} g_i$'],'Interpreter','LaTeX');
xlabel('$f_i$','Interpreter','LaTeX');
ylabel('$g_i$','Interpreter','LaTeX');
saveas(h,[filename,'_refers_to_',refimgfilename,'_mapping_relation'],'png');
close();

% (8) P_z\left(Z_i\right)
z_i_=zeros(1,length(z_i));
for i=1:length(z_i)
    temp=abs(mapping(i)+1);
    z_i_(temp)=z_i_(temp)+z_i(i);
end
p_z_z_i=z_i_/(rows*cols);

% start histogram matching
for i=1:rows
    for j=1:cols
        for k=1:3
            img(i,j,k)=mapping(abs(img(i,j,k)+1));
        end
    end
end
if iscolorful
    img=hsi2rgb(img);
end
imwrite(img,[filename,'_refers_to_',refimgfilename,'_matching.jpg']);
drawgrayscalehistogram(img,[filename,'_refers_to_',refimgfilename,'_matching']);
csvwrite([filename,'_refers_to_',refimgfilename,'_matching.csv'],[ind;n_j;c;g;z_i;p_z;c_z;y_n;p_z_z_i]);