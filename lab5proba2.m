clear all, close all, clc

imageIn = imread('a.jpg');
%imageIn = imageGauss;

imageInn = imread('a.jpg');
imageSize = size (imageIn);
imageFuzzy = imageIn;

% disp('Liczba krawêdzi wzorca')
% imageEdgeRef = edge(imageIn(:,:,1),'prewitt');
% disp(sum(sum(imageEdgeRef ~= 0)))
L = 16;
lambda = [2^4 2^2 2^0 2^(-2) 2^(-4) 2^(-8)];
LAMBDA = [(2^4)*L (2^2)*L (2^0)*L (2^(-2))*L (2^(-4))*L (2^(-8))*L] ;
LAMBDA_NUMBER = 1;
%imageIn1 = poissrnd(double(imageIn)/(LAMBDA(LAMBDA_NUMBER)))/256*(LAMBDA(LAMBDA_NUMBER));
imageIn1 = poissrnd(double(imageIn)*(LAMBDA(LAMBDA_NUMBER)/256))*256/(LAMBDA(LAMBDA_NUMBER));
lambda1 = (LAMBDA(LAMBDA_NUMBER));
LAMBDA_NUMBER = 2;
%imageIn2 = poissrnd(double(imageIn)/(LAMBDA(LAMBDA_NUMBER)))/256*(LAMBDA(LAMBDA_NUMBER));
%imageIn2 = poissrnd(double(imageIn)*(LAMBDA(LAMBDA_NUMBER)/256))/(LAMBDA(LAMBDA_NUMBER)/256);
imageIn2 = poissrnd(double(imageIn)*(LAMBDA(LAMBDA_NUMBER)/256))*256/(LAMBDA(LAMBDA_NUMBER));
lambda2 = (lambda(LAMBDA_NUMBER));
LAMBDA_NUMBER = 3;
%imageIn3= poissrnd(double(imageIn)/(LAMBDA(LAMBDA_NUMBER)))/256*(LAMBDA(LAMBDA_NUMBER));
%imageIn3 = poissrnd(double(imageIn)*(LAMBDA(LAMBDA_NUMBER)/256))/(LAMBDA(LAMBDA_NUMBER)/256);
imageIn3 = poissrnd(double(imageIn)*(LAMBDA(LAMBDA_NUMBER)/256))*256/(LAMBDA(LAMBDA_NUMBER));
lambda3 = (lambda(LAMBDA_NUMBER));
LAMBDA_NUMBER = 4;
%imageIn4 = poissrnd(double(imageIn)/(LAMBDA(LAMBDA_NUMBER)))/256*(LAMBDA(LAMBDA_NUMBER));
imageIn4 = poissrnd(double(imageIn)*(LAMBDA(LAMBDA_NUMBER)/256))*256/(LAMBDA(LAMBDA_NUMBER));
lambda4 = (lambda(LAMBDA_NUMBER));
LAMBDA_NUMBER = 5;
%imageIn5 = poissrnd(double(imageIn)/(LAMBDA(LAMBDA_NUMBER)))/256*(LAMBDA(LAMBDA_NUMBER));
%imageIn5 = poissrnd(double(imageIn)*(LAMBDA(LAMBDA_NUMBER)/256))/(LAMBDA(LAMBDA_NUMBER)/256);
imageIn5 = poissrnd(double(imageIn)*(LAMBDA(LAMBDA_NUMBER)/256))*256/(LAMBDA(LAMBDA_NUMBER));
lambda5 = (lambda(LAMBDA_NUMBER));
LAMBDA_NUMBER = 6;
%imageIn6 = poissrnd(double(imageIn)/(LAMBDA(LAMBDA_NUMBER)))/256*(LAMBDA(LAMBDA_NUMBER));
%imageIn6 = poissrnd(double(imageIn)*(LAMBDA(LAMBDA_NUMBER)/256))/(LAMBDA(LAMBDA_NUMBER)/256);
imageIn6 = poissrnd(double(imageIn)*(LAMBDA(LAMBDA_NUMBER)/256))*256/(LAMBDA(LAMBDA_NUMBER));
lambda6 = (lambda(LAMBDA_NUMBER));

