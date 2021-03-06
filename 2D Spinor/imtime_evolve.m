function phi_up = imtime_evolve(phi, potential, Deltat, V0,k_scale,X,Y, Nx,Ny, deltax,deltay,deltafx,deltafy,c0,paritx,parity,dispersion)

mat_pot = potential(X,Y) + V0.*sin(k_scale.*X).^2;
mat_nonlin_pot = c0*phi.*conj(phi);

diag_pot = -Deltat*(mat_pot + mat_nonlin_pot);

exp_pot = exp(diag_pot);

phi_up = exp_pot.*phi;


disper = dispersion(:,:,1);
evol = exp(disper.*Deltat);

fourier_phi = fourier_transform2(phi_up,deltax,deltay);

fourier_phi_evo = evol.*fourier_phi;

phi_up = inverse_ft2(fourier_phi_evo,deltafx,deltafy,Nx,Ny);

phi_up = phi_up/norm2d(phi_up, Nx, Ny, deltax,deltay);
end


