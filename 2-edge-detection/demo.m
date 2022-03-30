function demo()
addpath('./functions');
filename = 'noise.jpg';
img = imread(filename);
width=3;height=3;
res = medianfilter(img, width, height);
imshow(res);
mkdir('results/medianfilter');
imwrite(res,['./results/medianfilter/',filename]);

I=imread('锐化及边缘检测用途.jpg');
H=[1,1,1;1,-8,1;1,1,1];
imres=imfilter(I,H);
myres=myfilter(I,H);
cmp=(imres==myres);
length(cmp(cmp==0))
