function histogramequalization(img,filename)
% e.g.
%   color=imread('color.jpg');
%   histogramequalization(color,'color');
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
% (5)$n_i$
n_i=zeros(1,length(n_j));
for i=1:length(n_j)
    temp=abs(g(i)+1);
    n_i(temp)=n_i(temp)+n_j(i);
end
% (6)$P_g\left(g_i\right)=\frac{n_i}{n}$
p_g=n_i/(rows*cols);
% (7)$f_i\rightarrow g_i$
h=figure;
ind=0:255;
plot(ind, g, '-');
title(['Mapping relation: $f_i {\rightarrow} g_i$'],'Interpreter','LaTeX');
xlabel('$f_i$','Interpreter','LaTeX');
ylabel('$g_i$','Interpreter','LaTeX');
saveas(h,[filename, '_mapping_relation'],'png');
close();
% start histogram equalization
for i=1:rows
    for j=1:cols
        for k=1:3
            img(i,j,k)=g(abs(img(i,j,k)+1));
        end
    end
end
drawgrayscalehistogram(img,[filename,'_equalization']);
if iscolorful
    img=hsi2rgb(img);
end
imwrite(img,[filename,'_equalization.jpg']);
csvwrite([filename,'_equalization.csv'],[ind;n_j;c;g;n_i;p_g]);