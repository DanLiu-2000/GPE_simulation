scale_parameters;
Groundstate;
ks = (1.2:0.1:3.2);
dtn = (ks+1).^2 - (ks-1).^2;
%OmegaR = 6.0;
eigen1 = 1/2*(dtn+sqrt(dtn.^2+OmegaR^2));
eigen2 = 1/2*(dtn-sqrt(dtn.^2+OmegaR^2));

savepath = 'simulation_results/05152019direct_SOC_dressed_state_8TF13/phi_1';

for j=1:21
phi_1 = zeros(3,Nx);
'alive'
a = eigen1(j);
b = OmegaR/2;

coef1 = a/sqrt(a^2+b^2);
coef2 = b/sqrt(a^2+b^2);

kick = ks(j)-1;

phi_1(1,:) = phi_0(1,:).*coef1.*exp(1i.*kick.*k_R.*X);
phi_1(2,:) = phi_0(1,:).*coef2.*exp(1i.*(kick+2).*k_R.*X);

save(strcat(savepath,num2str(ks(j)),'k_R_',num2str(OmegaR),'E.mat'),'phi_1');

phi = phi_1;
spin1 = zeros(1,320);
draw = 0;
    
for i=1:320
    phi_dress = dynamic(phi,0.005,1e-5,c0,c2,Nx,0,0,0,k_scale,f,deltax,deltaf,L,OmegaR*detuning,xmin,xmax,k_R,0);
    phi = phi_dress;
    spin1(i) = integr(sq(phi(1,:)),Nx,deltax);

    if draw==1 && mod(i,20)==0
        plot(1:1:320,spin1)
        drawnow;
    end
    
end
    

save(strcat(savepath,num2str(ks(j)),'k_R_',num2str(OmegaR),'E_spin1.mat'),'spin1');
save(strcat(savepath,num2str(ks(j)),'k_R_',num2str(OmegaR),'E_fphi.mat'),'phi');
end
