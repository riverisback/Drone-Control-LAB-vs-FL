function project_config = build_project_config(Ts)

project_config = struct();

% La trayectoria depende del periodo de muestreo usado en la simulacion.
if Ts == 0.02
    project_config.tray = 1;

    end_time1 = 40;
    end_time2 = 40;
    project_config.end_time = end_time1 + end_time2;

    project_config.t1 = (0:Ts:end_time1)';
    project_config.t2 = (0:Ts:end_time2)';
    project_config.t = (0:Ts:end_time1 + end_time2 + Ts)';
    project_config.iters = project_config.end_time / Ts + 1;

    R = 2;
    vz1 = 0.05;
    omega = 0.3;

    project_config.x_ini = 2;
    project_config.y_ini = 0;
    project_config.z_ini = 0;

    x1 = 1 + R * cos(project_config.t1 * omega + pi / 2);
    dx1 = -omega * R * sin(project_config.t1 * omega + pi / 2);

    y1 = 5 + R * sin(project_config.t1 * omega - pi / 2);
    dy1 = omega * R * cos(project_config.t1 * omega - pi / 2);

    z1 = project_config.z_ini + vz1 * project_config.t1;
    dz1 = vz1 * ones(length(project_config.t1), 1);

    psi1 = omega * project_config.t1;
    dpsi1 = omega * ones(length(project_config.t1), 1);

    vz2 = -z1(end) / end_time2;

    z2 = z1(end) + vz2 * project_config.t2;
    dz2 = vz2 * ones(length(project_config.t2), 1);

    x2 = x1(end) * ones(length(project_config.t2), 1);
    y2 = y1(end) * ones(length(project_config.t2), 1);
    psi2 = psi1(end) * ones(length(project_config.t2), 1);

    dx2 = zeros(length(project_config.t2), 1);
    dy2 = zeros(length(project_config.t2), 1);
    dpsi2 = zeros(length(project_config.t2), 1);

    project_config.x_ref = [x1; x2];
    project_config.y_ref = [y1; y2];
    project_config.z_ref = [z1; z2];
    project_config.psi_ref = [psi1; psi2];

    project_config.dx_ref = [dx1; dx2];
    project_config.dy_ref = [dy1; dy2];
    project_config.dz_ref = [dz1; dz2];
    project_config.dpsi_ref = [dpsi1; dpsi2];

elseif Ts == 0.01
    project_config.tray = 2;

    % La referencia externa se carga desde la carpeta data del proyecto.
    config_dir = fileparts(mfilename('fullpath'));
    loaded_data = load(fullfile(config_dir, '..', 'data', 'referencia_externa.mat'), 'waypoints');
    waypoints = loaded_data.waypoints;

    project_config.t = waypoints(:, 9);
    project_config.iters = length(project_config.t);
    project_config.end_time = project_config.t(end);

    project_config.x_ref = waypoints(:, 1);
    project_config.y_ref = waypoints(:, 2);
    project_config.z_ref = waypoints(:, 3);
    project_config.psi_ref = waypoints(:, 4);

    project_config.dx_ref = waypoints(:, 5);
    project_config.dy_ref = waypoints(:, 6);
    project_config.dz_ref = waypoints(:, 7);
    project_config.dpsi_ref = waypoints(:, 8);

    project_config.x_ini = 0;
    project_config.y_ini = 0;
    project_config.z_ini = 0;

else
    error('Unsupported Ts value: %.3f. Use 0.02 or 0.01.', Ts);
end

end