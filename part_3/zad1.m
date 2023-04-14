clear variables; clc;
f = @fun1;
g = @fun2;

% A

przedzial = linspace(1, 10, 200);
wezly = linspace(1, 10, 7);
y_wezly_f = f(wezly);
y_wezly_g = g(wezly);

wsp_f = polyfit(wezly, y_wezly_f, numel(wezly) - 1);
wsp_g = polyfit(wezly, y_wezly_g, numel(wezly) - 1);

interpolowaneY_f = polyval(wsp_f, przedzial);
interpolowaneY_g = polyval(wsp_g, przedzial);

bladF = interpolowaneY_f - f(przedzial);
bladG = interpolowaneY_g - g(przedzial);

% wykres interpolacji f(x)
hold on;
plot(wezly, y_wezly_f, "ro");
plot(przedzial, interpolowaneY_f, "g-");
plot(przedzial, f(przedzial), "b-");
title("Interpolacja f(x)")
legend("Wezly", "Funkcja interpolująca", "Funkcja interpolowana");
hold off;


% wykres interpolacji g(x)
figure();
hold on;
plot(wezly, y_wezly_g, "ro");
plot(przedzial, interpolowaneY_g, "g-");
plot(przedzial, g(przedzial), "b-");
legend("Wezly", "Funkcja interpolująca", "Funkcja interpolowana");
title("Interpolacja g(x)")
hold off;

% blad
figure();
hold on;
plot(przedzial, bladF, "r-");
plot(przedzial, bladG, "g-");
legend("Blad f(x)", "Blad g(x)");
title("Blad interpolacji f(x) i g(x)")
hold off;

% B
N = 1:1:7;
wezly_czeb = czebyszew(N, 1, 10);

wsp_czeb_f = polyfit(wezly_czeb, f(wezly_czeb), numel(wezly_czeb) - 1);
wsp_czeb_g = polyfit(wezly_czeb, g(wezly_czeb), numel(wezly_czeb) - 1);

inter_czeb_f = polyval(wsp_czeb_f, przedzial);
inter_czeb_g = polyval(wsp_czeb_g, przedzial);

bladF_czeb = inter_czeb_f - f(przedzial);
bladG_czeb = inter_czeb_g - g(przedzial);

figure();
hold on;
plot(wezly_czeb, f(wezly_czeb), "ro");
plot(przedzial, inter_czeb_f, "g-");
plot(przedzial, f(przedzial), "b-");
legend("Wezly", "Funkcja interpolująca", "Funkcja interpolowana");
title("Interpolacja czebyszew f(x)")
hold off;

figure();
hold on;
plot(wezly_czeb, g(wezly_czeb), "ro");
plot(przedzial, inter_czeb_g, "g-");
plot(przedzial, g(przedzial), "b-");
legend("Wezly", "Funkcja interpolująca", "Funkcja interpolowana");
title("Interpolacja czebyszew g(x)")
hold off;

figure();
hold on;
plot(przedzial, bladF_czeb, "r-");
plot(przedzial, bladG_czeb, "g-");
legend("Blad f(x)", "Blad g(x)");
title("Blad interpolacji czebyszew f(x) i g(x)")
hold off;

% C
y_f_linear = interp1(wezly, y_wezly_f, przedzial, "linear");
y_f_spline = interp1(wezly, y_wezly_f, przedzial, "spline");
y_f_pchip = interp1(wezly, y_wezly_f, przedzial, "pchip");
bladF_linear = y_f_linear - f(przedzial);
bladF_spline = y_f_spline - f(przedzial);
bladF_pchip = y_f_pchip - f(przedzial);

figure()
hold on;
plot(wezly, y_wezly_f, "ro");
plot(przedzial, y_f_linear, "g-");
plot(przedzial, y_f_spline, "b-");
plot(przedzial, y_f_pchip, "m-");
plot(przedzial, f(przedzial), "c-");
title("Interpolacja f(x)")
legend("Wezly", "linear", "spline", "pchip", "Funkcja interpolowana");
hold off;

figure();
hold on;
plot(przedzial, bladF_linear, "r-");
plot(przedzial, bladF_spline, "g-");
plot(przedzial, bladF_pchip, "b-");
legend("linear", "spline", "pchip");
title("Blad interpolacji f(x) linear, spline, pchip")
hold off;

y_g_linear = interp1(wezly, y_wezly_g, przedzial, "linear");
y_g_spline = interp1(wezly, y_wezly_g, przedzial, "spline");
y_g_pchip = interp1(wezly, y_wezly_g, przedzial, "pchip");
bladG_linear = y_g_linear - g(przedzial);
bladG_spline = y_g_spline - g(przedzial);
bladG_pchip = y_g_pchip - g(przedzial);

figure()
hold on;
plot(wezly, y_wezly_g, "ro");
plot(przedzial, y_g_linear, "g-");
plot(przedzial, y_g_spline, "b-");
plot(przedzial, y_g_pchip, "m-");
plot(przedzial, g(przedzial), "c-");
title("Interpolacja g(x)")
legend("Wezly", "linear", "spline", "pchip", "Funkcja interpolowana");
hold off;

figure();
hold on;
plot(przedzial, bladG_linear, "r-");
plot(przedzial, bladG_spline, "g-");
plot(przedzial, bladG_pchip, "b-");
legend("linear", "spline", "pchip");
title("Blad interpolacji g(x) linear, spline, pchip")
hold off;

function y=czebyszew(a, b, N)
    tab = [];
    for k=1:N
        y = 0.5.*(b - a).*cos(((2.*k+1)*pi)/(2.*N+2)) + 0.5.*(a + b);
        tab = [tab y];
    end
  
end


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