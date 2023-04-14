clear variables;
clc;
glownaFunkcja();

function glownaFunkcja()
    listaN = [2 4 8 12 16];
    yQRHilb = [];
    yLUHilb = [];
    yNormalneDzielenieHilb = [];
    otherCounter = 1;
    yCondyHilb = [];
    
    yQRDiag = [];
    yLUDiag = [];
    yNormalneDzielenieDiag = [];
    yCondyDiag = [];

    for counter=listaN
        % zmienneHilber
        [naszeAHilb, naszeBHilb] = tworzenieUkladu(counter);
        wynikWbudowanyHilb = metodaWbudowana(naszeAHilb, naszeBHilb);
        [LHilb, UHilb, wynikLUHilb] = rozkladLU(naszeAHilb, naszeBHilb);
        [QHilb, RHilb, wynikQRHilb] = rozkladQR(naszeAHilb, naszeBHilb);
        wynikNormalnyHilb = ones(counter, 1);
        yQRHilb(otherCounter) = norm(wynikQRHilb - wynikNormalnyHilb)/norm(wynikNormalnyHilb);
        yLUHilb(otherCounter) = norm(wynikLUHilb - wynikNormalnyHilb)/norm(wynikNormalnyHilb);
        yNormalneDzielenieHilb(otherCounter) = norm(wynikWbudowanyHilb - wynikNormalnyHilb)/norm(wynikNormalnyHilb);
        yCondyHilb(otherCounter) = cond(naszeAHilb)*eps;

        %zmienneDiag
        naszeADiag= tworzenieDiagonalnejSilnej(counter);
        naszeBDiag = sum(naszeADiag, 2);
        wynikWbudowanyDiag = metodaWbudowana(naszeADiag, naszeBDiag);
        [LDiag, UDiag, wynikLUDiag] = rozkladLU(naszeADiag, naszeBDiag);
        [QDiag, RDiag, wynikQRDiag] = rozkladQR(naszeADiag, naszeBDiag);
        wynikNormalnyDiag = ones(counter, 1);
        yQRDiag(otherCounter) = norm(wynikQRDiag - wynikNormalnyDiag)/norm(wynikNormalnyDiag);
        yLUDiag(otherCounter) = norm(wynikLUDiag - wynikNormalnyDiag)/norm(wynikNormalnyDiag);
        yNormalneDzielenieDiag(otherCounter) = norm(wynikWbudowanyDiag - wynikNormalnyDiag)/norm(wynikNormalnyDiag);
        yCondyDiag(otherCounter) = cond(naszeADiag)*eps;

        otherCounter = otherCounter + 1;
    end
    semilogy(listaN, yQRHilb, "o-r", listaN, yLUHilb, "o-g", listaN, yNormalneDzielenieHilb, "o-b", listaN, yCondyHilb, "--", listaN, yQRDiag, "o-c", listaN, yLUDiag, "o-m", listaN, yNormalneDzielenieDiag, "o-k", listaN, yCondyDiag, "--");
    
    legend("QRHelb", "LUHelb", "WbudowanaHelb", "CondHelb", "QRDiag", "LUDiag", "WbudowanaDiag", "CondDiag");
    xlabel("N");
    ylabel("Norma bledu");
end
function [a, b]=tworzenieUkladu(n)
    a = hilb(n);
    b = sum(a, 2);
end

function [l, u, x]=rozkladLU(a, b)
    [L, U, P] = lu(a);
    y = L\(P*b);
    l = L;
    u = U;
    x = U\y;
end

function [q, r, x]=rozkladQR(a, b)
    [Q, R, p] = qr(a, "econ","vector");
    wewX(p, :) = R\(Q\b);
    q = Q;
    r = R;
    x = wewX;
end

function [x]=metodaWbudowana(a, b)
    x = a\b;
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