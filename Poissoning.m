clear;

Pierwotny = imread('GrassHopper.png');

N_old = size(Pierwotny,1);

% Zaszumianie obrazu szumem o rozkladzie Poissona
Pierwotny_db = double(Pierwotny);
Ilosc_fotonow = 1024;
Zaszumiony = 255 * poissrnd(Pierwotny_db/255 * Ilosc_fotonow)/ Ilosc_fotonow;
Zaszumiony = uint8(Zaszumiony);


figure(1);
imshow(Zaszumiony);

N_new = 100;

% Podwojne skalowanie obrazu

Pomniejszony = Skalowanie(N_new, Zaszumiony);
figure(2);
imshow(Pomniejszony);
Koncowy = Skalowanie(N_old, Pomniejszony);
figure(3);
imshow(Koncowy);


% Oblliczanie bledu skalowania
Substraction_matrix1 = Koncowy - Pierwotny;
Substraction_matrix_abs1 = abs(Substraction_matrix1);
Error_abs_pierwotny = sum(Substraction_matrix_abs1, 'all') / (N_old*N_old)

Substraction_matrix2 = Koncowy - Zaszumiony;
Substraction_matrix_abs2 = abs(Substraction_matrix2);
Error_abs_zaszumiony = sum(Substraction_matrix_abs2, 'all') / (N_old*N_old)

Substraction_matrix3 = Koncowy - Pierwotny;
Substraction_matrix_sq1 = (Substraction_matrix3).^2;
Error_square_pierwotny = sum(Substraction_matrix_sq1, 'all') / (N_old*N_old)

Substraction_matrix4 = Koncowy - Zaszumiony;
Substraction_matrix_sq2 = (Substraction_matrix4).^2;
Error_square_zaszumiony = sum(Substraction_matrix_sq2, 'all') / (N_old*N_old)

%% Funkcja skalująca
function Obraz = Skalowanie(N_new, I)
N_old = size(I,1);
X = linspace(0,N_old,N_new);
I_new_rows = zeros(N_old, N_new,3);
Obraz = zeros(N_new, N_new,3);
anew = zeros(1,N_old);
odj = linspace(0,N_old,N_old);

% Skalowanie poziome
for c = 1:3
    for k = 1:N_old
            for i = 1:N_new
                    a = X(i) - odj;
                    for j = 1:N_old
                            anew(j) = okno(a(j), -0.5, 0.5);
                            %anew(j) = Keys(a(j));
                            %anew(j) = trojkat(a(j));
                            I_new_rows(k,i,c) = I_new_rows(k,i,c) + I(k,j,c) * anew(j);
                    end    
            end
    end



    % Skalowanie pionowe)
    for k = 1:N_new
            for i = 1:N_new
                    a = X(i) - odj;
                    for j = 1:N_old
                            anew(j) = okno(a(j), -0.5, 0.5);
                            %anew(j) = Keys(a(j));
                            %anew(j) = trojkat(a(j));
                            Obraz(i,k,c) = Obraz(i,k,c) + I_new_rows(j,k,c) * anew(j);
                    end    
                    Obraz(i,k,c) = round(Obraz(i,k,c));
            end
    end
end

%Trzeba zrobić konwersje do uint8 zeby poprawnie sie wyswietlalo
Obraz = uint8(Obraz);
end


%% Funkcje interpolacyjne
function ok = okno(x, l, m)
   ok = (x >= l) .* (x < m);
end

function ok = trojkat(x)
   ok = okno(x,-1,1) * (1-abs(x));
end

function ok = Keys(x)
    x = abs(x);
    a = 0.5;
    ok = ((a + 2)*x^3 - (a + 3)*x^2 + 1) * okno(x, 0, 1)+ (a * x^3 - 5*a * x^2 + 8*a * x - 4*a) * okno(x, 0, 2) * (1 - okno(x, 0, 1));

end
