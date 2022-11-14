clear;
Im = imread("moonlosowy.bmp");
%Im = im2bw(Im, 0.5);
Im = rgb2gray(Im);
rozmiarX = size(Im,1);
rozmiarY = size(Im,2);
rozmiar_pierwotny = rozmiarX*rozmiarY
rozmiar_skompresowany = 0;
figure(1);
imshow(Im);
A = Im;

% Funkcja do kompresji obrazu
for i = 1:rozmiarX
    licznik = 1;
    kolumny = 1;

    for j = 2:rozmiarY
        if A(i,j) == A(i,j-1)
            licznik = licznik + 1;
        else
            KOL{kolumny} = [A(i,j-1) licznik];
            licznik = 1;
            kolumny = kolumny + 1;
        end
    end
    KOL{kolumny} = [A(i,j) licznik];
    Comp{i} = KOL;
    KOL = {};
end


% Dekompresja obrazu
A_decompress = zeros(rozmiarX, rozmiarY);
iteracja = 1;
zero_jeden = 1;
    for i = 1:rozmiarX
        iter = 1;
        for k = 1:length(Comp{i})
            rozmiar_skompresowany = rozmiar_skompresowany + 1;
                for j=1:Comp{i}{k}(2)
                    A_decompress(i,iter) = Comp{i}{k}(1);
                    iter = iter + 1;
                end     
        end
    end

rozmiar_skompresowany = rozmiar_skompresowany*2
A_decompress = uint8(A_decompress);
figure(2);
imshow(A_decompress);
