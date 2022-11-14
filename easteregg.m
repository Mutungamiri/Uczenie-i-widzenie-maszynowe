clear all
close all
clc
lam=1;
LAMBDA=[((2^4)*lam) ((2^2)*lam) ((2^0)*lam) ((2^(-2))*lam) ((2^(-4))*lam) ((2^(-8))*lam)];
imageIn = imread('GrassHopper.png');
%imageIn = imread('rower.png');

A = 0.1;

JT = @(x)(1 - abs(x)) .* (abs(x) < 1); %Jadro trojkatne

% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% h = figure;
% h.Position(3) = 2*h.Position(3);
% ax1 = subplot(1,2,1);
% ax2 = subplot(1,2,2);
% 
% net=resnet50('Weights','none');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(1)
% hold on;
%  h    = [];
%  h(1) = subplot(2,3,1);
%  h(2) = subplot(2,3,2);
%  h(3) = subplot(2,3,3);
%  h(4) = subplot(2,3,4);
%  h(5) = subplot(2,3,5);
%  h(6) = subplot(2,3,6);

 for i=1
    %imageIn = imread('rower.png');
    %subplot(2,4,2);
    %imshow(im1G);
    %title('po Gaussie');
    %title('(2^4)*lambda')
    imageIn = imread('GrassHopper.png');
    imageIn = poissrnd(double(imageIn/(LAMBDA(i))))/(256)*LAMBDA(i);
    figure(1);
    hold on;
    subplot(2,3,i);
    imshow((imageIn));
    title('Zaszumiony obraz');
    im1G = imgaussfilt(imageIn, 1);
    imageFuzzy=imageIn;
    im1t = imresize(imageFuzzy, 1, 'triangle');%imresize(imageFuzzy,1, {JT, 1},'Antialiasing',false);
    im1tg = imresize(im1G, 1, 'triangle');
    subplot(2,3,2);
    imshow(im1tg);
    title('Funkcja trójkątna');
    C1r = edge(rgb2gray(imageIn), 'Canny');
    S1r = edge(rgb2gray(imageIn), 'Sobel');
    C1tg = edge(rgb2gray(im1tg), 'Canny');
    S1tg = edge(rgb2gray(im1tg), 'Sobel');
    subplot(2, 3, 3);
    imshow((C1r));
    title('Szum oraz detektor Cannyego')
    subplot(2, 3, 4);
    imshow((C1tg));
    title('Rozmycie oraz detektor Cannego')
    subplot(2, 3, 5);
    imshow((S1r));
    title('Szum oraz detektor Sobela')
    subplot(2, 3, 6);
    imshow((S1tg));
    title('Rozmycie oraz detektor Sobela')
    sgtitle('(2^4)*\lambda')
   %%%%%%%%%%%%%%%%%
%     subplot(2, 3, 2);
%     imshow(uint8(im1p));
%     title('prostokatny');
%     subplot(2, 3, 3);
%     imshow(uint8(im1t));
%     title('trojkatny')
%     subplot(2, 3, 4);
%     imshow(uint8(im1k));
%     title('Keys')
%     subplot(2, 3, 5);
%     imshow((C1k));
%     title('Cauchy krawedzie')
%     subplot(2, 3, 6);
%     imshow((S1k));
%     title('Sobel krawedzie')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     inputSize = net.Layers(1).InputSize(1:2);
%     im = imresize(im1p,inputSize);
%     [label, score] = classify(net,im);
%     [~,idx]=sort(score,'descend');
%     idx=idx(5:-1:1);
%     scoreTop = score(idx);
%     classes=net.Layers(end).Classes;
%     classnamestop=string(classes(idx));
%     scoretop=score(idx);
%     barh(ax2,scoreTop)
%     xlim(ax2,[0 1])
%     title(ax2,'Top 5')
%     xlabel(ax2,'Probability')
%     yticklabels(ax2,classNamesTop)
%     ax2.YAxisLocation = 'right';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     figure(8);
%     hold on;
%     imshow((C1oryg));

  end
