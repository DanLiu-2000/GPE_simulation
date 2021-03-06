%at detuning zero, ramp up omega in 25ms and hold for 25ms, get dressed
%state.

phi = phi_0;
Omega = linspace(0,2*detuning,1101);
draw = 1;

for i=1:1100
    phi_1 = dynamic(phi,1e-2,1e-5,c0,c2,Nx,0,1,0,k_scale,f,deltax,deltaf,L,Omega(i+1),xmin,xmax,k_R,detuning);
    phi = phi_1;
    if draw==1 && mod(i,30)==0
        figure(1)
        plot(X,sq(phi))
        figure(2)
        plot(f./k_R*2*pi,sq(fourier_transform(phi,Nx,deltax)));
        drawnow;
    end
    save('simulation_results/11162018SOC_dressed_state/phi_1.mat','phi_1');
end


for i=1:1100
    phi_dress = dynamic(phi,1e-2,1e-5,c0,c2,Nx,0,1,0,k_scale,f,deltax,deltaf,L,2*detuning,xmin,xmax,k_R,detuning);
    phi = phi_dress;
    if draw==1 && mod(i,10)==0
        plot(X,sq(phi(1,:)),X,sq(phi(2,:)))
        drawnow;
    end
    save('simulation_results/11162018SOC_dressed_state/phi_dress.mat','phi_dress');
end


   
