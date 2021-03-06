function phi_up = time_evolve(phi, potential, speckle,Deltat, X, Nx, deltax,deltaf,L,c0,c2,eigens,MatB,MatV,detuning)

density = sq(phi);
tot_density = sum(density,1);

p = potential(X) + speckle;
pot = [p;p;p];

nonlin_pot = zeros(3,Nx);
nonlin_pot(1,:) = c0.*tot_density + c2.*(density(1,:) + density(2,:) - density(3,:));
nonlin_pot(2,:) = c0.*tot_density + c2.*(density(1,:) + density(3,:)) + detuning;
%nonlin_pot(3,:) = c0.*tot_density + c2.*(density(3,:) + density(2,:) - density(1,:)) - 500*detuning;



diag_pot = -Deltat.*(pot + nonlin_pot);

exp_pot = exp(diag_pot);

phi_up = exp_pot.*phi;

if(mod(Nx,2) ~= 0)
    lin_n =  (0:1:Nx-1) - (Nx-1)/2;
else
    N = Nx + 1;
    lin_n = (0:1:N-1) - (N-1)/2;
    lin_n = lin_n(1:Nx);
end
dispersion = -(2*pi/L*lin_n).^2 *Deltat/2;
evol = exp(dispersion);

fourier_phi = zeros(3,Nx);
fourier_phi(1,:) = fourier_transform(phi_up(1,:),Nx,deltax);
fourier_phi(2,:) = fourier_transform(phi_up(2,:),Nx,deltax);
%fourier_phi(3,:) = fourier_transform(phi_up(3,:),Nx,deltax);

fourier_phi_evo = [evol.*fourier_phi(1,:);evol.*fourier_phi(2,:);evol.*fourier_phi(3,:)];

phi_up(1,:) = inverse_ft(fourier_phi_evo(1,:),Nx,deltaf);
phi_up(2,:) = inverse_ft(fourier_phi_evo(2,:),Nx,deltaf);
%phi_up(3,:) = inverse_ft(fourier_phi_evo(3,:),Nx,deltaf);

phi_up = phi_up/norm1d(phi_up, Nx, deltax);



% for i = 1:Nx
%     phi_up(:,i) = MatV(:,:,i)*(exp(-eigens(:,i).*Deltat).*(MatB(:,:,i)*phi_up(:,i)));
% end

temp = zeros(3,Nx);

for i=1:3
	temp(i,:) = sum(reshape(MatB(i,:,:),[3,Nx]).*phi_up).*exp(-eigens(i,:).*Deltat);
end

for i=1:2
	phi_up(i,:) = sum(reshape(MatV(i,:,:),[3,Nx]).*temp);
end




phi_up = phi_up/norm1d(phi_up, Nx, deltax);

end



