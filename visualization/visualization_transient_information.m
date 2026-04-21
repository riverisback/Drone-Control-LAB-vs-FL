function visualization_transient_information(data)
% Resumen grafico de los dos transitorios de interes.

if data.simulations == 2
    % Positions
    figure
    subplot(311)
    plot(data.tsim(data.it1_1:data.it1_2,1),data.x(data.it1_1:data.it1_2,1),linewidth=2);hold on;grid on
    plot(data.tsim(data.it1_1:data.it1_2,2),data.x(data.it1_1:data.it1_2,2),linewidth=2)
    plot(data.tsim(data.it1_1:data.it1_2,1),data.x_ref(data.it1_1:data.it1_2),'--k')
    ylabel('X position')
    xlabel('Time [s]')
    xlim([data.t1_1;data.t1_2])
    title("Positions")
    legend(data.controller(1)+" controller",data.controller(2)+" controller",'Reference')

    subplot(312)
    plot(data.tsim(data.it1_1:data.it1_2,1),data.y(data.it1_1:data.it1_2,1),linewidth=2);hold on;grid on
    plot(data.tsim(data.it1_1:data.it1_2,2),data.y(data.it1_1:data.it1_2,2),linewidth=2)
    plot(data.tsim(data.it1_1:data.it1_2,1),data.y_ref(data.it1_1:data.it1_2),'--k')
    xlabel('Time [s]')
    xlim([data.t1_1;data.t1_2])
    ylabel('Y position')
    legend(data.controller(1)+" controller",data.controller(2)+" controller",'Reference')

    subplot(313)
    plot(data.tsim(data.it1_1:data.it1_2,1),data.z(data.it1_1:data.it1_2,1),linewidth=2);hold on;grid on
    plot(data.tsim(data.it1_1:data.it1_2,2),data.z(data.it1_1:data.it1_2,2),linewidth=2)
    plot(data.tsim(data.it1_1:data.it1_2,1),data.z_ref(data.it1_1:data.it1_2),'--k')
    xlabel('Time [s]')
    xlim([data.t1_1;data.t1_2])
    ylabel('Z position')
    legend(data.controller(1)+" controller",data.controller(2)+" controller",'Reference')

    figure
    subplot(311)
    plot(data.tsim(data.it2_1:data.it2_2,1),data.x(data.it2_1:data.it2_2,1),linewidth=2);hold on;grid on
    plot(data.tsim(data.it2_1:data.it2_2,2),data.x(data.it2_1:data.it2_2,2),linewidth=2)
    plot(data.tsim(data.it2_1:data.it2_2,1),data.x_ref(data.it2_1:data.it2_2),'--k')
    ylabel('X position')
    xlabel('Time [s]')
    xlim([data.t2_1;data.t2_2])
    title("Positions")
    legend(data.controller(1)+" controller",data.controller(2)+" controller",'Reference')

    subplot(312)
    plot(data.tsim(data.it2_1:data.it2_2,1),data.y(data.it2_1:data.it2_2,1),linewidth=2);hold on;grid on
    plot(data.tsim(data.it2_1:data.it2_2,2),data.y(data.it2_1:data.it2_2,2),linewidth=2)
    plot(data.tsim(data.it2_1:data.it2_2,1),data.y_ref(data.it2_1:data.it2_2),'--k')
    xlabel('Time [s]')
    xlim([data.t2_1;data.t2_2])
    ylabel('Y position')
    legend(data.controller(1)+" controller",data.controller(2)+" controller",'Reference')

    subplot(313)
    plot(data.tsim(data.it2_1:data.it2_2,1),data.z(data.it2_1:data.it2_2,1),linewidth=2);hold on;grid on
    plot(data.tsim(data.it2_1:data.it2_2,2),data.z(data.it2_1:data.it2_2,2),linewidth=2);hold on;grid on
    plot(data.tsim(data.it2_1:data.it2_2,1),data.z_ref(data.it2_1:data.it2_2),'--k')
    xlabel('Time [s]')
    xlim([data.t2_1;data.t2_2])
    ylabel('Z position')
    legend(data.controller(1)+" controller",data.controller(2)+" controller",'Reference')

    % Control inputs
    figure
    subplot(411)
    plot(data.tsim(data.it1_1:data.it1_2,1),data.u(data.it1_1:data.it1_2,1),linewidth=2);grid on;hold on
    plot(data.tsim(data.it1_1:data.it1_2,2),data.u(data.it1_1:data.it1_2,2),linewidth=2)
    title("Control Inputs")
    xlabel('Time [s]')
    xlim([data.t1_1;data.t1_2])
    ylabel('u')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(412)
    plot(data.tsim(data.it1_1:data.it1_2,1),data.tau_phi(data.it1_1:data.it1_2,1),linewidth=2);grid on;hold on
    plot(data.tsim(data.it1_1:data.it1_2,2),data.tau_phi(data.it1_1:data.it1_2,2),linewidth=2)
    xlabel('Time [s]')
    xlim([data.t1_1;data.t1_2])
    ylabel('tau_{phi}')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(413)
    plot(data.tsim(data.it1_1:data.it1_2,1),data.tau_theta(data.it1_1:data.it1_2,1),linewidth=2);grid on; hold on
    plot(data.tsim(data.it1_1:data.it1_2,2),data.tau_theta(data.it1_1:data.it1_2,2),linewidth=2)
    xlabel('Time [s]')
    xlim([data.t1_1;data.t1_2])
    ylabel('tau_{theta}')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(414)
    plot(data.tsim(data.it1_1:data.it1_2,1),data.tau_psi(data.it1_1:data.it1_2,1),linewidth=2);grid on; hold on
    plot(data.tsim(data.it1_1:data.it1_2,2),data.tau_psi(data.it1_1:data.it1_2,2),linewidth=2)
    xlabel('Time [s]')
    xlim([data.t1_1;data.t1_2])
    ylabel('tau_{psi}')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    figure
    subplot(411)
    plot(data.tsim(data.it2_1:data.it2_2,1),data.u(data.it2_1:data.it2_2,1),linewidth=2);grid on;hold on
    plot(data.tsim(data.it2_1:data.it2_2,2),data.u(data.it2_1:data.it2_2,2),linewidth=2)
    title("Control Inputs")
    xlabel('Time [s]')
    xlim([data.t2_1;data.t2_2])
    ylabel('u')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(412)
    plot(data.tsim(data.it2_1:data.it2_2,1),data.tau_phi(data.it2_1:data.it2_2,1),linewidth=2);grid on;hold on
    plot(data.tsim(data.it2_1:data.it2_2,2),data.tau_phi(data.it2_1:data.it2_2,2),linewidth=2)
    xlabel('Time [s]')
    xlim([data.t2_1;data.t2_2])
    ylabel('tau_{phi}')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(413)
    plot(data.tsim(data.it2_1:data.it2_2,1),data.tau_theta(data.it2_1:data.it2_2,1),linewidth=2);grid on; hold on
    plot(data.tsim(data.it2_1:data.it2_2,2),data.tau_theta(data.it2_1:data.it2_2,2),linewidth=2)
    xlabel('Time [s]')
    xlim([data.t2_1;data.t2_2])
    ylabel('tau_{theta}')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(414)
    plot(data.tsim(data.it2_1:data.it2_2,1),data.tau_psi(data.it2_1:data.it2_2,1),linewidth=2);grid on; hold on
    plot(data.tsim(data.it2_1:data.it2_2,2),data.tau_psi(data.it2_1:data.it2_2,2),linewidth=2)
    xlabel('Time [s]')
    xlim([data.t2_1;data.t2_2])
    ylabel('tau_{psi}')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    % 3D Representation
    figure
    plot3(data.x_ref(data.it1_1:data.it1_2),data.y_ref(data.it1_1:data.it1_2),data.z_ref(data.it1_1:data.it1_2),'--k');hold on;grid on
    x1 = data.x(data.it1_1:data.it1_2,1);
    y1 = data.y(data.it1_1:data.it1_2,1);
    z1 = data.z(data.it1_1:data.it1_2,1);
    x2 = data.x(data.it1_1:data.it1_2,2);
    y2 = data.y(data.it1_1:data.it1_2,2);
    z2 = data.z(data.it1_1:data.it1_2,2);
    plot3(x1,y1,z1,'b',linewidth=2)
    plot3(x2,y2,z2,'r',linewidth=2)
    xlabel('X axis')
    ylabel('Y axis')
    zlabel('Z axis')
    title("Trajectory")
    legend("Reference",data.controller(1)+" controller",data.controller(2)+" controller")

    figure
    plot3(data.x_ref(data.it2_1:data.it2_2),data.y_ref(data.it2_1:data.it2_2),data.z_ref(data.it2_1:data.it2_2),'--k');hold on;grid on
    x1 = data.x(data.it2_1:data.it2_2,1);
    y1 = data.y(data.it2_1:data.it2_2,1);
    z1 = data.z(data.it2_1:data.it2_2,1);
    x2 = data.x(data.it2_1:data.it2_2,2);
    y2 = data.y(data.it2_1:data.it2_2,2);
    z2 = data.z(data.it2_1:data.it2_2,2);
    plot3(x1,y1,z1,'b',linewidth=2)
    plot3(x2,y2,z2,'r',linewidth=2)
    xlabel('X axis')
    ylabel('Y axis')
    zlabel('Z axis')
    title("Trajectory")
    legend("Reference",data.controller(1)+" controller",data.controller(2)+" controller")
end
end