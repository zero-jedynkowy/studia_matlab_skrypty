% WYBRANA METODA: QR;
clear variables;
clc;

glownaFunkcja();

function glownaFunkcja()
    listaN = [2 4 8 12 16];
    yZmianaBHilb = [];
    yZmienaAHilb = [];
    otherCounter = 1;

    yZmianaBDiag = [];
    yZmienaADiag = [];
    for counter=listaN
        [naszeAHilb, naszeBHilb] = tworzenieUkladu(counter);
        [QHilb, RHilb, wynikQRHilb] = rozkladQR(naszeAHilb, naszeBHilb);
        bledneBHilb = nowyWektorB(naszeBHilb, 1);
        [QHilb, RHilb, bledneXHilb] = rozkladQR(naszeAHilb, bledneBHilb);
        osYHilb = norm(bledneXHilb - wynikQRHilb)/norm(wynikQRHilb);
        yZmianaBHilb(otherCounter) = osYHilb;
        bledneAHilb = nowyWektorB(naszeAHilb, 2);
        [QHilb, RHilb, bledneXHilb] = rozkladQR(bledneAHilb, naszeBHilb);
        osYHilb = norm(bledneXHilb - wynikQRHilb)/norm(wynikQRHilb);
        yZmianaAHilb(otherCounter) = osYHilb;
        

         naszeADiag = tworzenieDiagonalnejSilnej(counter);
         naszeBDiag = sum(naszeADiag, 2);
         [QDiag, RDiag, wynikQRDiag] = rozkladQR(naszeADiag, naszeBDiag);
         bledneBDiag = nowyWektorB(naszeBDiag, 1);
         [QDiag, RDiag, bledneXDiag] = rozkladQR(naszeADiag, bledneBDiag);
         osYDiag = norm(bledneXDiag - wynikQRDiag)/norm(wynikQRDiag);
         yZmianaBDiag(otherCounter) = osYDiag;
         bledneADiag = nowyWektorB(naszeADiag, 2);
         [QDiag, RDiag, bledneXDiag] = rozkladQR(bledneADiag, naszeBDiag);
         osYDiag = norm(bledneXDiag - wynikQRDiag)/norm(wynikQRDiag);
         yZmianaADiag(otherCounter) = osYDiag;
         otherCounter = otherCounter + 1;
    end
    semilogy(listaN, yZmianaBHilb, "o-r", listaN, yZmianaAHilb, "o-g", listaN, yZmianaBDiag, "o-b", listaN, yZmianaADiag, "o-c");
    legend("Zaburzenie B__HILB", "Zaburzenie A__HILB", "Zaburzenie B__DIAG", "Zaburzenie A__DIAG");
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

function diagonalna=tworzenieDiagonalnejSilnej(n)
    macierz = round(-10 + (20).*rand(n,n));
    kopia = macierz;
    disp(macierz)
    for iter1=1:n
        kopia(iter1, iter1) = 0;
    end
    y = sum(abs(kopia), 2);
    for iter1=1:n
        if(abs(macierz(iter1, iter1)) < y(iter1, 1))
            macierz(iter1, iter1) = y(iter1, 1) + 1;
        end
    end
    disp(macierz);
    diagonalna = macierz;
end
