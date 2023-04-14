clear variables;
clc;

glownaFunkcja();

function glownaFunkcja()
    listaN = [2 4 8 12 16];
    for counter=listaN
        % zmienne
        [naszeA, naszeB] = tworzenieUkladu(counter);
        wynikWbudowany = metodaWbudowana(naszeA, naszeB);
        [L, U, wynikLU] = rozkladLU(naszeA, naszeB);
        [Q, R, wynikQR] = rozkladQR(naszeA, naszeB);
       
        % wypisanie wynikow
        fprintf('N = %d\n', counter);
        fprintf('Macierz A:\n');
        disp(naszeA);
        fprintf('Macierz B:\n');
        disp(naszeB);
        fprintf('Metoda wbudowana; x = \n');
        disp(wynikWbudowany);
        fprintf('Metoda LU; x = \n');
        disp(wynikLU);
        fprintf('L = \n')
        disp(L);
        fprintf('U = \n')
        disp(U);
        fprintf('Metoda QR; x = \n');
        disp(wynikQR);
        fprintf('Q = \n')
        disp(Q);
        fprintf('R = \n')
        disp(R);
    end
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