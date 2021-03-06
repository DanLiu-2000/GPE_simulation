Deltat = 1e-9;
Stop_crit = 1e-9;



potential = @(x,y,z)(1/2*x.^2 + 1/2*y.^2 + 1/2*z.^2);


init_spin = [1 0 0];
phi_0 = Thomas_fermi3D(c0,potential(X,Y,Z));
phi = phi_0;

fftNx = Nx -1;
fftNy = Ny -1;
fftNz = Nz -1;

fftphi = phi(1:fftNx,1:fftNy,1:fftNy);
fftX = X(1:fftNy,1:fftNx,1:fftNz);
fftY = Y(1:fftNy,1:fftNx,1:fftNz);
fftZ = Z(1:fftNy,1:fftNx,1:fftNz);
fftL = Lx - deltax;
fftfx = fx(1:fftNx);

difference = 1;
evo = 200;
n = 0;
while (difference)
    %phi_up = strang_evolve(phi, potential,Deltat,X,Beta,Nx,deltax,deltaf,L );
    phi_up = imtime_evolve(fftphi, potential, Deltat, fftX,fftY,fftY, fftNx,fftNy,fftNz,deltax,deltay,deltaz,deltafx,deltafy,deltafz,c0,paritx(1:fftNx,1:fftNy,1:fftNz,:),parity(1:fftNx,1:fftNy,1:fftNz,:),paritz(1:fftNx,1:fftNy,1:fftNz,:),dispersion);
    if (max(abs(phi_up(:)-fftphi(:))) < Stop_crit)
        difference = 0;
    end
    
    if (mod(n,evo) == 0)
        max(abs(phi_up(:)-fftphi(:)))
%         chem_pot(phi,X,Nx,Beta,k_scale,deltax,deltaf,V,L)
    end
    fftphi = phi_up;
    n = n + 1;
    
end
phi_up = zeros(Nx,Ny,Nz);
phi_up(1:fftNx,1:fftNy,1:fftNz) = fftphi;
phi_up(:,Nx,:) = phi_up(:,1,:);
phi_up(Ny,:,:) = phi_up(1,:,:);
phi_up(:,:,Nz) = phi_up(:,:,1);
r1 = randn(Nx,Ny) + 1i*randn(Nx,Ny);
r1 = r1/norm2d(r1,Nx,Ny,deltax,deltay);
r2 = r1 - integr2d(conj(phi_up).*r1,Nx,Ny,deltax,deltay).*phi_up;
phi_up = phi_up + 0.3*r2;



phi_0(:,:,:,2) = init_spin(2).*phi_up;
phi_0(:,:,:,3) = init_spin(3).*phi_up;
phi_0(:,:,:,1) = init_spin(1).*phi_up;

phi_0 = phi_0./norm3d(phi_0,Nx, Ny, Nz,deltax,deltay,deltaz);




