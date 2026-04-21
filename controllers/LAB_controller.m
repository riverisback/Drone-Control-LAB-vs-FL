function U = LAB_controller(X)
    global Ts g M i x_ref y_ref z_ref psi_ref
    global k_1 k_2 k_3 k_4 k_5 k_6 k_7 k_8 k_9 k_10 k_11 k_12
    global x2r0 x4r0 x6r0 x7r0 x8r0 x9r0 x10r0 x12r0 aprox

    % Referencias globales de posicion y guiñada.
    x1_ref = x_ref;
    x3_ref = y_ref;
    x5_ref = z_ref;
    x11_ref = psi_ref;
    
    % Estado actual del sistema.
    x1 = X(1);   % x
    x2 = X(2);   % x_dot
    x3 = X(3);   % y
    x4 = X(4);   % y_dot
    x5 = X(5);   % z
    x6 = X(6);   % z_dot
    x7 = X(7);   % phi
    x8 = X(8);   % phi_dot
    x9 = X(9);   % theta
    x10 = X(10); % theta_dot
    x11 = X(11); % psi
    x12 = X(12); % psi_dot
        
    
    % Error de posicion y orientacion.
    e1 = x1_ref(i)-x1;
    e3 = x3_ref(i)-x3;
    e5 = x5_ref(i)-x5;
    e11 = x11_ref(i)-x11;
    
    % Referencias intermedias de las variables sacrificadas.
    x2_ref_n = (x1_ref(i+1)-k_1*e1-x1)/Ts;
    x4_ref_n = (x3_ref(i+1)-k_3*e3-x3)/Ts;
    x6_ref_n = (x5_ref(i+1)-k_5*e5-x5)/Ts;
    x12_ref_n = (x11_ref(i+1)-k_11*e11-x11)/Ts;
    
    % Aproximacion de un paso para las referencias intermedias.
    if aprox==1
        x2_ref_n1 = x2_ref_n;
        x4_ref_n1 = x4_ref_n;
        x6_ref_n1 = x6_ref_n;
        x12_ref_n1 = x12_ref_n;
    elseif aprox==2
        x2_ref_n1 = 2*x2_ref_n-x2r0;
        x4_ref_n1 = 2*x4_ref_n-x4r0;
        x6_ref_n1 = 2*x6_ref_n-x6r0;
        x12_ref_n1 = 2*x12_ref_n-x12r0;
    end
    
    delta_x2 = x2_ref_n1-k_2*(x2_ref_n-x2)-x2;
    delta_x4 = x4_ref_n1-k_4*(x4_ref_n-x4)-x4;
    delta_x6 = x6_ref_n1-k_6*(x6_ref_n-x6)-x6;
    delta_x12 = x12_ref_n1-k_12*(x12_ref_n-x12)-x12;
    
    if delta_x4==0
        delta_x4=0.0000001;
    end
    
    x7_ref_n = atan(delta_x4/(delta_x6+g*Ts));
    x9_ref_n = atan(-1*delta_x2/delta_x4*sin(x7_ref_n));
    
    if aprox==1
        x7_ref_n1 = x7_ref_n;
        x9_ref_n1 = x9_ref_n;
    elseif aprox==2
        x7_ref_n1 = 2*x7_ref_n-x7r0;
        x9_ref_n1 = 2*x9_ref_n-x9r0;
    end
    
    x8_ref_n = (x7_ref_n1-k_7*(x7_ref_n-x7)-x7)/Ts;
    x10_ref_n = (x9_ref_n1-k_9*(x9_ref_n-x9)-x9)/Ts;
    
    if aprox==1
        x8_ref_n1 = x8_ref_n;
        x10_ref_n1 = x10_ref_n;
    elseif aprox==2
        x8_ref_n1 = 2*x8_ref_n-x8r0;
        x10_ref_n1 = 2*x10_ref_n-x10r0;
    end
    
    delta_x8 = x8_ref_n1-k_8*(x8_ref_n-x8)-x8;
    delta_x10 = x10_ref_n1-k_10*(x10_ref_n-x10)-x10;
    
    u1 = -delta_x2*sin(x9_ref_n);
    u2 = delta_x4*cos(x9_ref_n)*sin(x7_ref_n);
    u3 = (delta_x6+g*Ts)*cos(x9_ref_n)*cos(x7_ref_n);
    u = M/Ts*(u1+u2+u3);
    
    tau_phi = delta_x8/Ts;
    tau_theta = delta_x10/Ts;
    tau_psi = delta_x12/Ts;
    
    U = [u tau_phi tau_theta tau_psi];
    
    i=i+1;
    
    % Guardado del estado para la siguiente iteracion.
    x2r0 = x2_ref_n;
    x4r0 = x4_ref_n;
    x6r0 = x6_ref_n;
    x7r0 = x7_ref_n;
    x8r0 = x8_ref_n;
    x9r0 = x9_ref_n;
    x10r0 = x10_ref_n;
    x12r0 = x12_ref_n;

end