Deltat = 1e-9;
Stop_crit = 1e-9;



potential = @(x)(1/2*x.^2);


init_spin = [1 0 0];
phi_0 = Thomas_fermi1D(c0,X,TF_radius,potential(X),Nx,deltax);
phi = phi_0;
diff = 1;
evo = 200;
n = 0;





while (diff)
    fftNx = Nx -1;
    fftphi = phi(1:fftNx);
    fftX = X(1:fftNx);
    fftL = L - deltax;
    fftf = f(1:fftNx);
    %phi_up = strang_evolve(phi, potential,Deltat,X,Beta,Nx,deltax,deltaf,L );
    phi_up = time_evolve_ground(fftphi, potential,Deltat,fftX,fftNx,deltax,deltaf,fftL,c0);
    difference = max(abs(phi_up-fftphi))
    if (difference < Stop_crit)
        diff = 0;
    end
    
%     if (mod(n,evo) == 0)
%         max(abs(phi_up-phi))
%         chem_pot(phi,X,Nx,c0,k_scale,deltax,deltaf,V,L)
%     end
    fftphi = phi_up;
    n = n + 1;
    phi(1:fftNx) = fftphi;
    phi(Nx) = phi(1);
    
end



phi_0 = [init_spin(1).*phi;init_spin(2).*phi;init_spin(3).*phi];




