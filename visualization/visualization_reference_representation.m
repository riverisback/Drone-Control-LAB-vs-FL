function visualization_reference_representation(data)
% Visualizacion de la trayectoria de referencia.

figure
subplot(411)
plot(data.t,data.x_ref,'k',linewidth=2);grid on;hold on
plot(data.t(1),data.x_ref(1),'ob',linewidth=2)
plot(data.t(length(data.t1)),data.x_ref(length(data.t1)),'og',linewidth=2)
plot(data.t(end),data.x_ref(end),'or',linewidth=2)
title('References')
xlabel('Time [s]')
ylabel('X ref')

subplot(412)
plot(data.t,data.y_ref,'k',linewidth=2);grid on;hold on
plot(data.t(1),data.y_ref(1),'ob',linewidth=2)
plot(data.t(length(data.t1)),data.y_ref(length(data.t1)),'og',linewidth=2)
plot(data.t(end),data.y_ref(end),'or',linewidth=2)
xlabel('Time [s]')
ylabel('Y ref')

subplot(413)
plot(data.t,data.z_ref,'k',linewidth=2);grid on;hold on
plot(data.t(1),data.z_ref(1),'ob',linewidth=2)
plot(data.t(length(data.t1)),data.z_ref(length(data.t1)),'og',linewidth=2)
plot(data.t(end),data.z_ref(end),'or',linewidth=2)
xlabel('Time [s]')
ylabel('Z ref')

subplot(414)
plot(data.t,data.psi_ref,'k',linewidth=2);grid on;hold on
plot(data.t(1),data.psi_ref(1),'ob',linewidth=2)
plot(data.t(length(data.t1)),data.psi_ref(length(data.t1)),'og',linewidth=2)
plot(data.t(end),data.psi_ref(end),'or',linewidth=2)
xlabel('Time [s]')
ylabel('psi ref')

figure
plot3(data.x_ref,data.y_ref,data.z_ref,'k',linewidth=2);grid on;hold on
plot3(data.x_ref(1),data.y_ref(1),data.z_ref(1),'ob',linewidth=2)
plot3(data.x_ref(end),data.y_ref(end),data.z_ref(end),'or',linewidth=2)
xlabel('X axis')
ylabel('Y axis')
zlabel('Z axis')
title('3D references')
if data.tray == 1
    plot3(data.x_ref(length(data.t1)),data.y_ref(length(data.t1)),data.z_ref(length(data.t1)),'og',linewidth=2)
    legend('Reference', 'Initial point','Final point','Transition point')
else
    legend('Reference', 'Initial point','Final point')
end
end