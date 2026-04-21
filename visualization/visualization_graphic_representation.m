function visualization_graphic_representation(data)
% Visualizacion completa de controles, estados y errores.

if data.simulations == 1
    figure
    subplot(411);plot(data.tsim,data.u);grid on
    title("Control inputs (controller "+data.controller(1)+")")
    xlabel('Time [s]')
    ylabel('u')
    subplot(412);plot(data.tsim,data.tau_phi);grid on
    xlabel('Time [s]')
    ylabel('tau_{phi}')
    subplot(413);plot(data.tsim,data.tau_theta);grid on
    xlabel('Time [s]')
    ylabel('tau_{theta}')
    subplot(414);plot(data.tsim,data.tau_psi);grid on
    xlabel('Time [s]')
    ylabel('tau_{psi}')

    figure
    subplot(311)
    plot(data.tsim,data.phi);grid on
    title("Angles (controller "+data.controller(1)+")")
    xlabel('Time [s]')
    ylabel('phi')
    subplot(312)
    plot(data.tsim,data.theta);grid on
    xlabel('Time [s]')
    ylabel('theta')
    subplot(313)
    plot(data.tsim,data.psi);grid on;hold on
    plot(data.tsim,data.psi_ref,'--k')
    xlabel('Time [s]')
    ylabel('psi')
    legend('psi','psi_{ref}')

    figure
    subplot(411)
    plot(data.tsim,data.x,'b');hold on;grid on
    plot(data.tsim,data.x_ref,'--k')
    ylabel('X position [m]')
    xlabel('Time [s]')
    title("Position and orientation (controller "+data.controller(1)+")")
    legend('X','X_{ref}')
    subplot(412)
    plot(data.tsim,data.y,'b');hold on;grid on
    plot(data.tsim,data.y_ref,'--k')
    xlabel('Time [s]')
    ylabel('Y position [m]')
    legend('Y','Y_{ref}')
    subplot(413)
    plot(data.tsim,data.z,'b');hold on;grid on
    plot(data.tsim,data.z_ref,'--k')
    xlabel('Time [s]')
    ylabel('Z position [m]')
    legend('Z','Z_{ref}')
    subplot(414)
    plot(data.tsim,data.psi,'b');hold on;grid on
    plot(data.tsim,data.psi_ref,'--k')
    xlabel('Time [s]')
    ylabel('psi angle [rad]')
    legend('psi','psi_{ref}')

    figure
    subplot(411)
    plot(data.tsim,data.e_x,'b');grid on;hold on
    title("Errors (controller "+data.controller(1)+")")
    xlabel('Time [s]')
    ylabel('X error')
    subplot(412)
    plot(data.tsim,data.e_y,'b');grid on;hold on
    xlabel('Time [s]')
    ylabel('Y error')
    subplot(413)
    plot(data.tsim,data.e_z,'b');grid on;hold on
    xlabel('Time [s]')
    ylabel('Z error')
    subplot(414)
    plot(data.tsim,data.e_psi,'b');grid on;hold on
    xlabel('Time [s]')
    ylabel('Psi error')

    figure
    plot3(data.x,data.y,data.z,'LineWidth',2);hold on;grid on
    plot3(data.x_ref,data.y_ref,data.z_ref,'--k')
    plot3(data.x(1),data.y(1),data.z(1),'.r','MarkerSize',15,'LineWidth',2)
    plot3(data.x_ref(1),data.y_ref(1),data.z_ref(1),'.k','MarkerSize',15,'LineWidth',2)
    legend('Trajectory','Reference')
    xlabel('X axis')
    ylabel('Y axis')
    zlabel('Z axis')
    title("Trajectory  (controller "+data.controller(1)+")")

