function visualization_tridimensional_representation(data)
% Animacion 3D de trayectoria y orientacion.

for j = 1:2
    fh = figure;
    ax = axes(fh);
    ax.DataAspectRatio = [1 1 1];
    view(ax, 3)
    hold(ax, 'on')
    grid(ax, 'on')
    xlabel(ax, 'Eje X')
    ylabel(ax, 'Eje Y')
    zlabel(ax, 'Eje Z')
    title(ax, "Controlador " + data.controller(j))

    margin = 0.5;
    xlim(ax, [min([data.x_ref; data.x(:,j)]) - margin, max([data.x_ref; data.x(:,j)]) + margin])
    ylim(ax, [min([data.y_ref; data.y(:,j)]) - margin, max([data.y_ref; data.y(:,j)]) + margin])
    zlim(ax, [min([data.z_ref; data.z(:,j)]) - margin, max([data.z_ref; data.z(:,j)]) + margin])
    ax.XLimMode = 'manual';
    ax.YLimMode = 'manual';
    ax.ZLimMode = 'manual';

    plot3(ax, data.x_ref, data.y_ref, data.z_ref, '--k')
    drawnow

    range = size(data.tsim, 1);
    step  = 5;
    ref0  = [0.5 0 0];

    h_orient = [];
    for i = 1:step:range
        if i > 1
            angle = data.psi(i,j) - data.psi(i-step,j);
        else
            angle = data.psi(i,j);
        end
        ref = vector_rotation(ref0, angle);
        ov  = [data.x(i,j) data.y(i,j) data.z(i,j)] + ref;

        if ~isempty(h_orient)
            delete(h_orient)
        end
        h_orient = plot3(ax, [ov(1) data.x(i,j)], ...
                             [ov(2) data.y(i,j)], ...
                             [ov(3) data.z(i,j)], '.-r', linewidth=0.5);
        if i > 1
            plot3(ax, data.x(i-step:i,j), data.y(i-step:i,j), data.z(i-step:i,j), '-b', linewidth=4)
        else
            plot3(ax, data.x(i,j), data.y(i,j), data.z(i,j), '-b')
        end
        ref0 = ref;
        drawnow limitrate
    end
end
end

function v_fin = vector_rotation(v_ini, alpha)
M = [cos(alpha) -sin(alpha) 0;
     sin(alpha)  cos(alpha) 0;
     0           0          1];
if numel(v_ini) < 3
    v     = [v_ini 0] * M;
    v_fin = v(1:2);
else
    v_fin = v_ini * M;
end
end