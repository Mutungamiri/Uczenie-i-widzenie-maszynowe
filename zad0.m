%% Preliminaries...
close all;

%% Rozdzielczość obrazu
fig=gcf;
fig.Position(3:4)=[256;256];
line = 16;

%Parametry funkcji sinus
blades = 5; rpm = pi/100; alpha = -30:0.1:30;

%% Initial drawing...
%rho = sin(blades*alpha + rpm);
%polarplot(alpha, rho, 'r');

%% Animation...
% Horizontal scanning (vertical one is an exercise for a reader... ;))
h = getframe(gcf); frame = h.cdata; sizer = size(h.cdata, 1);
for m = 2:1:(sizer/line)-line
    rho = sin(blades*alpha + m*rpm);
    polarplot(alpha, rho, 'r');
    for n = 0:1:line-1
        h = getframe(gcf); frame(line*m+n, :, :) = h.cdata(line*m+n, :, :);
    end
end
%% Demonstration!
imshow(frame);