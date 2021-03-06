function phi_up = time_evolve(phi, potential, Deltat, X,Y, Nx,Ny, deltax,deltay,deltafx,deltafy,c0,c2,Omega,k_scale,paritx,parity,dispersion,detuning)

density = sq(phi);

tot_density = sum(density,3);
pot = potential(X,Y);
pot(:,:,2) = potential(X,Y);
pot(:,:,3) = potential(X,Y);
nonlin_pot = zeros(Nx,Ny,3);
nonlin_pot(:,:,1) = c0.*tot_density + c2.*(density(:,:,1) + density(:,:,2) - density(:,:,3));
nonlin_pot(:,:,2) = c0.*tot_density + c2.*(density(:,:,1) + density(:,:,3))- 212.6956;
nonlin_pot(:,:,3) = c0.*tot_density + c2.*(density(:,:,3) + density(:,:,2) - density(:,:,1)) - 212.6956- detuning;



diag_pot = -Deltat.*(pot + nonlin_pot);

exp_pot = exp(diag_pot);

phi_up = exp_pot.*phi;

%phi_up = phi;

fourier_phi = fourier_transform2(phi_up,deltax,deltay);

fourier_phi_evo = exp(dispersion.*Deltat).*fourier_phi;

phi_up = inverse_ft2(fourier_phi_evo,deltafx,deltafy,Nx,Ny);

phi_up = phi_up/norm2d(phi_up, Nx,Ny, deltax,deltay);

CA = -Omega*exp(-1i*2*k_scale*X) + c2*phi_up(:,:,2).*conj(phi_up(:,:,3));%coupling between 1 and 0
CC = -Omega*exp(-1i*2*k_scale*X) + c2*phi_up(:,:,1).*conj(phi_up(:,:,2));%coupling between -1 and 0

CAr = reshape(CA,[1,Nx^2]);
CCr = reshape(CC,[1,Nx^2]);

MatV = -CCr./((sqrt(1+sq(CCr)./sq(CAr))).*conj(CAr));
MatV(2,:) = zeros(1,Nx^2);
MatV(3,:) = 1./sqrt(1 + sq(CCr)./sq(CAr));
MatV(1,:,2) = CAr./(sqrt(2*(sq(CAr) + sq(CCr))./sq(CCr)).*conj(CCr));
MatV(2,:,2) = -sqrt(sq(CCr))./(sqrt(2).*conj(CCr));
MatV(3,:,2) = sqrt(sq(CCr))./sqrt(2.*(sq(CAr)+sq(CCr)));
MatV(1,:,3) = CAr./(sqrt(2*(sq(CAr) + sq(CCr))./sq(CCr)).*conj(CCr));
MatV(2,:,3) = sqrt(sq(CCr))./(sqrt(2).*conj(CCr));
MatV(3,:,3) = sqrt(sq(CCr))./sqrt(2.*(sq(CAr)+sq(CCr)));

MatV = permute(MatV,[1,3,2]);
MatB = permute(MatV,[2,1,3]);
MatB = conj(MatB);

eigens = zeros(3,Nx^2);
eigens(1,:) = zeros(1,Nx^2);
eigens(2,:) = -sqrt(sq(CAr) + sq(CCr));
eigens(3,:) = sqrt(sq(CAr) + sq(CCr));

phi_upr = reshape(phi_up,[Nx^2,3]);
phi_upr = phi_upr';

for i = 1:Nx^2
    phi_upr(:,i) = MatV(:,:,i)*(exp(-eigens(:,i).*Deltat).*(MatB(:,:,i)*phi_upr(:,i)));
end

phi_upr = phi_upr';
phi_up = reshape(phi_upr,[Nx,Nx,3]);
phi_up = phi_up./norm2d(phi_up, Nx,Ny, deltax,deltay);

end




