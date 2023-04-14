clear variables; clc;

% A
wezly = linspace(1, 10, 5);
przedzial = linspace(1, 10, 200);
f = @fun1;
g = @fun2;
wsp_f = obliczenieWspWielNat(f, wezly);
wsp_g = obliczenieWspWielNat(g, wezly);
interpol_f_a = polyval(wsp_f, przedzial);
interpol_g_a = polyval(wsp_g, przedzial);
bladF_a = interpol_f_a - f(przedzial);
bladG_a = interpol_g_a - g(przedzial);

% wykres f(x)
figure()
hold on;
plot(przedzial, f(przedzial), "r-");
plot(przedzial, interpol_f_a, "g-");
plot(wezly, f(wezly), "bo");
legend("Funkcja interpolowana", "Funkcja interpolująca", "Wezly");
title("F(x) pkt a");
hold off;

% wykres g(x)
figure()
hold on;
plot(przedzial, g(przedzial), "r-");
plot(przedzial, interpol_g_a, "g-");
plot(wezly, g(wezly), "bo");
legend("Funkcja interpolowana", "Funkcja interpolująca", "Wezly");
title("G(x) pkt a");
hold off;

% blad f(x) i g(x)
figure()
hold on;
plot(przedzial, bladF_a, "r-")
plot(przedzial, bladG_a, "g-")
legend("Blad f(x) pkt a", "Blad g(x) pkt a");
title("Blad interpolowania pkt a");
hold off;

% B
interpol_f_b = wielNewton(f, wezly, przedzial);
interpol_g_b = wielNewton(g, wezly, przedzial);
bladF_b = interpol_f_b - f(przedzial);
bladG_b = interpol_g_b - g(przedzial);

figure()
hold on;
plot(przedzial, f(przedzial), "r-");
plot(przedzial, interpol_f_b, "g-");
plot(wezly, f(wezly), "bo");
legend("Funkcja interpolowana", "Funkcja interpolująca", "Wezly");
title("F(x) pkt b");
hold off;

figure()
hold on;
plot(przedzial, g(przedzial), "r-");
plot(przedzial, interpol_g_b, "g-");
plot(wezly, g(wezly), "bo");
legend("Funkcja interpolowana", "Funkcja interpolująca", "Wezly");
title("G(x) pkt b");
hold off;

% blad f(x) i g(x)
figure()
hold on;
plot(przedzial, bladF_b, "r-")
plot(przedzial, bladG_b, "g-")
legend("Blad f(x) pkt b", "Blad g(x) pkt b");
title("Blad interpolowania pkt b");
hold off;

% C
interpol_f_c = wielomianLagran(f, przedzial, wezly);
interpol_g_c = wielomianLagran(g, przedzial, wezly);
bladF_c = interpol_f_c - f(przedzial);
bladG_c = interpol_g_c - g(przedzial);

% wykres f(x)
figure()
hold on;
plot(przedzial, f(przedzial), "r-");
plot(przedzial, interpol_f_c, "g-");
plot(wezly, f(wezly), "bo");
legend("Funkcja interpolowana", "Funkcja interpolująca", "Wezly");
title("F(x) pkt c");
hold off;

% wykres g(x)
figure()
hold on;
plot(przedzial, g(przedzial), "r-");
plot(przedzial, interpol_g_c, "g-");
plot(wezly, g(wezly), "bo");
legend("Funkcja interpolowana", "Funkcja interpolująca", "Wezly");
title("G(x) pkt c");
hold off;

% blad f(x) i g(x)
figure()
hold on;
plot(przedzial, bladF_c, "r-")
plot(przedzial, bladG_c, "g-")
legend("Blad f(x) pkt c", "Blad g(x) pkt c");
title("Blad interpolowania pkt c");
hold off;

% Funkcje

function y=wielNewton(fun, wezly, przedzial)
    listaAN = [];
    for k=1:numel(wezly)
        listaAN = [listaAN newtonAN(fun, wezly(1:1:k))];
    end
    wynik = [];
    temp = 0;
    numer = 0;
    for a=przedzial
        temp = 0;
        numer = 0;
        for k=1:length(listaAN)
            temp = temp + listaAN(k)*newton(wezly, a, numer);
            numer = numer + 1;
        end
        temp = temp + fun(wezly(1));
        wynik = [wynik temp];
    end
    
    y = wynik;
end

function y=newton(wezly, x, numer)
    wynik = 1;
    if(numer == 0)
        y = 0;
    else
        for k=1:numer
            wynik = wynik * (x - wezly(k));
        end
        y = wynik;
    end
end

function y=newtonAN(fun, wezly)
    if(length(wezly) == 1)
        y = 1;
    elseif(length(wezly) == 2)
        a = fun(wezly(2)) - fun(wezly(1));
        b = wezly(2) - wezly(1);
        y = a/b;
    else
        q = newtonAN(fun, wezly(2:1:length(wezly)));
        w = newtonAN(fun, wezly(1:1:(length(wezly) - 1)));
        a = q - w;
        b = wezly(length(wezly)) - wezly(1);
        y = a/b;
    end
end

function y=wielomianLagran(fun, przedzial, wezly)
    wsp = wspLagran(fun, wezly);
    wynik = [];
    for k=przedzial
        tymczasowy = 0;
        numer = numel(wezly) - 1;
        for a=1:numel(wsp)
            tymczasowy = tymczasowy + wsp(a)*lagran(wezly, k, numer);
            numer = numer - 1;
        end
        wynik = [wynik tymczasowy];
    end
    y = wynik;
end

function wsp = wspLagran(funkcja, wezly)
    b = funkcja(wezly);
    b = b';
    a = [];
    indeks = 1;
    for row=1:numel(wezly)
        potega = numel(wezly) - 1;
        for column=1:numel(wezly)
            a(row, column) = lagran(wezly, wezly(indeks), potega);
            potega = potega - 1;
        end
        indeks = indeks + 1;
    end
    x = a\b;
    wsp = x;
end

function y = lagran(wezly, x, numer)
    wynik = 1;
    indeksBezElement = numer + 1;
    for k=1:numel(wezly)
        if(k ~= indeksBezElement)
            wynik = wynik*((x - wezly(k))/(wezly(indeksBezElement) - wezly(k)));
        end
    end
    y=wynik;
end

function wsp = obliczenieWspWielNat(funkcja, wezly)
    % Ax=b, x = ?
    b = funkcja(wezly);
    b = b';
    a = [];
    indeks = 1;
    for row=1:numel(wezly)
        potega = numel(wezly) - 1;
        for column=1:numel(wezly)
            a(row, column) = wezly(indeks)^potega;
            potega = potega - 1;
        end
        indeks = indeks + 1;
    end
    x = a\b;
    wsp = x;
end

function y = fun2(x)
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

function y = fun1(x)
    y = log(x);
end