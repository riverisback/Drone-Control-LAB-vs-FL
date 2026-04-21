function print_metrics(data)
% Imprime metricas de error y energia para cada ventana de transitorio y el horizonte completo.
%
% Campos requeridos en data:
%   simulations, controller,
%   x_ref, y_ref, z_ref, psi_ref,
%   x, y, z, psi, u, tau_phi, tau_theta, tau_psi,
%   t, it1_1, it1_2, it2_1, it2_2

windows = { ...
    {'Transient 1', data.it1_1, data.it1_2}, ...
    {'Transient 2', data.it2_1, data.it2_2}};

for w = 1:numel(windows)
    label = windows{w}{1};
    ia    = windows{w}{2};
    ib    = windows{w}{3};
    fprintf('\n%s', label)
    for i = 1:data.simulations
        fprintf('\n%s controller', data.controller(i))
        print_window( ...
            e_cuad(data.x_ref(ia:ib),   data.x(ia:ib,i)), ...
            e_cuad(data.y_ref(ia:ib),   data.y(ia:ib,i)), ...
            e_cuad(data.z_ref(ia:ib),   data.z(ia:ib,i)), ...
            e_cuad(data.psi_ref(ia:ib), data.psi(ia:ib,i)), ...
            controlEnergy(data.t(ia:ib), data.u(ia:ib,i)), ...
            controlEnergy(data.t(ia:ib), data.tau_phi(ia:ib,i)), ...
            controlEnergy(data.t(ia:ib), data.tau_theta(ia:ib,i)), ...
            controlEnergy(data.t(ia:ib), data.tau_psi(ia:ib,i)))
    end
end

fprintf('\nTOTAL VALUES')
for i = 1:data.simulations
    fprintf('\n%s controller', data.controller(i))
    print_window( ...
        e_cuad(data.x_ref,   data.x(:,i)), ...
        e_cuad(data.y_ref,   data.y(:,i)), ...
        e_cuad(data.z_ref,   data.z(:,i)), ...
        e_cuad(data.psi_ref, data.psi(:,i)), ...
        controlEnergy(data.t, data.u(:,i)), ...
        controlEnergy(data.t, data.tau_phi(:,i)), ...
        controlEnergy(data.t, data.tau_theta(:,i)), ...
        controlEnergy(data.t, data.tau_psi(:,i)))
end
end

function print_window(ex, ey, ez, epsi, eu, etphi, ettheta, etpsi)
disp(' ')
fprintf('   Error X = %.6f\n',         ex)
fprintf('   Error Y = %.6f\n',         ey)
fprintf('   Error Z = %.6f\n',         ez)
fprintf('   Error Psi = %.6f\n',       epsi)
fprintf('\n   Energy u = %.6f\n',         eu)
fprintf('   Energy tau_phi = %.6f\n',    etphi)
fprintf('   Energy tau_theta = %.6f\n',  ettheta)
fprintf('   Energy tau_psi = %.6f\n',    etpsi)
end

function e2 = e_cuad(q1, q2)
N  = length(q1);
e2 = diag((q1 - q2)' * (q1 - q2)) / N;
end

function total_area = controlEnergy(x, y)
total_area = trapz(x, abs(y));
end
