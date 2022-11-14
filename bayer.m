clear;
Pierwotny = imread('trojkat.png');

Rozmiar_Pierwotny = size(Pierwotny,1);
Macierz_zerowa = zeros(Rozmiar_Pierwotny);
%Definicja filtru Bayera
R = [1,0;0,0];
G = [0,1;1,0];
B = [0,0;0,1];
Mozaikowany = zeros(Rozmiar_Pierwotny);

%Powielanie filtru na macierz o rozmiarze obrazu wejsciowego
Big_R = repmat(R,Rozmiar_Pierwotny/2, Rozmiar_Pierwotny/2);
Big_G = repmat(G,Rozmiar_Pierwotny/2, Rozmiar_Pierwotny/2);
Big_B = repmat(B,Rozmiar_Pierwotny/2, Rozmiar_Pierwotny/2);

%Funkcja dokonujaca mozaikowania dla dowolnego filtru
for rows = 1:Rozmiar_Pierwotny
    for columns = 1:Rozmiar_Pierwotny
        if Big_R(rows,columns) == 1
            Mozaikowany(rows,columns,1) = Pierwotny(rows,columns,1);
        else
            Mozaikowany(rows,columns,1) = 0;
        end
        if Big_G(rows,columns) == 1
            Mozaikowany(rows,columns,2) = Pierwotny(rows,columns,2);
        else
            Mozaikowany(rows,columns,2) = 0;
        end
        if Big_B(rows,columns) == 1
            Mozaikowany(rows,columns,3) = Pierwotny(rows,columns,3);
        else
            Mozaikowany(rows,columns,3) = 0;
        end
    end
end

Mozaikowany = uint8(Mozaikowany);

%Obrazy zlozone z poszczegolnych kolorow
Mozaikowany_R = Mozaikowany;
Mozaikowany_R(:,:,2) = Macierz_zerowa;
Mozaikowany_R(:,:,3) = Macierz_zerowa;

Mozaikowany_B = Mozaikowany;
Mozaikowany_B(:,:,1) = Macierz_zerowa;
Mozaikowany_B(:,:,2) = Macierz_zerowa;

Mozaikowany_G = Mozaikowany;
Mozaikowany_G(:,:,1) = Macierz_zerowa;
Mozaikowany_G(:,:,3) = Macierz_zerowa;



figure(1);
imshow(Mozaikowany);
imwrite(Mozaikowany, 'Bayer_LCD_mosaiced.png');
