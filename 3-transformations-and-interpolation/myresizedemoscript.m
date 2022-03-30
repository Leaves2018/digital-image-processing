%% resize image
filename='color.jpg';
xscale=1.5; yscale=1.5;
INPUTIMAGE=myresizedemo(filename,xscale,yscale);
%% first zoom
SCALE=[xscale,yscale];
ZOOMAREA={[473,1035],[560,1182]};
RESULT1=myresizezoomdemo(INPUTIMAGE,ZOOMAREA,SCALE);
%% second zoom
ZOOMAREA1={[27,60],[50,106]};
RESULT2=myresizezoomdemo(RESULT1,ZOOMAREA1,SCALE);
%% third zoom
ZOOMAREA2={[9,4],[15,17]};
RESULT3=myresizezoomdemo(RESULT2,ZOOMAREA2,SCALE);
%% draw surf graph on RESULT3 (to compare bilinear and bicubic) (R channel)
oi3=RESULT3{1};
nn3=RESULT3{2};
bl3=RESULT3{3};
bc3=RESULT3{4};
[X,Y]=meshgrid(1:size(oi3,2),1:size(oi3,1));
figure;
% Original image
subplot(2,2,1);
surf(X,Y,oi3(:,:,1));
title('Original image');

[X,Y]=meshgrid(1:size(bl3,2),1:size(bl3,1));
% Nearest-neighbor interpolation
[X,Y]=meshgrid(1:size(bl3,2),1:size(bl3,1));
subplot(2,2,2);
surf(X,Y,nn3(:,:,1));
title('Nearest-neighbor interpolation');
% Bilinear interpolation
subplot(2,2,3);
surf(X,Y,bl3(:,:,1));
title('Bilinear interpolation');
% Bicubic interpolation
subplot(2,2,4);
surf(X,Y,bc3(:,:,1));
title('Bicubic interpolation');
%% draw surf graph on RESULT2 (to compare bilinear and bicubic) (R channel)
oi2=RESULT2{1};
nn2=RESULT2{2};
bl2=RESULT2{3};
bc2=RESULT2{4};
[X,Y]=meshgrid(1:size(oi2,2),1:size(oi2,1));
figure;
% Original image
subplot(2,2,1);
surf(X,Y,oi2(:,:,1));
title('Original image');

[X,Y]=meshgrid(1:size(bl2,2),1:size(bl2,1));
% Nearest-neighbor interpolation
[X,Y]=meshgrid(1:size(bl2,2),1:size(bl2,1));
subplot(2,2,2);
surf(X,Y,nn2(:,:,1));
title('Nearest-neighbor interpolation');
% Bilinear interpolation
subplot(2,2,3);
surf(X,Y,bl2(:,:,1));
title('Bilinear interpolation');
% Bicubic interpolation
subplot(2,2,4);
surf(X,Y,bc2(:,:,1));
title('Bicubic interpolation');
%% draw surf graph on RESULT1 (to compare bilinear and bicubic) (R channel)
oi1=RESULT1{1};
nn1=RESULT1{2};
bl1=RESULT1{3};
bc1=RESULT1{4};
[X,Y]=meshgrid(1:size(oi1,2),1:size(oi1,1));
figure;
% Original image
subplot(2,2,1);
surf(X,Y,oi1(:,:,1));
title('Original image');

[X,Y]=meshgrid(1:size(bl1,2),1:size(bl1,1));
% Nearest-neighbor interpolation
[X,Y]=meshgrid(1:size(bl1,2),1:size(bl1,1));
subplot(2,2,2);
surf(X,Y,nn1(:,:,1));
title('Nearest-neighbor interpolation');
% Bilinear interpolation
subplot(2,2,3);
surf(X,Y,bl1(:,:,1));
title('Bilinear interpolation');
% Bicubic interpolation
subplot(2,2,4);
surf(X,Y,bc1(:,:,1));
title('Bicubic interpolation');