for i=2
    imageIn = imread('GrassHopper.png');
    imageIn = poissrnd(double(imageIn/(LAMBDA(i))))/(256)*LAMBDA(i);
    figure(2);
    hold on;
    subplot(2,3,i);
    imshow((imageIn));
    title('szum');
    im2G = imgaussfilt(imageIn, 1);
    imageFuzzy=imageIn;
    im2t = imresize(imageFuzzy, 1, 'triangle');%imresize(imageFuzzy,1, {JT, 1},'Antialiasing',false);
    im2tg = imresize(im1G, 1, 'triangle');
    subplot(2,3,2);
    imshow(im2tg);
    title('rozmycie f. trojkatna');
    C2r = edge(rgb2gray(imageIn), 'Canny');
    S2r = edge(rgb2gray(imageIn), 'Sobel');
    C2tg = edge(rgb2gray(im2tg), 'Canny');
    S2tg = edge(rgb2gray(im2tg), 'Sobel');
    subplot(2, 3, 3);
    imshow((C2r));
    title('Szum oraz detektor Cannyego')
    subplot(2, 3, 4);
    imshow((C2tg));
    title('Rozmycie oraz detektor Cannego')
    subplot(2, 3, 5);
    imshow((S2r));
    title('Rozmycie oraz detektor Sobela')
    subplot(2, 3, 6);
    imshow((S2tg));
    title('rozmycie + Sobel')
    sgtitle('(2^2)*\lambda')
end
for i=3
    imageIn = imread('GrassHopper.png');
    imageIn = poissrnd(double(imageIn/(LAMBDA(i))))/(256)*LAMBDA(i);
    figure(3);
    hold on;
    subplot(2,3,i);
    imshow((imageIn));
    title('szum');
    im3G = imgaussfilt(imageIn, 1);
    imageFuzzy=imageIn;
    im3t = imresize(imageFuzzy, 1, 'triangle');%imresize(imageFuzzy,1, {JT, 1},'Antialiasing',false);
    im3tg = imresize(im3G, 1, 'triangle');
    subplot(2,3,2);
    imshow(im3tg);
    title('Funkcja trójkątna');
    C3r = edge(rgb2gray(imageIn), 'Canny');
    S3r = edge(rgb2gray(imageIn), 'Sobel');
    C3tg = edge(rgb2gray(im3tg), 'Canny');
    S3tg = edge(rgb2gray(im3tg), 'Sobel');
    subplot(2, 3, 3);
    imshow((C3r));
    title('Szum oraz detektor Cannyego')
    subplot(2, 3, 4);
    imshow((C3tg));
    title('Rozmycie oraz detektor Cannego')
    subplot(2, 3, 5);
    imshow((S3r));
    title('Szum oraz detektor Sobela')
    subplot(2, 3, 6);
    imshow((S3tg));
    title('Rozmycie oraz detektor Sobela')
    sgtitle('(2^0)*\lambda')
end
for i=4
    imageIn = imread('GrassHopper.png');
    imageIn = poissrnd(double(imageIn/(LAMBDA(i))))/(256)*LAMBDA(i);
    figure(4);
    hold on;
    subplot(2,3,i);
    imshow((imageIn));
    title('szum');
    im4G = imgaussfilt(imageIn, 1);
    imageFuzzy=imageIn;
    im4t = imresize(imageFuzzy, 1, 'triangle');%imresize(imageFuzzy,1, {JT, 1},'Antialiasing',false);
    im4tg =imresize(im4G, 1, 'triangle');
    subplot(2,3,2);
    imshow(im4tg);
    title('Funkcja trójkątna');
    C4r = edge(rgb2gray(imageIn), 'Canny');
    S4r = edge(rgb2gray(imageIn), 'Sobel');
    C4tg = edge(rgb2gray(im4tg), 'Canny');
    S4tg = edge(rgb2gray(im4tg), 'Sobel');
    subplot(2, 3, 3);
    imshow((C4r));
    title('Szum oraz detektor Cannyego')
    subplot(2, 3, 4);
    imshow((C4tg));
    title('Rozmycie oraz detektor Cannego')
    subplot(2, 3, 5);
    imshow((S4r));
    title('szum + Sobel')
    subplot(2, 3, 6);
    imshow((S4tg));
    title('Rozmycie oraz detektor Sobela')
    sgtitle('(2^{-2})*\lambda')
