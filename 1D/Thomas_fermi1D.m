function [phi_0] = Thomas_fermi1D(Beta,X,TF_radius,potential)
phi_0 = real(sqrt((1/2*(15*Beta/(4*pi))^(2/5) - potential)/Beta)); % Computing the Thomas-Fermi approximation
%phi_0 = real(sqrt(pi/(4*Beta).*(TF_radius^2 - X.^2).^2));%integrate over 2d to get 1d wavefunction.