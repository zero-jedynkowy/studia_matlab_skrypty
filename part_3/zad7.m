clear variables; clc;

f = @fun1;
przedzial = linspace(0, 2*pi, 256);
blad_polyval = [];
for n=3:1:15
    wezly = linspace(0, 2*pi, n);
    wsp = polyfit(wezly, f(wezly), n - 1);
    interpol_polyval = polyval(wsp, przedzial);
    figure()
    hold on;
    plot(wezly, f(wezly), "ro");
    plot(przedzial, f(przedzial), "g-");
    plot(przedzial, interpol_polyval);
    blad_polyval = [blad_polyval norm(interpol_polyval - f(przedzial), 2)];
end

blad_polyval = [];
for n=3:1:15
    wezly = linspace(0, 2*pi, n);
    wyniki = interpft(f(przedzial), n);
    
end

function y=fun1(x)
    y = exp(sin(x));
end