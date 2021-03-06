function [phi_0] = Thomas_fermi3D(Beta,potential)


phi_0 = sqrt(max(0,(1/2*(15*Beta/4/pi)^(2/5) - potential)/Beta)); % Computing the Thomas-Fermi approximation
%phi_0 = phi_0./norm1d(phi_0,Nx,DeltaX);
%phi_0 = real(sqrt(pi/(4*Beta).*(TF_radius^2 - X.^2).^2));%integrate over 2d to get 1d wavefunction.

% cutX = abs(X) < TF_radius;
% cutY = abs(Y) < TF_radius;
% cutXY = cutY.*cutX;
% phi_0 = phi_0.*cutXY;

end