elseif data.simulations == 2
    t_1 = 0;
    t_2 = 80;

    figure
    subplot(411)
    plot(data.tsim(:,1),data.u(:,1),linewidth=2);grid on;hold on
    plot(data.tsim(:,2),data.u(:,2),linewidth=2)
    title("Control Inputs")
    xlabel('Time [s]')
    xlim([t_1;t_2])
    ylabel('u')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(412)
    plot(data.tsim(:,1),data.tau_phi(:,1),linewidth=2);grid on;hold on
    plot(data.tsim(:,2),data.tau_phi(:,2),linewidth=2)
    xlabel('Time [s]')
    xlim([t_1;t_2])
    ylabel('tau_{phi}')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(413)
    plot(data.tsim(:,1),data.tau_theta(:,1),linewidth=2);grid on; hold on
    plot(data.tsim(:,2),data.tau_theta(:,2),linewidth=2)
    xlabel('Time [s]')
    xlim([t_1;t_2])
    ylabel('tau_{theta}')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(414)
    plot(data.tsim(:,1),data.tau_psi(:,1),linewidth=2);grid on; hold on
    plot(data.tsim(:,2),data.tau_psi(:,2),linewidth=2)
    xlabel('Time [s]')
    xlim([t_1;t_2])
    ylabel('tau_{psi}')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    figure
    subplot(211)
    plot(data.tsim(:,1),data.tau_phi(:,1),linewidth=1.5);grid on;hold on
    plot(data.tsim(:,2),data.tau_phi(:,2),linewidth=1.5)
    title("Control inputs (tau_{phi} and tau_{theta} zoom)")
    xlabel('Time [s]')
    ylabel('tau_{phi}')
    ylim([-1e-2;1e-2])
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(212)
    plot(data.tsim(:,1),data.tau_theta(:,1),linewidth=1.5);grid on; hold on
    plot(data.tsim(:,2),data.tau_theta(:,2),linewidth=1.5)
    xlabel('Time [s]')
    ylabel('tau_{theta}')
    ylim([-1e-2;1e-2])
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    figure
    subplot(311)
    plot(data.tsim(:,1),data.phi(:,1),linewidth=2);grid on;hold on
    plot(data.tsim(:,2),data.phi(:,2),linewidth=2)
    title("Angles")
    xlabel('Time [s]')
    ylabel('phi')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(312)
    plot(data.tsim(:,1),data.theta(:,1),linewidth=2);grid on;hold on
    plot(data.tsim(:,2),data.theta(:,2),linewidth=2)
    xlabel('Time [s]')
    ylabel('theta')

    subplot(313)
    plot(data.tsim(:,1),data.psi(:,1),linewidth=2);grid on;hold on
    plot(data.tsim(:,2),data.psi(:,2),linewidth=2)
    plot(data.tsim(:,1),data.psi_ref,'--k')
    xlabel('Time [s]')
    ylabel('psi')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    figure
    subplot(311)
    plot(data.tsim(:,1),data.x(:,1),linewidth=2);hold on;grid on
    plot(data.tsim(:,2),data.x(:,2),linewidth=2)
    plot(data.tsim(:,1),data.x_ref,'--k')
    ylabel('X position')
    xlabel('Time [s]')
    title("Positions")
    legend(data.controller(1)+" controller",data.controller(2)+" controller",'Reference')

    subplot(312)
    plot(data.tsim(:,1),data.y(:,1),linewidth=2);hold on;grid on
    plot(data.tsim(:,2),data.y(:,2),linewidth=2)
    plot(data.tsim(:,1),data.y_ref,'--k')
    xlabel('Time [s]')
    ylabel('Y position')
    legend(data.controller(1)+" controller",data.controller(2)+" controller",'Reference')

    subplot(313)
    plot(data.tsim(:,1),data.z(:,1),linewidth=2);hold on;grid on
    plot(data.tsim(:,2),data.z(:,2),linewidth=2);hold on;grid on
    plot(data.tsim(:,1),data.z_ref,'--k')
    xlabel('Time [s]')
    ylabel('Z position')
    legend(data.controller(1)+" controller",data.controller(2)+" controller",'Reference')

    figure
    subplot(411)
    plot(data.tsim(:,1),data.e_x(:,1),linewidth=2);grid on;hold on
    plot(data.tsim(:,2),data.e_x(:,2),linewidth=2)
    title("Errores (controller "+data.controller(1)+")")
    xlabel('Time [s]')
    ylabel('X error')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(412)
    plot(data.tsim(:,1),data.e_y(:,1),linewidth=2);grid on;hold on
    plot(data.tsim(:,2),data.e_y(:,2),linewidth=2)
    xlabel('Time [s]')
    ylabel('Y error')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(413)
    plot(data.tsim(:,1),data.e_z(:,1),linewidth=2);grid on;hold on
    plot(data.tsim(:,2),data.e_z(:,2),linewidth=2)
    xlabel('Time [s]')
    ylabel('Z error')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    subplot(414)
    plot(data.tsim(:,1),data.e_psi(:,1),linewidth=2);grid on;hold on
    plot(data.tsim(:,2),data.e_psi(:,2),linewidth=2)
    xlabel('Time [s]')
    ylabel('Psi error')
    legend(data.controller(1)+" controller",data.controller(2)+" controller")

    figure
    plot3(data.x_ref,data.y_ref,data.z_ref,'--k');hold on;grid on
    plot3(data.x(:,1),data.y(:,1),data.z(:,1),'b',linewidth=2)
    plot3(data.x(:,2),data.y(:,2),data.z(:,2),'r',linewidth=2)
    xlabel('X axis')
    ylabel('Y axis')
    zlabel('Z axis')
    title("Trajectory")
    legend("Reference",data.controller(1)+" controller",data.controller(2)+" controller")
end
end