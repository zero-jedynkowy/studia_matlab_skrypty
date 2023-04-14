clear all;

% PIERWIASTKI
fun2 = @funkcja;

% 1 WERSJA SZUKANIA PIERWIASTKOW
wyn1 = szukaniePierwiastkow(fun2, 1, 20, 50, 1);
wyn2 = szukaniePierwiastkow(fun2, 1, 20, 50, 2);
inne = inneSortowanie(wyn1);

% WYKRES
przedzial = 15:0.1:55;
noweY = szukanieDuplikatow(zaokraglanie(wyn1));
plot(przedzial, funkcja(przedzial), "g-", noweY,zeros(length(noweY), 1), "bo");
legend("Wykres funkcji", "Miejsca zerowe");
xlabel("x");
ylabel("y");

% FUNKCJE

% NASZA FUNKCJA
function y=funkcja(x)
    y=sin(x).*x.^(3/2)-(5*(x-10));
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
        temporary = find(abs(x - x(counter)) < eps);
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

% SZUKA DUPLIKATY V2
function y=inneSortowanie(x)
    for counter=1:length(x)
        for counter2 = counter + 1:length(x)
            if(abs(x(counter2) - x(counter)) < eps)
                x(counter2) = NaN;
            end
        end
    end
    przedWynik = [];
    for a=find(~isnan(x))
        przedWynik = [przedWynik x(a)];
    end
    y = przedWynik;
end