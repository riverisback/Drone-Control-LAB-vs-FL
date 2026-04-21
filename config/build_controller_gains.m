function [k_1,k_2,k_3,k_4,k_5,k_6,k_7,k_8,k_9,k_10,k_11,k_12,K1,K2,K3,K4] = build_controller_gains(tray)

% Seleccion de ganancias segun el tipo de trayectoria.
if tray == 1
    k_1 = 0.99;
    k_2 = 0.97;
    k_3 = 0.99;
    k_4 = 0.98;
    k_5 = 0.99;
    k_6 = 0.79;
    k_7 = 0.96;
    k_8 = 0.91;
    k_9 = 0.96;
    k_10 = 0.92;
    k_11 = 0.99;
    k_12 = 0.95;

    p11 = 0.5;
    p12 = 2.4;
    p13 = -1.1i;
    p14 = 1.1i;

    p21 = 0.7;
    p22 = 1.8;
    p23 = -1i;
    p24 = 1i;

    p31 = -1.1i;
    p32 = 1.1i;
    p33 = 0.6;
    p34 = 2.3;

    p41 = 1;
    p42 = 0.5;
else
    k_1 = 0.99;
    k_2 = 0.89;
    k_3 = 0.99;
    k_4 = 0.89;
    k_5 = 0.99;
    k_6 = 0.79;
    k_7 = 0.85;
    k_8 = 0.81;
    k_9 = 0.85;
    k_10 = 0.81;
    k_11 = 0.85;
    k_12 = 0.95;

    p11 = 0;
    p12 = 7.9;
    p13 = -2.5i;
    p14 = 2.5i;

    p21 = 0;
    p22 = 8;
    p23 = -2.5i;
    p24 = 2.5i;

    p31 = -2.7i;
    p32 = 2.7i;
    p33 = 0;
    p34 = 8;

    p41 = 3 - 3i;
    p42 = 3 + 3i;
end

K1 = pole_placement(-p11, -p12, -p13, -p14);
K2 = pole_placement(-p21, -p22, -p23, -p24);
K3 = pole_placement(-p31, -p32, -p33, -p34);
K4 = pole_placement(-p41, -p42);

end

function K = pole_placement(n1, n2, n3, n4)
syms n k1 k2 k3 k4

if nargin == 4
    A = [-n    1     0     0;
          0   -n     1     0;
          0    0    -n     1;
         -k1  -k2   -k3  -n-k4];
    eq1 = subs(det(A), n, n1) == 0;
    eq2 = subs(det(A), n, n2) == 0;
    eq3 = subs(det(A), n, n3) == 0;
    eq4 = subs(det(A), n, n4) == 0;
    [A, B] = equationsToMatrix([eq1, eq2, eq3, eq4], [k1, k2, k3, k4]);
else
    A = [-n    1;
         -k1  -n-k2];
    eq1 = subs(det(A), n, n1) == 0;
    eq2 = subs(det(A), n, n2) == 0;
    [A, B] = equationsToMatrix([eq1, eq2], [k1, k2]);
end

K = double(linsolve(A, B)');
end