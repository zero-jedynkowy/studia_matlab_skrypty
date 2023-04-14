clear variables; clc;
lata = 1900:10:2010;
ludnosc = [75.995, 91.972, 105.711, 123.203, 131.669, 150.697, 179.323, 203.212, 226.505, 249.633, 281.422, 308.746];
wiecejX = 1900:1:2020;

% A
wsp = polyfit(lata, ludnosc, numel(lata) - 1);
interpolowaneY_pktA = polyval(wsp, wiecejX);
ludnosc2k19 = polyval(wsp, 2019);
figure()
hold on;
plot(wiecejX, interpolowaneY_pktA, "r-");
plot(2019, ludnosc2k19, "go");
plot(2019, 330.348, "bo");
title("Wykres A");
hold off;

% B
[p, S, mu] = polyfit(lata, ludnosc, numel(lata) - 1);
interpolowaneY_pktB = polyval(p, wiecejX, S, mu);
ludnosc2k19 = polyval(wsp, 2019, S, mu);
figure()
hold on;
plot(wiecejX, interpolowaneY_pktB , "r-");
plot(2019, ludnosc2k19, "go");
plot(2019, 330.348, "bo");
title("Wykres B");
hold off;

% C
interpolowaneY_pktC = interp1(lata, ludnosc, wiecejX, "cubic");
ludnosc2k19 = interp1(lata, ludnosc, 2019, "cubic");
figure()
hold on;
plot(wiecejX, interpolowaneY_pktC, "r-");
plot(2019, ludnosc2k19, "go");
plot(2019, 330.348, "bo");
title("Wykres C");
hold off;

% D
interpolowaneY_pktD = interp1(lata, ludnosc, wiecejX, "linear", "extrap");
ludnosc2k19 = interp1(lata, ludnosc, 2019, "linear", "extrap");
figure()
hold on;
plot(wiecejX, interpolowaneY_pktD, "r-");
plot(2019, ludnosc2k19, "go");
plot(2019, 330.348, "bo");
title("Wykres D");
hold off;