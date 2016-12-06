Deltat = 1e-7;
Stop_time = 0.0057;

Beta = 3000; 
TF_radius = (3*Beta/2)^(1/3);
xmin = -TF_radius;
xmax = TF_radius;

Nx = 2^11+1;




lattice_pot = 4*E_r;
V = lattice_pot/quanta;
DeltaX = (xmax-xmin)/(Nx-1);
k_scale = k*a_0;
k_spacing = k_scale*(xmax-xmin)/pi;
potential = @(x)(0/2*x.^2 + V.*sin(k_scale.*x).^2 );


X = linspace(xmin,xmax,Nx);
N_tf = int16(TF_radius/DeltaX);
cutX = X < TF_radius;

t = 0;
fftNx = Nx -1;
fftphi = phi_1(1:fftNx);
fftX = X(1:fftNx);
Deltat = 1i*Deltat;
evo = 20;
n = 0;
while (t < Stop_time)
    fftphi = time_evolve(fftphi, potential,Deltat,fftX,Beta,fftNx,DeltaX);
    t = t - 1i*Deltat;
    n = n + 1;
    
%     if (mod(n,evo)==0)
%         fphi = fourier_transform(phi,Nx);
%         b = fphi.*conj(fphi);
%         plot(f,b);
%         
%     end
    
end
phi_2 = zeros(1,Nx);
phi_2(1:fftNx) = fftphi;
phi_2(Nx) = phi_2(1);