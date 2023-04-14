clear variables; clc;
f = @fun1;
g = @fun2;

bladF_all = [];
bladG_all = [];
przedzial = linspace(1, 10, 200);

for k=2:15
    wezly = linspace(1, 10, k);
    y_wezly_f = f(wezly);
    wsp_f = polyfit(wezly, y_wezly_f, numel(wezly) - 1);
    interpolowaneY_f = polyval(wsp_f, przedzial);
    bladF = interpolowaneY_f - f(przedzial);
    bladF_all = [bladF_all max(abs(bladF))];

    figure();
    hold on;
    plot(wezly, y_wezly_f, "ro");
    plot(przedzial, interpolowaneY_f, "g-");
    plot(przedzial, f(przedzial), "b-");
    title(k);
    hold off;
end

for k=2:15
    wezly = linspace(1, 10, k);
    y_wezly_g = g(wezly);
    wsp_g = polyfit(wezly, y_wezly_g, numel(wezly) - 1);
    interpolowaneY_g = polyval(wsp_g, przedzial);
    bladF = interpolowaneY_g - g(przedzial);
    bladG_all = [bladG_all max(abs(bladF))];

    figure();
    hold on;
    plot(wezly, y_wezly_g, "ro");
    plot(przedzial, interpolowaneY_g, "g-");
    plot(przedzial, g(przedzial), "b-");
    title(k);
    hold off;
end

figure();
hold on;
semilogy(2:1:15, bladF_all);
semilogy(2:1:15, bladG_all);
title("Blad zalezny of f(x) i g(x)");
hold off;

function y = fun1(x)
    y = log(x);
end

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