end
for i=5
    imageIn = imread('GrassHopper.png');
    imageIn = poissrnd(double(imageIn/(LAMBDA(i))))/(256)*LAMBDA(i);
    figure(5);
    hold on;
    subplot(2,3,i);
    imshow((imageIn));
    title('szum');
    im5G = imgaussfilt(imageIn, 1);
    imageFuzzy=imageIn;
    im5t = imresize(imageFuzzy, 1, 'triangle');%imresize(imageFuzzy,1, {JT, 1},'Antialiasing',false);
    im5tg = imresize(im5G, 1, 'triangle');
    subplot(2,3,2);
    imshow(im1tg);
    title('Funkcja trójkątna');
    C5r = edge(rgb2gray(imageIn), 'Canny');
    S5r = edge(rgb2gray(imageIn), 'Sobel');
    C5tg = edge(rgb2gray(im5tg), 'Canny');
    S5tg = edge(rgb2gray(im5tg), 'Sobel');
    subplot(2, 3, 3);
    imshow((C5r));
    title('Szum oraz detektor Cannyego')
    subplot(2, 3, 4);
    imshow((C5tg));
    title('Rozmycie oraz detektor Cannego')
    subplot(2, 3, 5);
    imshow((S5r));
    title('Szum oraz detektor Sobela')
    subplot(2, 3, 6);
    imshow((S5tg));
    title('Rozmycie oraz detektor Sobela')
    sgtitle('(2^{-4})*\lambda')
end
for i=6
    imageIn = imread('GrassHopper.png');
    imageIn = poissrnd(double(imageIn/(LAMBDA(i))))/(256)*LAMBDA(i);
    figure(6);
    hold on;
    subplot(2,3,i);
    imshow((imageIn));
    title('szum');
    im6G = imgaussfilt(imageIn, 1);
    imageFuzzy=imageIn;
    im6t = imresize(imageFuzzy, 1, 'triangle');%imresize(imageFuzzy,1, {JT, 1},'Antialiasing',false);
    im6tg = imresize(im6G, 1, 'triangle');
    subplot(2,3,2);
    imshow(im6tg);
    title('Funkcja trójkątna');
    C6r = edge(rgb2gray(imageIn), 'Canny');
    S6r = edge(rgb2gray(imageIn), 'Sobel');
    C6tg = edge(rgb2gray(im6tg), 'Canny');
    S6tg = edge(rgb2gray(im6tg), 'Sobel');
    subplot(2, 3, 3);
    imshow((C6r));
    title('Szum oraz detektor Cannyego')
    subplot(2, 3, 4);
    imshow((C6tg));
    title('Rozmycie oraz detektor Cannego')
    subplot(2, 3, 5);
    imshow((S6r));
    title('Szum oraz detektor Sobela')
    subplot(2, 3, 6);
    imshow((S6tg));
    title('Rozmycie oraz detektor Sobela')
    sgtitle('(2^{-8})*\lambda')
end
% figure(2);
% hold on;
% subplot(2,3,1);
% imshow((im1p));
% title('(2^4)*lambda');
% subplot(2,3,2);
% imshow((im2p));
% title('(2^2)*lambda')
% subplot(2,3,3);
% imshow((im3p));
% title('(2^0)*lambda')
% subplot(2,3,4);
% imshow((im4p));
% title('(2^{-2})*lambda')
% subplot(2,3,5);
% imshow((im5p));
% title('(2^{-4})*lambda')
% subplot(2,3,6);
% imshow((im6p));
% title('(2^{-8})*lambda')

