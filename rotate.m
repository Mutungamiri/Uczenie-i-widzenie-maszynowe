clear;
Pierwotny = imread('obrazek.png');
Rozmiar_Pierwotny = size(Pierwotny,1);

figure(1);
imshow(Pierwotny);

kat = -pi/6;
Matrix = [cos(kat), -sin(kat); sin(kat), cos(kat)];
% Alokujemy pamiec do nowego obrazu bo po obrocie moze wystawac krawedziami
Obrocony = zeros(round(1.5*Rozmiar_Pierwotny));

% Trzeba przesunac uklad wspolrzednych
Srodek = Rozmiar_Pierwotny/2;

for kolor = 1:3
    for x = 1:Rozmiar_Pierwotny
        for y = 1:Rozmiar_Pierwotny
            New_coordinates = Matrix * [x-Srodek;y-Srodek];
            New_x = round(New_coordinates(1,1)) + 0.75*Rozmiar_Pierwotny;
            New_y = round(New_coordinates(2,1)) + 0.75*Rozmiar_Pierwotny;
            if New_x >0 && New_y > 0
                Obrocony(New_x, New_y, kolor) = Pierwotny(x, y, kolor);
            end
        end
    end
end

figure(2);
imshow(uint8(Obrocony));