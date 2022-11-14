clear all;

x = 0:0.1:2*pi;
f = sin(1./x);

xspline = 0:0.01:2*pi;
fspline = spline(x,f,xspline);

plot(x,f, 'o', xspline,fspline, 'b')

