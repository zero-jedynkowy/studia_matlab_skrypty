clear variables;
clc;

glownaFunkcja();

function glownaFunkcja()
    listaN = [2 4 8 12 16];
    yQR = [];
    yLU = [];
    yNormalneDzielenie = [];
    otherCounter = 1;
    yCondy = [];
    for counter=listaN
        % zmienne
        [naszeA, naszeB] = tworzenieUkladu(counter);
        wynikWbudowany = metodaWbudowana(naszeA, naszeB);
        [L, U, wynikLU] = rozkladLU(naszeA, naszeB);
        [Q, R, wynikQR] = rozkladQR(naszeA, naszeB);
        wynikNormalny = ones(counter, 1);
        yQR(otherCounter) = norm(wynikQR - wynikNormalny)/norm(wynikNormalny);
        yLU(otherCounter) = norm(wynikLU - wynikNormalny)/norm(wynikNormalny);
        yNormalneDzielenie(otherCounter) = norm(wynikWbudowany - wynikNormalny)/norm(wynikNormalny);
        yCondy(otherCounter) = cond(naszeA)*eps;
        otherCounter = otherCounter + 1;
    end
    semilogy(listaN, yQR, "o-b", listaN, yLU, "o-r", listaN, yNormalneDzielenie, "o-g", listaN, yCondy, "--");
    
    legend("QR", "LU", "Wbudowana", "Cond");
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