% figure(3);
% hold on;
% subplot(2,3,1);
% imshow(uint8(im1t));
% title('(2^4)*lambda');
% subplot(2,3,2);
% imshow(uint8(im2t));
% title('(2^2)*lambda');
% subplot(2,3,3);
% imshow(uint8(im3t));
% title('(2^0)*lambda');
% subplot(2,3,4);
% imshow(uint8(im4t));
% title('(2^{-2})*lambda');
% subplot(2,3,5);
% imshow(uint8(im5t));
% title('(2^{-4})*lambda');
% subplot(2,3,6);
% imshow(uint8(im6t));
% title('(2^{-8})*lambda');
% 
% figure(4);
% hold on;
% subplot(2,3,1);
% imshow(uint8(im1k));
% title('(2^4)*lambda');
% subplot(2,3,2);
% imshow(uint8(im2k));
% title('(2^2)*lambda');
% subplot(2,3,3);
% imshow(uint8(im3k));
% title('(2^0)*lambda');
% subplot(2,3,4);
% imshow(uint8(im4k));
% title('(2^{-2})*lambda');
% subplot(2,3,5);
% imshow(uint8(im5k));
% title('(2^{-4})*lambda');
% subplot(2,3,6);
% imshow(uint8(im6k));
% title('(2^{-8})*lambda');
% figure(5);
% hold on;
% subplot(2,3,1);
% imshow((C1p));
% title('(2^4)*lambda');
% subplot(2,3,2);
% imshow((C2p));
% title('(2^2)*lambda');
% subplot(2,3,3);
% imshow((C3p));
% title('(2^0)*lambda');
% subplot(2,3,4);
% imshow((C4p));
% title('(2^{-2})*lambda');
% subplot(2,3,5);
% imshow((C5p));
% title('(2^{-4})*lambda');
% subplot(2,3,6);
% imshow((C6p));
% title('(2^{-8})*lambda');
% 
% figure(6);
% hold on;
% subplot(2,3,1);
% imshow((S1p));
% title('(2^4)*lambda');
% subplot(2,3,2);
% imshow((S2p));
% title('(2^2)*lambda');
% subplot(2,3,3);
% imshow((S3p));
% title('(2^0)*lambda');
% subplot(2,3,4);
% imshow((S4p));
% title('(2^{-2})*lambda');
% subplot(2,3,5);
% imshow((S5p));
% title('(2^{-4})*lambda');
% subplot(2,3,6);
% imshow((S6p));
% title('(2^{-8})*lambda');
% figure(7);
% hold on;
% subplot(2,3,1);
% imshow((C1t));
% title('(2^4)*lambda');
% subplot(2,3,2);
% imshow((C2t));
% title('(2^2)*lambda');
% subplot(2,3,3);
% imshow((C3t));
% title('(2^0)*lambda');
% subplot(2,3,4);
% imshow((C4t));
% title('(2^{-2})*lambda');
% subplot(2,3,5);
% imshow((C5t));
% title('(2^{-4})*lambda');
% subplot(2,3,6);
% imshow((C6t));
% title('(2^{-8})*lambda');
% 
% figure(8);
% hold on;
% subplot(2,3,1);
% imshow((S1t));
% title('(2^4)*lambda');
% subplot(2,3,2);
% imshow((S2t));
% title('(2^2)*lambda');
% subplot(2,3,3);
% imshow((S3t));
% title('(2^0)*lambda');
% subplot(2,3,4);
% imshow((S4t));
% title('(2^{-2})*lambda');
% subplot(2,3,5);
% imshow((S5t));
% title('(2^{-4})*lambda');
% subplot(2,3,6);
% imshow((S6t));
% title('(2^{-8})*lambda');
% 
% figure(9);
% hold on;
% subplot(2,3,1);
% imshow((C1k));
% title('(2^4)*lambda');
% subplot(2,3,2);
% imshow((C2k));
% title('(2^2)*lambda');
% subplot(2,3,3);
% imshow((C3k));
% title('(2^0)*lambda');
% subplot(2,3,4);
% imshow((C4k));
% title('(2^{-2})*lambda');
% subplot(2,3,5);
% imshow((C5k));
% title('(2^{-4})*lambda');
% subplot(2,3,6);
% imshow((C6k));
% title('(2^{-8})*lambda');
% 
% figure(10);
% hold on;
% subplot(2,3,1);
% imshow((S1k));
% title('(2^4)*lambda');
% subplot(2,3,2);
% imshow((S2k));
% title('(2^2)*lambda');
% subplot(2,3,3);
% imshow((S3k));
% title('(2^0)*lambda');
% subplot(2,3,4);
% imshow((S4k));
% title('(2^{-2})*lambda');
% subplot(2,3,5);
% imshow((S5k));
% title('(2^{-4})*lambda');
% subplot(2,3,6);
% imshow((S6k));
% title('(2^{-8})*lambda');
