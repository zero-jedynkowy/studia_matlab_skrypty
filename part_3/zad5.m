clear variables; clc;
g = @fun2;
wezly = linspace(1, 10, 12);
przedzial = linspace(1, 10, 201);

blad = [];

for n=2:1:10
    wsp = polyfit(wezly, g(wezly), n);
    interpol = polyval(wsp, przedzial);
    figure()
    hold on;
    plot(wezly, g(wezly), "ro");
    plot(przedzial, interpol, "g-");
    plot(przedzial, g(przedzial), "b-")
    hold off;
    blad = [blad max(abs(interpol - g(przedzial)))];
end

figure()
hold on;
semilogy(2:1:10, blad , "r-");
hold off;

function y=fun2(x)
    condition = (x > 5);
    tablicaY = [];
    for k=1:length(x)
        if(condition(k) == 1)
            tablicaY = [tablicaY 1];
        else
            tablicaY = [tablicaY x(k)/5];
        end
    end
    y = tablicaY;
end