%at detuning zero, ramp up omega in 25ms and hold for 25ms, get dressed
%state.

phi = phi_0;

% ks = [0.2,0.4,0.6,0.8];
% dts = (2+ks).^2 - ks.^2 - 4;
savepath = 'simulation_results/02132019SOC_dressed_state_8TF13/phi_1_50ms_';

Omega = linspace(0,1*detuning,3201);

draw = 0;
% spin1_2 = zeros(4,320);
% spin2_2 = zeros(4,320);
% width_2 = zeros(4,320);
% pos_2 = zeros(4,320);


for j=1:12
    
    phi = phi_0;
    
for i=1:3200
    phi_1 = dynamic(phi,0.001,1e-5,c0,c2,Nx,0,1,0,k_scale,f,deltax,deltaf,L,Omega(i+1),xmin,xmax,k_R,dts(j)*detuning);
   % phi_1 = dynamic(phi,0.001,1e-5,c0,c2,Nx,0,1,0,k_scale,f,deltax,deltaf,L,4*detuning,xmin,xmax,k_R,detuning);

    phi = phi_1;
    if draw==1 && mod(i,60)==0
        figure(1)
        plot(X,sq(phi))
%         figure(2)
%         plot(f./k_R*2*pi,sq(fourier_transform(phi,Nx,deltax)));
         drawnow;
    end
    save(strcat(savepath,num2str(dts(j)),'d_1E.mat'),'phi_1');
end


% for i=1:320
%     phi_dress = dynamic(phi,0.005,1e-5,c0,c2,Nx,0,1,0,k_scale,f,deltax,deltaf,L,1*detuning,xmin,xmax,k_R,detuning);
%     phi = phi_dress;
%     if draw==1 && mod(i,10)==0
%         plot(X,sq(phi))
%         drawnow;
%     end
%     save('simulation_results/02062019SOC_dressed_state_8TF/phi_dress25ms_25ms_1d_1E.mat','phi_dress');
% end




%     phi = phip;
%     dt = linspace(detuning,0,st(j));


%     for i=1:st(j)
%         phi_dress = dynamic(phi,0.005,1e-5,c0,c2,Nx,0,1,0,k_scale,f,deltax,deltaf,L,1*detuning,xmin,xmax,k_R,dt(i));
%         phi = phi_dress;
%         if draw==1 && mod(i,10)==0
%             plot(X,sq(phi))
%             drawnow;
%         end
%         %save('simulation_results/01182019SOC_dressed_state/phi_dress25ms_25ms_0d_1E.mat','phi_dress');
%     end

% 
% phi = phi_1.*[exp(1i.*ks(j).*k_R.*X);exp(1i.*ks(j).*k_R.*X);exp(1i.*ks(j).*k_R.*X)];
% 
% 
%     
%     for i=1:320
%         phi_dress = dynamic(phi,0.005,1e-5,c0,c2,Nx,0,0,0,k_scale,f,deltax,deltaf,L,1*detuning,xmin,xmax,k_R,0);
%         phi = phi_dress;
%         spin1_2(j,i) = integr(sq(phi(1,:)),Nx,deltax);
%         spin2_2(j,i) = integr(sq(phi(2,:)),Nx,deltax);
%         m1 = integr(X.*sq(phi(1,:)),Nx,deltax)/spin1_2(j,i);
%         m2 = integr(X.*sq(phi(2,:)),Nx,deltax)/spin2_2(j,i);
%         w1 = sqrt(integr((X-m1).^2.*sq(phi(1,:)),Nx,deltax)/spin1_2(j,i));
%         w2 = sqrt(integr((X-m2).^2.*sq(phi(2,:)),Nx,deltax)/spin2_2(j,i));
%         width_2(j,i) = w1*spin1_2(j,i) + w2*spin2_2(j,i);
%         pos_2(j,i) = m1*spin1_2(j,i) + m2*spin2_2(j,i);
%         if draw==1 && mod(i,30)==0
%             plot(X,sq(phi(1,:)),X,sq(phi(2,:)))
%             drawnow;
%         end
%    
%     end
%     
%             save('simulation_results/02072019SOC_dressed_state_8TF13/spin1_2_25ms_50ms.mat','spin1_2');
%             save('simulation_results/02072019SOC_dressed_state_8TF13/spin2_2_25ms_50ms.mat','spin2_2');
%             save('simulation_results/02072019SOC_dressed_state_8TF13/width_2_25ms_50ms.mat','width_2');
%             save('simulation_results/02072019SOC_dressed_state_8TF13/pos_2_25ms_50ms.mat','pos_2');
end

