function y = inverse_ft(phi,Nx,deltaf)
% 
% lin_1 = linspace(0,Nx-1,Nx);
% parity = (-1).^lin_1;
% phi_1 =parity.*phi;
% y = ifft(phi_1).*deltaf*Nx;
% y = y.* parity;
y = ifft(ifftshift(phi)).*deltaf.*Nx;