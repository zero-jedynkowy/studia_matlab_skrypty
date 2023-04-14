clear all;
wspolczynniki = [0.01 -0.04 0.02 0.04 -0.03];
przedzial = -2:0.1:4;

% A
pierwiastki = roots(wspolczynniki);
pierwiastki2 = szukanieDuplikatow(pierwiastki);

% B
fun2 = @(x) 0.01.*x.^4 -0.04.*x.^3 + 0.02.*x.^2 + 0.04.*x - 0.03;
plot(przedzial, fun2(przedzial), "g-", pierwiastki2, zeros(length(pierwiastki2), 1), "ob")
grid on;
grid minor;

% C
miejscaFZERO = szukanieDuplikatow(zaokraglanie(szukaniePierwiastkow(fun2, 1, -2, 4, 1)));

% DLA D I E MOJE X0 TO -1
x0 = -1;

% D
[wyn1, przyblizenia1, iter1] = bisekcja(fun2, -2, -0.5, 1e-6, x0);
[wyn2, przyblizenia2, iter2] = newton(fun2, -0.5, x0, 1e-6);
[wyn3, przyblizenia3, iter3] = sieczne(fun2, -2, -0.5, x0, 1e-6);

% E
blad1 = bladWzgl(przyblizenia1, x0);
blad2 = bladWzgl(przyblizenia2, x0);
blad3 = bladWzgl(przyblizenia3, x0);
figure();
semilogy(1:iter1, blad1, "r-", 1:iter2, blad2, "g-", 1:iter3, blad3, "b-");
legend("Bisekcja", "Newton", "Sieczne");
xlabel("Iteracje [n]");
ylabel("Blad wzgledny [%]");
% FUNKCJE

function y=bladWzgl(macierz, wartoscPrawdziwa)
    wynik = [];
    temp = 0;
    for counter=macierz
        temp = counter - wartoscPrawdziwa;
        temp = temp/wartoscPrawdziwa;
        temp = abs(temp*100);
        wynik = [wynik temp];
    end
    y = wynik;
end

% ZAOKRAGLA DO 4 MIEJSC
function y=zaokraglanie(x)
    for counter=1:length(x)
        x(counter) = round(x(counter), 4);
    end
    y = x;
end

% SZUKA DUPLIKATY
function y=szukanieDuplikatow(x)
    for counter=1:length(x)
        temporary = find(abs((x - x(counter))) < eps);
        for licznik=temporary
            if(licznik ~= counter)
                x(licznik) = NaN;
            end
        end
    end
    przedWynik = [];
    for a=find(~isnan(x))
        przedWynik = [przedWynik x(a)];
    end
    
    y = przedWynik;
end

% SZUKA PIERWIASTKOW NA 2 SPOSOBY; DRUGI I 

function wyniki=szukaniePierwiastkow(fun, krok, a, b, wersja)
    naszePier = [];
    switch(wersja)
        case 1
            przedzial = a:krok:b;
            for counter=przedzial
                temp = fzero(fun, counter);
                if(temp < a || temp > b)
                    ...
                else
                    naszePier = [naszePier fzero(fun, counter)];
                end
            end
        case 2
            left = a;
            right = a + krok;
            while(left < b && right < b)
                if((fun(left)<0 && fun(right) > 0)||(fun(left)>0 && fun(right) < 0))
                    naszePier = [naszePier fzero(fun, [left right]),];
                end
                left = right;
                right = right + 1;
            end
    end
    wyniki = naszePier;
end

function [wynik, bledyIteracji, iteracje] = bisekcja(fun, a, b, blad, prawdziwaW)
    iterator = 1;
    x_iter = 0;
    przyblizone = [];
    while(iterator<=100)
        if(abs(x_iter - prawdziwaW) <= blad)
            break;
        end
        if(fun(a)*fun(b)<0)
            x_iter = 0.5 * (a + b);
            przyblizone = [przyblizone x_iter];
            if(fun(a)*fun(x_iter)<0)
                b = x_iter;
            end
            if(fun(a)*fun(x_iter)>0)
                a = x_iter;
            end        
        end
        iterator = iterator + 1;
    end
    iteracje = iterator - 1;
    wynik = x_iter;
    bledyIteracji = przyblizone;
end

function [wynik, przyblizenia, iteracje] = newton(fun, punktStartowy, prawdziwaW, blad)
    iterator = 1;
    x_iter = punktStartowy;
    przyblizone = [];
    pochodna = @(x) 0.04.*x.^3 - 0.12*x.^2 + 0.04*x+ 0.04;
    przyblizone = [przyblizone x_iter];
    while(iterator <= 99)
        if(abs(x_iter - prawdziwaW) <= blad)
            break;
        end
        x_iter = x_iter - (fun(x_iter)/pochodna(x_iter));
        przyblizone = [przyblizone x_iter];
        iterator = iterator + 1;
    end
    wynik = x_iter;
    przyblizenia = przyblizone;
    iteracje = iterator;
end

function [wynik, przyblizenia, iteracje] = sieczne(fun, x0, x1, prawdziwaW, blad)
    iterator = 1;
    x_iter = x1;
    x_poprzednie = x0;
    x_zapasowe = 0;
    przyblizone = [];
    y0 = 0;
    y1 = 0;
    poprzedni = 0;
    while(iterator <= 100)
        if(abs(x_iter - prawdziwaW) <= blad)
            break;
        end
        x_zapasowe = x_iter;
        x_iter = x_iter - 1*((x_iter - x_poprzednie)/(fun(x_iter) - fun(x_poprzednie)))*fun(x_iter);
        x_poprzednie = x_zapasowe;
        przyblizone = [przyblizone x_iter];
        iterator = iterator + 1;
    end
    wynik = x_iter;
    przyblizenia = przyblizone;
    iteracje = iterator - 1;

end
