function r = init_result_arrays(iters, simulations)
n = iters - 1;
r.tsim      = zeros(n, simulations);
r.x         = zeros(n, simulations);
r.y         = zeros(n, simulations);
r.z         = zeros(n, simulations);
r.phi       = zeros(n, simulations);
r.theta     = zeros(n, simulations);
r.psi       = zeros(n, simulations);
r.u         = zeros(n, simulations);
r.tau_phi   = zeros(n, simulations);
r.tau_theta = zeros(n, simulations);
r.tau_psi   = zeros(n, simulations);
r.e_x       = zeros(n, simulations);
r.e_y       = zeros(n, simulations);
r.e_z       = zeros(n, simulations);
r.e_psi     = zeros(n, simulations);
end