figure(1)

subplot(2,3,1)
imshow((imageIn1))
title('2^4')
subplot(2,3,2)
imshow((imageIn2))
title('2^2')
subplot(2,3,3)
imshow((imageIn3))
title('2^0')
subplot(2,3,4)
imshow((imageIn4))
title('2^-^2')
subplot(2,3,5)
imshow((imageIn5))
title('2^-^4')
subplot(2,3,6)
imshow((imageIn6))
title('2^-^6')


%Liczba próbek uœredniaj¹cych
K = 5;

%jadro trojkatne
JadroTroj = @(x)(1 - abs(x)) .* (abs(x) < 1);
alfa = zeros(1,K);
Jadro = JadroTroj;
 X = linspace(-1,1, K);


% Zamieniamy funckjê w wektor
for k=1:K
       alfa(k) =  Jadro(X(k));
end

 %Normalizujemy
sumAlfa = sum(alfa)*2;
alfa = alfa ./ sumAlfa;

imageFuzzy1 =  imgaussfilt(imageIn1, 1);
%imageFuzzy1 = imageIn1;
imageFuzzy1 = imresize(imageFuzzy1, 1, 'triangle');
imageFuzzy2 =  imgaussfilt(imageIn2, 1);
%imageFuzzy2 = imageIn2;
imageSize = size (imageIn);
imageFuzzy2 = imresize(imageFuzzy2, 1, 'triangle');
imageFuzzy3 =  imgaussfilt(imageIn3, 1);
%imageFuzzy3 = imageIn3;
imageSize = size (imageIn);
imageFuzzy3 = imresize(imageFuzzy3, 1, 'triangle');
imageFuzzy4 =  imgaussfilt(imageIn4, 1);
%imageFuzzy4 = imageIn4;
imageSize = size (imageIn);
imageFuzzy4 = imresize(imageFuzzy4, 1, 'triangle');
imageFuzzy5 =  imgaussfilt(imageIn5, 1/2);
%imageFuzzy5 = imageIn5;
imageSize = size (imageIn);
imageFuzzy5 = imresize(imageFuzzy5, 1, 'triangle');
imageFuzzy6 =  imgaussfilt(imageIn6, 1/2);
%imageFuzzy6 = imageIn6;
imageSize = size (imageIn);
imageFuzzy6 = imresize(imageFuzzy6, 1, 'triangle');

