function U = FL_controller(X)
    global i

    % Variables auxiliares del modelo dinamico linealizado.
    v1 = X(1);
    v2 = X(2);
    v3 = X(3);
    v4 = X(4);
    
    fx = X(5);
    fy = X(6);
    fz = X(7);
    
    v_f = [v1-fx v2-fy v3-fz v4];
    
    % Entrada de control disponible en este instante.
    u1 = X(8);
    
    % Variables de actitud necesarias para la matriz de desacoplo.
    phi   = X(15);
    theta = X(17);  
    
    % Funciones g de cada canal de control.
    gxu1 = -sin(theta);
    gxu2 = 0;
    gxu3 = -cos(theta)*u1;
    gxu4 = 0;
    
    gyu1 = cos(theta)*sin(phi);
    gyu2 = cos(theta)*cos(phi)*u1;
    gyu3 = -sin(theta)*sin(phi)*u1;
    gyu4 = 0;
    
    gzu1 = cos(theta)*cos(phi);
    gzu2 = -sin(phi)*cos(theta)*u1;
    gzu3 = -sin(theta)*cos(phi)*u1;
    gzu4 = 0;

    % Matriz de acoplamiento.
    G = [gxu1 gxu2 gxu3 gxu4;
         gyu1 gyu2 gyu3 gyu4;
         gzu1 gzu2 gzu3 gzu4;
         0    0    0      1];
    
    U = G\v_f';
    
    i=i+1;
end