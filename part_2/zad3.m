clear all;

% A
fun1 = @(x) 1/3.*x.^3 - 3/2.*x.^2 + 2.*x;
fun2 = @(x) -1/10.*x + 0.9;
przedzial = 0:0.1:3;

plot(przedzial, fun1(przedzial), "r-", przedzial, fun2(przedzial), "g-");
legend("Wykres funkcji nr. 1", "Wykres funkcji nr. 2");
xlabel("u_d");
ylabel("i_d");

% Odp: (1,5; 3/4), (0,8; 0,82), (2,2; 0,68)

% B
fun3 = @(x) 1/3.*x.^3 - 1.5.*x.^2 +2.1.*x - 0.9;
wynik = dzialanieFsolve(fun3, 1, 3);
figure()
plot(przedzial, fun1(przedzial), "r-", przedzial, fun2(przedzial), "g-", wynik, fun1(wynik), "bo");
legend("Wykres funkcji nr. 1", "Wykres funkcji nr. 2", "Miejsca zerowe");
xlabel("u_d");
ylabel("i_d");

% C

y1 = [];
y2 = [];
y3 = [];

poczatek = 1e-14;
x = [];
for counter=1:13
    x = [x poczatek];
    poczatek = poczatek * 10;
end

for counter=x
    y1 = [y1 iteracjeFsolve(fun3, counter, 1)];
    y2 = [y2 iteracjeFsolve(fun3, counter, 1.3)];
    y3 = [y3 iteracjeFsolve(fun3, counter, 2)];
end

figure()
plot(x, y1, x, y2, x, y3);
legend("0.8292", "1.5", "2.178");
xlabel("Tolerancja");
ylabel("Iteracje");

% FUNKCJE

% DZIALANIE PRZEZ FSOLVE
function wynik=dzialanieFsolve(fun, x0, b)
    y = [];
    for counter=x0:0.5:b
        y = [y fsolve(fun, counter)];
    end
    wynik = y;
end

function y=iteracjeFsolve(fun, tolerancja, x0)
    optim = optimoptions(@fsolve,'FunctionTolerance', tolerancja);
    [x, fval, exitflag, output] = fsolve(fun, x0, optim);
    clc;
    y = output.iterations;
end