figure(2)
subplot(2,3,1)
imshow((imageFuzzy1))
title('2^4')
subplot(2,3,2)
imshow((imageFuzzy2))
title('2^2')
subplot(2,3,3)
imshow((imageFuzzy3))
title('2^0')
subplot(2,3,4)
imshow((imageFuzzy4))
title('2^-^2')
subplot(2,3,5)
imshow((imageFuzzy5))
title('2^-^4')
subplot(2,3,6)
imshow((imageFuzzy6))
title('2^-^6')
% 
% imageEdgeFuzzy1 = edge(imageFuzzy1(:,:,1),'prewitt');
% imageEdgeNude1 = edge(imageIn1(:,:,1),'prewitt');
% imageEdgeFuzzy2 = edge(imageFuzzy2(:,:,1),'prewitt');
% imageEdgeNude2= edge(imageIn2(:,:,1),'prewitt');
% imageEdgeFuzzy3 = edge(imageFuzzy3(:,:,1),'prewitt');
% imageEdgeNude3 = edge(imageIn3(:,:,1),'prewitt');
% imageEdgeFuzzy4 = edge(imageFuzzy4(:,:,1),'prewitt');
% imageEdgeNude4= edge(imageIn4(:,:,1),'prewitt');
% imageEdgeFuzzy5 = edge(imageFuzzy5(:,:,1),'prewitt');
% imageEdgeNude5= edge(imageIn5(:,:,1),'prewitt');
% imageEdgeFuzzy6 = edge(imageFuzzy6(:,:,1),'prewitt');
% imageEdgeNude6= edge(imageIn6(:,:,1),'prewitt');
% 
% figure(3)
% subplot(2,3,1)
% imshow((imageEdgeNude1))
% title('2^4')
% subplot(2,3,2)
% imshow((imageEdgeNude2))
% title('2^2')
% subplot(2,3,3)
% imshow((imageEdgeNude3))
% title('2^0')
% subplot(2,3,4)
% imshow((imageEdgeNude4))
% title('2^-^2')
% subplot(2,3,5)
% imshow((imageEdgeNude5))
% title('2^-^4')
% subplot(2,3,6)
% imshow((imageEdgeNude6))
% title('2^-^6')
% 
% figure(4)
% subplot(2,3,1)
% imshow((imageEdgeFuzzy1))
% title('2^4')
% subplot(2,3,2)
% imshow((imageEdgeFuzzy2))
% title('2^2')
% subplot(2,3,3)
% imshow((imageEdgeFuzzy3))
% title('2^0')
% subplot(2,3,4)
% imshow((imageEdgeFuzzy4))
% title('2^-^2')
% subplot(2,3,5)
% imshow((imageEdgeFuzzy5))
% title('2^-^4')
% subplot(2,3,6)
% imshow((imageEdgeFuzzy6))
% title('2^-^6')
% 
% net = inceptionresnetv2;
% imSize = net.Layers(1).InputSize; 
% im1 = imresize(imageIn1, [imSize(1) imSize(2)], 'Antialiasing', true);     
% im2 = imresize(imageIn2, [imSize(1) imSize(2)], 'Antialiasing', true);
% im3 = imresize(imageIn3, [imSize(1) imSize(2)], 'Antialiasing', true);
% im4 = imresize(imageIn4, [imSize(1) imSize(2)], 'Antialiasing', true);
% im5 = imresize(imageIn5, [imSize(1) imSize(2)], 'Antialiasing', true);
% im6 = imresize(imageIn6, [imSize(1) imSize(2)], 'Antialiasing', true);
% 
% %% klasyfikacja 1
% [label1, scores1] = classify(net, im1);
% classNames1 = net.Layers(end).ClassNames;
% %ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores1, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop1 = scores1(idx);
% classNamesTop1 = net.Layers(end).ClassNames(idx);
% %% klasyfikacja 2
% [label2, scores2] = classify(net, im2);
% classNames2 = net.Layers(end).ClassNames;
% %ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores2, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop2 = scores2(idx);
% classNamesTop2 = net.Layers(end).ClassNames(idx);
% %% klasyfikacja 3
% [label3, scores3] = classify(net, im3);
% classNames3 = net.Layers(end).ClassNames;
% %ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores3, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop3 = scores3(idx);
% classNamesTop3 = net.Layers(end).ClassNames(idx);
% %% klasyfikacja 4
% [label4, scores4] = classify(net, im4);
% classNames4 = net.Layers(end).ClassNames;
% %ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores4, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop4 = scores4(idx);
% classNamesTop4 = net.Layers(end).ClassNames(idx);
% %% klasyfikacja 5
% [label5, scores5] = classify(net, im5);
% classNames5 = net.Layers(end).ClassNames;%ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores5, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop5 = scores5(idx);
% classNamesTop5 = net.Layers(end).ClassNames(idx);
% %% klasyfikacja 6
% [label6, scores6] = classify(net, im6);
% classNames6 = net.Layers(end).ClassNames;
% %ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores6, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop6 = scores6(idx);
% classNamesTop6 = net.Layers(end).ClassNames(idx);
% 
% figure(5)
% subplot(2,3,1)
% b1 = barh(scoresTop1);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda1));
% xlabel('Probability');
% yticklabels(classNamesTop1);
% subplot(2,3,2)
% b2 = barh(scoresTop2);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda2));
% xlabel('Probability');
% yticklabels(classNamesTop2);
% subplot(2,3,3)
% b3 = barh(scoresTop3);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda3));
% xlabel('Probability');
% yticklabels(classNamesTop3);
% subplot(2,3,4)
% b4 = barh(scoresTop4);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda4));
% xlabel('Probability');
% yticklabels(classNamesTop4);
% subplot(2,3,5)
% b5 = barh(scoresTop5);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda5));
% xlabel('Probability');
% yticklabels(classNamesTop5);
% subplot(2,3,6)
% b6 = barh(scoresTop6);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda6));
% xlabel('Probability');
% yticklabels(classNamesTop6);
% 
% 
% net = inceptionresnetv2;
% imSize = net.Layers(1).InputSize; 
% im1 = imresize(imageFuzzy1, [imSize(1) imSize(2)], 'Antialiasing', true);     
% im2 = imresize(imageFuzzy2, [imSize(1) imSize(2)], 'Antialiasing', true);
% im3 = imresize(imageFuzzy3, [imSize(1) imSize(2)], 'Antialiasing', true);
% im4 = imresize(imageFuzzy4, [imSize(1) imSize(2)], 'Antialiasing', true);
% im5 = imresize(imageFuzzy5, [imSize(1) imSize(2)], 'Antialiasing', true);
% im6 = imresize(imageFuzzy6, [imSize(1) imSize(2)], 'Antialiasing', true);
% 
% %% klasyfikacja 1
% [label1, scores1] = classify(net, im1);
% classNames1 = net.Layers(end).ClassNames;
% %ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores1, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop1 = scores1(idx);
% classNamesTop1 = net.Layers(end).ClassNames(idx);
% %% klasyfikacja 2
% [label2, scores2] = classify(net, im2);
% classNames2 = net.Layers(end).ClassNames;
% %ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores2, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop2 = scores2(idx);
% classNamesTop2 = net.Layers(end).ClassNames(idx);
% %% klasyfikacja 3
% [label3, scores3] = classify(net, im3);
% classNames3 = net.Layers(end).ClassNames;
% %ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores3, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop3 = scores3(idx);
% classNamesTop3 = net.Layers(end).ClassNames(idx);
% %% klasyfikacja 4
% [label4, scores4] = classify(net, im4);
% classNames4 = net.Layers(end).ClassNames;
% %ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores4, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop4 = scores4(idx);
% classNamesTop4 = net.Layers(end).ClassNames(idx);
% %% klasyfikacja 5
% [label5, scores5] = classify(net, im5);
% classNames5 = net.Layers(end).ClassNames;%ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores5, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop5 = scores5(idx);
% classNamesTop5 = net.Layers(end).ClassNames(idx);
% %% klasyfikacja 6
% [label6, scores6] = classify(net, im6);
% classNames6 = net.Layers(end).ClassNames;
% %ile dopasowañ       
% TopListLength = 4;
% [~,idx] = sort(scores6, 'descend');
% idx = idx(TopListLength:-1:1);
% scoresTop6 = scores6(idx);
% classNamesTop6 = net.Layers(end).ClassNames(idx);
% 
% figure(6)
% subplot(2,3,1)
% b1 = barh(scoresTop1);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda1));
% xlabel('Probability');
% yticklabels(classNamesTop1);
% subplot(2,3,2)
% b2 = barh(scoresTop2);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda2));
% xlabel('Probability');
% yticklabels(classNamesTop2);
% subplot(2,3,3)
% b3 = barh(scoresTop3);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda3));
% xlabel('Probability');
% yticklabels(classNamesTop3);
% subplot(2,3,4)
% b4 = barh(scoresTop4);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda4));
% xlabel('Probability');
% yticklabels(classNamesTop4);
% subplot(2,3,5)
% b5 = barh(scoresTop5);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda5));
% xlabel('Probability');
% yticklabels(classNamesTop5);
% subplot(2,3,6)
% b6 = barh(scoresTop6);
% xlim([0 1]);
% title(' Predictions for lambda = ', num2str(lambda6));
% xlabel('Probability');
% yticklabels(classNamesTop6);
% 
% 
% % disp('=-------------------');
% % disp('Lambda = ');
% % disp(lambda1);
% % for n = TopListLength:-1:1
% %     disp([classNamesTop(n) char(9) num2str(scoresTop(n), 2)]); 
% % end
