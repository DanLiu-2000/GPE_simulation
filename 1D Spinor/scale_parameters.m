Rb_Mass = 1.42*10^-25;% mass of Rb87 in Kg
hbar = 1.05*10^-34;
N = 1e5;%atom number
Dip_freq = 2*pi*70;%dipole trap frequency in Hz
a_0 = 1.3*10^-6; %characteristic length of wavefunction in dipole trap
raman_wavelength = 790*10^-9; % raman beam wave length
k = 2*pi/raman_wavelength; %raman beam wave vector
a_B = 5.29*10^-11; %Bohr radius
a_s0 = 101.8*a_B; %0 channel scattering length
a_s2 = 100.4*a_B; %2 channel scattering length
pre_c0 = 4*pi*hbar^2*(a_s0 + 2*a_s2)/(3*Rb_Mass);%real c0
pre_c2 = 4*pi*hbar^2*(a_s2 - a_s0)/(3*Rb_Mass);%real c2
c0 = pre_c0*N/(hbar*Dip_freq*a_0^3);
c2 = pre_c2*N/(hbar*Dip_freq*a_0^3);
E_r = (hbar)^2*(2*k)^2/(2*Rb_Mass);%recoil energy
quanta = hbar*Dip_freq;
k_scale = k*a_0;%dimensionless k in the probelm
order = 3;%number of diffracted orders considered.
%Beta = 3000; dimensionless interaction.
TF_radius = (3*Beta/2)^(1/3);
xmin = -TF_radius;
xmax = TF_radius;
L = xmax-xmin;
Nx = 2^11+1; %number of grids.
deltax = (xmax-xmin)/(Nx-1);
deltaf = 1/(xmax-xmin);
X = linspace(xmin,xmax,Nx);% x space
f = (0:1:Nx-1)-(Nx-1)/2;% momentum space
k_spacing = k_scale*(xmax-xmin)/pi;%2*k_scale in f space. 
lattice_pot = 4*E_r;
V = lattice_pot/quanta;
real_Omega = 20000;%Raman coupling in Hz
Omega = real_Omega/Dip_freq;%rescaled coupling strength
