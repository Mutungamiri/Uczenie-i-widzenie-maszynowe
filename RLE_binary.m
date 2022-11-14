clear;
Im = imread("moonlosowy.bmp");
figure(1);
imshow(Im);
rozmiarX = size(Im,1);
rozmiarY = size(Im,2);
rozmiar_pierwotny = rozmiarX*rozmiarY
rozmiar_skompresowany = 0;

A = Im;

% Kompresję zaczynamy od zera i 
for i = 1:rozmiarX
    licznik = 1;
    kolumny = 1;
if A(i,1) ~=0
    KOL{kolumny} = 0;
end
    for j = 2:rozmiarY
        if A(i,j) == A(i,j-1)
            licznik = licznik + 1;
        else
            KOL{kolumny} = licznik;
            licznik = 1;
            kolumny = kolumny + 1;
        end
    end

    KOL{kolumny} = licznik;
    Comp{i} = KOL;
    KOL = {};
end


% Dekompresja
A_decompress = zeros(rozmiarX, rozmiarY);
iteracja = 1;
zero_jeden = 1;

    for i = 1:rozmiarX
        iter = 1;
        for k = 1:length(Comp{i})
            rozmiar_skompresowany = rozmiar_skompresowany + 1;
                for j=1:Comp{i}{k}
                    if mod(k,2)
                        A_decompress(i,iter) = 0;
                        iter = iter + 1;
                    else
                        A_decompress(i,iter) = 1;
                        iter = iter + 1;
                    end
                end     
        end
    end

rozmiar_skompresowany 
figure(2);
imshow(A_decompress);
