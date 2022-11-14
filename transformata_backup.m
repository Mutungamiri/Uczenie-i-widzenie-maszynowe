function transformata()
    wybor_transformaty = 1;
    wybor_operacji = 1;
    WHT_wspolczynnik = 1;
    DCT_wspolczynnik = 20;
    Haar_wspolczynnik = 20;
    A_ideal = imresize(imread('mleczna.jpg'), [1024 1024]);
    A = imresize(imread('mleczna.jpg'), [1024 1024]);
    A = rgb2gray(A); 
    block_size = 1024;
    % Slider
    f = gcf; 
    c = uicontrol(f, 'Style', 'slider', 'Position', [200 20 150 20]);
        c.Value = 0.0;
        set(c, 'min', 0);
        set(c, 'max', 5);
        c.Callback = @sliderAMovement;
    block_size_edit = uicontrol('Style','edit', 'Position', [260 80 50 20]);
        block_size_edit.Callback = @block_size_selection;
    block_size_text = uicontrol(f,'Style','text', 'String','Wybor wielkosci bloku');
        block_size_text.Position = [190 60 200 20];
    function block_size_selection(src, ~)
        block_size = str2double(block_size_edit.String);
    end

    % Transform list
    transform_choice = uicontrol(f,'Style','popupmenu');
        transform_choice.Position = [20 70 100 20];
        transform_choice.String = {'WHT','cosinus','Haar', '5/3', '9/7'};
        transform_choice.Callback = @transform_selection;
    transform_choice_text = uicontrol(f,'Style','text', 'String','Wybor transformaty');
        transform_choice_text.Position = [20 90 100 20];
    function transform_selection(src, ~)
        wybor_transformaty = transform_choice.Value;
    end

    % List of noise reduction method
    method_choice = uicontrol(f,'Style','popupmenu');
        method_choice.Position = [440 70 100 20];
        method_choice.String = {'Progowanie','Kwantyzacja'};
        method_choice.Callback = @method_selection;
    method_choice_text = uicontrol(f,'Style','text', 'String','Wybor operacji');
        method_choice_text.Position = [440 90 100 20];
    function method_selection(src, ~)
        wybor_operacji = method_choice.Value;
    end


   function sliderAMovement(src, ~)
        switch(wybor_transformaty)
                case 1  % Transformata Walsha - Hadamarda
                    
                   % Deklaracja handlera zeby przetwarzac obraz blok po bloku
                   % Transformata i operacje sa w funkcji walshHadamard
                   walshHadamardHandlerA = @(block_struct) walshHadamardA(block_struct.data, src.Value);
                   B_out= blockproc(A,[block_size block_size],walshHadamardHandlerA);
                   walshHadamardHandlerB = @(block_struct) walshHadamardB(block_struct.data, src.Value);
                   BB= blockproc(A,[block_size block_size],walshHadamardHandlerB);
                   % Ilosc niezerowych wspolczynnikow
                   procent = BB ~= 0;
                   procent = 100*procent/numel(A);
                   procent = sum(procent(:))
                   %Blad sredniokwadratowy
                   Blad = (B_out - A_ideal).^2;
                   Blad = sum(Blad(:))/numel(A)
                   Wartosc = WHT_wspolczynnik*src.Value
                    warning('off'); 
                        sgtitle('Transformata Walsha-Hadamarda')
                        subplot(1, 2, 1); 
                        imshow(abs(BB)); title(['T/Q = ' string(Wartosc) 'Blad = ' string(round(Blad, 2))]);
                        subplot(1, 2, 2);
                        imshow(B_out, []);
                        title(['Non-zeros = ' string(round(procent, 2)) '%']);
                    warning('on');


                case 2  % Transformata cosinusowa
                   % Deklaracja handlera zeby przetwarzac obraz blok po bloku
                   % Transformata i operacje sa w funkcji walshHadamard
                   cosineHandlerA = @(block_struct) cosineA(block_struct.data, src.Value);
                   B_out= blockproc(A,[block_size block_size],cosineHandlerA);
                   cosineHandlerB = @(block_struct) cosineB(block_struct.data, src.Value);
                   BB= blockproc(A,[block_size block_size],cosineHandlerB);

                   % Ilosc niezerowych wspolczynnikow
                   procent = BB ~= 0;
                   procent = 100*procent/numel(A);
                   procent = sum(procent(:))
                   %Blad sredniokwadratowy
                   Blad = (B_out - A_ideal).^2;
                   Blad = sum(Blad(:))/numel(A)
                    Wartosc = src.Value
                    warning('off'); 
                        sgtitle('Transformata Cosinusowa')
                        subplot(1, 2, 1); 
                        imshow(abs(BB)); title(['T/Q = ' string(Wartosc) 'Blad = ' string(round(Blad, 2))]);
                        subplot(1, 2, 2);
                        imshow(B_out, []);
                        title(['Non-zeros = ' string(round(procent, 2)) '%']);
                    warning('on');


                case 3 % Transformata falkowa Haara
                   HaarHandlerA = @(block_struct) HaarA(block_struct.data, src.Value);
                   B_out= blockproc(A,[block_size block_size],HaarHandlerA);
                   HaarHandlerB = @(block_struct) HaarB(block_struct.data, src.Value);
                   B_hor= blockproc(A,[block_size block_size],HaarHandlerB);
                   HaarHandlerC = @(block_struct) HaarC(block_struct.data, src.Value);
                   B_ver= blockproc(A,[block_size block_size],HaarHandlerC);
                   HaarHandlerD = @(block_struct) HaarD(block_struct.data, src.Value);
                   B_diag= blockproc(A,[block_size block_size],HaarHandlerD);
                   HaarHandlerE = @(block_struct) HaarE(block_struct.data, src.Value);
                   B_proc = blockproc(A,[block_size block_size],HaarHandlerE);
                   % Ilosc niezerowych wspolczynnikow
                   procent = B_proc ~= 0;
                   procent = 100*procent/numel(A);
                   procent = sum(procent(:))
                   Wartosc = Haar_wspolczynnik*src.Value
                   %Blad sredniokwadratowy
                   Blad = (B_out - A_ideal).^2;
                   Blad = sum(Blad(:))/numel(A)
                    figure(1);
                    warning('off'); 
                    sgtitle('Transformata Haara')
                        subplot(2, 2, 1); 
                        imshow(B_out, []); title(['Image -> T/Q = ' string(Wartosc)]);
                        subplot(2, 2, 2);
                        imshow(B_ver, []); title(['Vertical -> Blad = ' string(round(Blad, 2))])
                        subplot(2, 2, 3); 
                        imshow(B_hor, []); title(['Horizontal -> Non-zeros = ' string(round(procent, 2)) '%']);
                        subplot(2, 2, 4);
                        imshow(B_diag, []); title("Diagonal")
                    warning('on');
                  case 4
                       Bi1HandlerA = @(block_struct) Bi1A(block_struct.data, src.Value);
                       B_out= blockproc(A,[block_size block_size],Bi1HandlerA);
                       Bi1HandlerB = @(block_struct) Bi1B(block_struct.data, src.Value);
                       B_hor= blockproc(A,[block_size block_size],Bi1HandlerB);
                       Bi1HandlerC = @(block_struct) Bi1C(block_struct.data, src.Value);
                       B_ver= blockproc(A,[block_size block_size],Bi1HandlerC);
                       Bi1HandlerD = @(block_struct) Bi1D(block_struct.data, src.Value);
                       B_diag= blockproc(A,[block_size block_size],Bi1HandlerD);
                       Bi1HandlerE = @(block_struct) Bi1E(block_struct.data, src.Value);
                       B_proc = blockproc(A,[block_size block_size],Bi1HandlerE);
                       % Ilosc niezerowych wspolczynnikow
                       procent = B_proc ~= 0;
                       procent = 100*procent/numel(A);
                       procent = sum(procent(:))
                       Wartosc = Haar_wspolczynnik*src.Value
                       %Blad sredniokwadratowy
                       Blad = (B_out - A_ideal).^2;
                       Blad = sum(Blad(:))/numel(A)
                        figure(1);
                        warning('off'); 
                        sgtitle('Transformata 5/3')
                            subplot(2, 2, 1); 
                            imshow(B_out, []); title(['Image -> T/Q = ' string(Wartosc)]);
                            subplot(2, 2, 2);
                            imshow(B_ver, []); title(['Vertical -> Blad = ' string(round(Blad, 2))])
                            subplot(2, 2, 3); 
                            imshow(B_hor, []); title(['Horizontal -> Non-zeros = ' string(round(procent, 2)) '%']);
                            subplot(2, 2, 4);
                            imshow(B_diag, []); title("Diagonal")
                        warning('on');
                  case 5
                       Bi2HandlerA = @(block_struct) Bi2A(block_struct.data, src.Value);
                       B_out= blockproc(A,[block_size block_size],Bi2HandlerA);
                       Bi2HandlerB = @(block_struct) Bi2B(block_struct.data, src.Value);
                       B_hor= blockproc(A,[block_size block_size],Bi2HandlerB);
                       Bi2HandlerC = @(block_struct) Bi2C(block_struct.data, src.Value);
                       B_ver= blockproc(A,[block_size block_size],Bi2HandlerC);
                       Bi2HandlerD = @(block_struct) Bi2D(block_struct.data, src.Value);
                       B_diag= blockproc(A,[block_size block_size],Bi2HandlerD);
                       Bi2HandlerE = @(block_struct) Bi2E(block_struct.data, src.Value);
                       B_proc = blockproc(A,[block_size block_size],Bi2HandlerE);
                       % Ilosc niezerowych wspolczynnikow
                       procent = B_proc ~= 0;
                       procent = 100*procent/numel(A);
                       procent = sum(procent(:))
                       Wartosc = Haar_wspolczynnik*src.Value
                       %Blad sredniokwadratowy
                       Blad = (B_out - A_ideal).^2;
                       Blad = sum(Blad(:))/numel(A)
                        figure(1);
                        warning('off'); 
                        sgtitle('Transformata 9/7')
                            subplot(2, 2, 1); 
                            imshow(B_out, []); title(['Image -> T/Q = ' string(Wartosc)]);
                            subplot(2, 2, 2);
                            imshow(B_ver, []); title(['Horizontal -> Blad = ' string(round(Blad, 2))])
                            subplot(2, 2, 3); 
                            imshow(B_hor, []); title(['Vertical -> Non-zeros = ' string(round(procent, 2)) '%']);
                            subplot(2, 2, 4);
                            imshow(B_diag, []); title("Diagonal")
                        warning('on');
       end

   end

        % Walsh - Hadamard basic operations
    function out_Image= walshHadamardA(image, val)
                    val = WHT_wspolczynnik*val;
                    % (Forward) Transform
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    B = fwht(fwht(double(Bprim))'); 
                    % Operation
                    switch(wybor_operacji)
                        case 1
                           B(abs(B) < val) = 0;
                        case 2
                           B = val*floor(B/val + 0.5);
                    end

                    % Inverse transform
                    out_Imageprim = ifwht(ifwht(B)');         
                    out_Image = uint8(0.25.*out_Imageprim.^2 + 0.125);



    end
    function transform_image= walshHadamardB(image, val)
                    val = WHT_wspolczynnik*val;
                    % (Forward) Transform
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    B = fwht(fwht(double(Bprim))'); 
                    % Operation
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < val) = 0; transform_image = B ~= 0;
                        case 2
                            B = val*floor(B/val + 0.5); transform_image = B ~= 0;
                    end



    end
    function out_Image = cosineA(image, val)
                    % (Forward) Transform
                    val = DCT_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    B = dct(dct(double(Bprim))'); 
                    % Operation
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    % Inverse transform
                    out_Imageprim = idct(idct(B)');
                    out_Image = uint8(0.25.*out_Imageprim.^2 + 0.125);

    end
    function transform_image = cosineB(image, val)
                    val = DCT_wspolczynnik*val;
                    % (Forward) Transform
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    B = dct(dct(double(Bprim))'); 
                    % Operation
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;transform_image = B ~= 0;
                        case 2
                            B = val*floor(B/val + 0.5); transform_image = B ~= 0;
                    end
    end
    function B_out = HaarA(image, val)
                    wn = 'bior1.1';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    V1img = wcodemat(V1,255,'mat',1);
                    H1img = wcodemat(H1,255,'mat',1);
                    D1img = wcodemat(D1,255,'mat',1);
                    out_Imageprim = waverec2(B, C, wn);
                    B_out = uint8(0.25.*out_Imageprim.^2 + 0.125);
                    B_out = uint8(B_out);
    end
    function B_hor = HaarB(image, val)
                    wn = 'bior1.1';
                    dwtmode('per');
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    val = Haar_wspolczynnik*val;
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    B_hor = wcodemat(H1,255,'mat',1);

    end
    function B_ver = HaarC(image, val)
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    wn = 'bior1.1';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    B_ver = wcodemat(V1,255,'mat',1);

    end
    function B_diag = HaarD(image, val)
                    wn = 'bior1.1';
                    dwtmode('per');
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    val = Haar_wspolczynnik*val;
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    B_diag = wcodemat(D1,255,'mat',1);

    end
    function B_proc = HaarE(image, val)
                    wn = 'bior1.1';
                    dwtmode('per');
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    val = Haar_wspolczynnik*val;
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    B_proc = B;

    end
% Falka 5/3
    function B_out = Bi1A(image, val)
                    wn = 'bior2.2';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    V1img = wcodemat(V1,255,'mat',1);
                    H1img = wcodemat(H1,255,'mat',1);
                    D1img = wcodemat(D1,255,'mat',1);
                    out_Imageprim = waverec2(B, C, wn);
                    B_out = uint8(0.25.*out_Imageprim.^2 + 0.125);
                    B_out = uint8(B_out);
    end
    function B_hor = Bi1B(image, val)
                    wn = 'bior2.2';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    B_hor = wcodemat(H1,255,'mat',1);

    end
    function B_ver = Bi1C(image, val)
                    wn = 'bior2.2';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    B_ver = wcodemat(V1,255,'mat',1);

    end
    function B_diag = Bi1D(image, val)
                    wn = 'bior2.2';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    B_diag = wcodemat(D1,255,'mat',1);

    end
    function B_proc = Bi1E(image, val)
                    wn = 'bior2.2';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    B_proc = B;

    end
% Falka 9/7
    function B_out = Bi2A(image, val)
                    wn = 'bior4.4';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    V1img = wcodemat(V1,255,'mat',1);
                    H1img = wcodemat(H1,255,'mat',1);
                    D1img = wcodemat(D1,255,'mat',1);
                    out_Imageprim = waverec2(B, C, wn);
                    B_out = uint8(0.25.*out_Imageprim.^2 + 0.125);
                    B_out = uint8(B_out);
    end
    function B_hor = Bi2B(image, val)
                    wn = 'bior4.4';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    B_hor = wcodemat(H1,255,'mat',1);

    end
    function B_ver = Bi2C(image, val)
                    wn = 'bior4.4';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    B_ver = wcodemat(V1,255,'mat',1);

    end
    function B_diag = Bi2D(image, val)
                    wn = 'bior4.4';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    [H1,V1,D1] = detcoef2('all',B,C,1);
                    B_diag = wcodemat(D1,255,'mat',1);

    end
    function B_proc = Bi2E(image, val)
                    wn = 'bior4.4';
                    dwtmode('per');
                    val = Haar_wspolczynnik*val;
                    Bprim = uint8(2.*sqrt(double(image) +0.375));
                    L = 8; [B, C] = wavedec2(Bprim, L, wn); %L = 1, ... log_2(N)
                    switch(wybor_operacji)
                        case 1
                            B(abs(B) < (val)) = 0;
                        case 2
                            B = val*floor(B/val + 0.5);
                    end
                    B_proc = B;

    end
end