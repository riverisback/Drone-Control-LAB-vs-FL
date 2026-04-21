clear all
close all
bdclose('all')
warning off

%% Configuracion
global Ts aprox
Ts    = 0.02;
tau   = 0.01;
aprox = 1;

project_root = fileparts(mfilename('fullpath'));
addpath(genpath(project_root));

%% Trayectoria de referencia y grilla de simulacion
global x_ref y_ref z_ref psi_ref
cfg = build_project_config(Ts);

tray     = cfg.tray;
end_time = cfg.end_time;
t        = cfg.t;
iters    = cfg.iters;
x_ref    = cfg.x_ref;
y_ref    = cfg.y_ref;
z_ref    = cfg.z_ref;
psi_ref  = cfg.psi_ref;
dx_ref   = cfg.dx_ref;
dy_ref   = cfg.dy_ref;
dz_ref   = cfg.dz_ref;
dpsi_ref = cfg.dpsi_ref;
x_ini    = cfg.x_ini;
y_ini    = cfg.y_ini;
z_ini    = cfg.z_ini;
if tray == 1
    t1 = cfg.t1;
    t2 = cfg.t2;
end

%% Constantes fisicas
global M g
M = 1;
g = 9.81;

%% Ganancias del controlador
global k_1 k_2 k_3 k_4 k_5 k_6 k_7 k_8 k_9 k_10 k_11 k_12
[k_1,k_2,k_3,k_4,k_5,k_6,k_7,k_8,k_9,k_10,k_11,k_12,K1,K2,K3,K4] = build_controller_gains(tray);

k11=K1(1); k12=K1(2); k13=K1(3); k14=K1(4);
k21=K2(1); k22=K2(2); k23=K2(3); k24=K2(4);
k31=K3(1); k32=K3(2); k33=K3(3); k34=K3(4);
k41=K4(1); k42=K4(2);

%% Limites de saturacion
u_max = 20;   u_min = 0;
tau_phi_max   =  10;  tau_phi_min   = -10;
tau_theta_max =  10;  tau_theta_min = -10;
tau_psi_max   =   1;  tau_psi_min   =  -1;

lim = inf;

%% Reserva de memoria para resultados
simulations = 2;
r = init_result_arrays(iters, simulations);
tsim      = r.tsim;
x         = r.x;         y         = r.y;         z         = r.z;
phi       = r.phi;       theta     = r.theta;     psi       = r.psi;
u         = r.u;         tau_phi   = r.tau_phi;
tau_theta = r.tau_theta; tau_psi   = r.tau_psi;
e_x       = r.e_x;       e_y       = r.e_y;
e_z       = r.e_z;       e_psi     = r.e_psi;

%% Condiciones iniciales (variables del workspace leidas por Simulink)
global x1_0 x3_0 x5_0 x7_0 x9_0 x11_0 u1_0 du1_0
x1_0  = x_ini;  x3_0  = y_ini;  x5_0  = z_ini;
x7_0  = 0;      x9_0  = 0;      x11_0 = 0;
u1_0  = M * g;  du1_0 = 0;

%% Bucle de simulacion
global i j
controller = ["LAB", "FL"];
ref_trim = (tray == 1) + 1;  % la referencia tiene 2 muestras extra para tray 1, 1 para tray 2

for j = 1:simulations
    i = 1;

    tic
    model_file = fullfile(project_root, "simulink", "modelo_dinamico_" + controller(j) + ".slx");
    out = sim(model_file);
    toc

    input   = out.data.u;
    outputs = out.data.y;
    tsim(:,j) = out.tout();

    u(:,j)         = input(:,1);
    tau_phi(:,j)   = input(:,2);
    tau_theta(:,j) = input(:,3);
    tau_psi(:,j)   = input(:,4);

    x(:,j)     = outputs(:,1);
    y(:,j)     = outputs(:,3);
    z(:,j)     = outputs(:,5);
    phi(:,j)   = outputs(:,7);
    theta(:,j) = outputs(:,9);
    psi(:,j)   = outputs(:,11);

    x_dot     = outputs(:,2);
    y_dot     = outputs(:,4);
    z_dot     = outputs(:,6);
    phi_dot   = outputs(:,8);
    theta_dot = outputs(:,10);
    psi_dot   = outputs(:,12);

    e_x(:,j)   = x_ref(1:end-ref_trim) - x(:,j);
    e_y(:,j)   = y_ref(1:end-ref_trim) - y(:,j);
    e_z(:,j)   = z_ref(1:end-ref_trim) - z(:,j);
    e_psi(:,j) = psi_ref(1:end-ref_trim) - psi(:,j);
end

% Ajuste de la referencia si su longitud difiere de la salida de simulacion.
if length(tsim(:,1)) ~= length(t)
    d = abs(size(tsim,1) - length(x_ref));
    if length(x_ref) > length(tsim)
        x_ref   = x_ref(1:end-d);
        y_ref   = y_ref(1:end-d);
        z_ref   = z_ref(1:end-d);
        psi_ref = psi_ref(1:end-d);
    end
    t = tsim(:,1);
end

%% Ventanas de transitorio
t1_1 = 0;    t1_2 = 10;
t2_1 = 38;   t2_2 = 53.00;

it1_1 = find(t == t1_1);  it1_2 = find(t == t1_2);
it2_1 = find(t == t2_1);  it2_2 = find(t == t2_2);

print_metrics(struct( ...
    'simulations', simulations, 'controller', controller, ...
    'x_ref', x_ref, 'y_ref', y_ref, 'z_ref', z_ref, 'psi_ref', psi_ref, ...
    'x', x, 'y', y, 'z', z, 'psi', psi, ...
    'u', u, 'tau_phi', tau_phi, 'tau_theta', tau_theta, 'tau_psi', tau_psi, ...
    't', t, 'it1_1', it1_1, 'it1_2', it1_2, 'it2_1', it2_1, 'it2_2', it2_2));

%% Visualizaciones
plot_results;
