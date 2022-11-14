
clear;
Pierwotny = imread('GrassHopperX.png');
figure(1);
imshow(Pierwotny);
N_old = size(Pierwotny,1);

N_new = 1024;

% Podwojne skalowanie obrazu
tic;
Powiekszony = Skalowanie(N_new, Pierwotny);
figure(2);
imshow(Powiekszony);
Koncowy = Skalowanie(N_old, Powiekszony);
figure(3);
imshow(Koncowy);
toc;

% Oblliczanie bledu skalowania
Substraction_matrix = Koncowy - Pierwotny;
Substraction_matrix_abs = abs(Substraction_matrix);
Error = sum(Substraction_matrix_abs, 'all');

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
                            %anew(j) = okno(a(j), -0.5, 0.5);
                            %anew(j) = Keys(a(j));
                            anew(j) = trojkat(a(j));
                            I_new_rows(k,i,c) = I_new_rows(k,i,c) + I(k,j,c) * anew(j);
                    end    
            end
    end



    % Skalowanie pionowe)
    for k = 1:N_new
            for i = 1:N_new
                    a = X(i) - odj;
                    for j = 1:N_old
                            %anew(j) = okno(a(j), -0.5, 0.5);
                            %anew(j) = Keys(a(j));
                            anew(j) = trojkat(a(j));
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
    a = 0.3;
    ok = ((a + 2)*x^3 - (a + 3)*x^2 + 1) * okno(x, 0, 1)+ (a * x^3 - 5*a * x^2 + 8*a * x - 4*a) * okno(x, 0, 2) * (1 - okno(x, 0, 1));

end
