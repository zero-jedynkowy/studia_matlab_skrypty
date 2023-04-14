% WYBRANA METODA: QR;
clear variables;
clc;

glownaFunkcja();

function glownaFunkcja()
    listaN = [2 4 8 12 16];
    yZmianaB = [];
    yZmienaA = [];
    otherCounter = 1;
    for counter=listaN
        [naszeA, naszeB] = tworzenieUkladu(counter);
        [Q, R, wynikQR] = rozkladQR(naszeA, naszeB);
        bledneB = nowyWektorB(naszeB, 1);
        [Q, R, bledneX] = rozkladQR(naszeA, bledneB);
        osY = norm(bledneX - wynikQR)/norm(wynikQR);
        yZmianaB(otherCounter) = osY;
        bledneA = nowyWektorB(naszeA, 2);
        [Q, R, bledneX] = rozkladQR(bledneA, naszeB);
        osY = norm(bledneX - wynikQR)/norm(wynikQR);
        yZmianaA(otherCounter) = osY;
        otherCounter = otherCounter + 1;
        disp(bledneA);
        disp(bledneB);
    end
    semilogy(listaN, yZmianaB, "o-g", listaN, yZmianaA, "o-r");
    legend("Zaburzenie B", "Zaburzenie A");
    ylabel("Niedokladnosc");
    xlabel("N");
end

function newB=nowyWektorB(oldB, mode)
    b = 0.00001;
    a = -0.00001;
    if(mode == 2)
       blad = a + (b-a).*rand(length(oldB));
    end
    if(mode == 1)
        blad = a + (b-a).*rand(length(oldB),1);
    end
    newB = oldB + (oldB .* blad);
end

function [a, b]=tworzenieUkladu(n)
    a = hilb(n);
    b = sum(a, 2);
end

function [q, r, x]=rozkladQR(a, b)
    [Q, R, p] = qr(a, "econ","vector");
    wewX(p, :) = R\(Q\b);
    q = Q;
    r = R;
    x = wewX;
end
