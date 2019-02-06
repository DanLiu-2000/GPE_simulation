
grad = zeros(1,1601);
grads = [0.5,1,2,3,4,5];
spin1 = zeros(6,320);

width = zeros(6,320);
pos = zeros(6,320);

for j=1:10
    grad(1:801) = linspace(0,grads(j),801);
    grad(802:end) = linspace(grads(j),0,800);
    draw = 0;
    phi = phi_e;
    
    
    for i=1:1600
        phi_1 = dynamic(phi,0.001,1e-5,c0,c2,Nx,-grad(i+1)*X,1,0,k_scale,f,deltax,deltaf,L,1*detuning,xmin,xmax,k_R,detuning);
       % phi_1 = dynamic(phi,0.001,1e-5,c0,c2,Nx,0,1,0,k_scale,f,deltax,deltaf,L,4*detuning,xmin,xmax,k_R,detuning);

        phi = phi_1;
        if draw==1 && mod(i,60)==0
            figure(1)
            plot(X,sq(phi))
    %         figure(2)
    %         plot(f./k_R*2*pi,sq(fourier_transform(phi,Nx,deltax)));
             drawnow;
        end
        save(strcat('simulation_results/02012019SOC_k_eigenstate/phi_1_25ms_318ms_grad_',num2str(j),'.mat'),'phi_1');
    end


   
    for i=1:320
        phi_dress = dynamic(phi,0.005,1e-5,c0,c2,Nx,0,0,0,k_scale,f,deltax,deltaf,L,1*detuning,xmin,xmax,k_R,detuning);
        phi = phi_dress;
        spin1(j,i) = integr(sq(phi(1,:)),Nx,deltax);
        
        m1 = integr(X.*sq(phi(1,:)),Nx,deltax);
        m2 = integr(X.*sq(phi(2,:)),Nx,deltax);
        w1 = sqrt(integr((X-m1).^2.*sq(phi(1,:)),Nx,deltax));
        w2 = sqrt(integr((X-m2).^2.*sq(phi(2,:)),Nx,deltax));
        width(j,i) = w1*spin1(j,i) + w2*(1-spin1(j,i));
        pos(j,i) = m1*spin1(j,i) + m2*(1-spin1(j,i));
        if draw==1 && mod(i,10)==0
            plot(X,sq(phi(1,:)),X,sq(phi(2,:)))
            drawnow;
        end
            save(strcat('simulation_results/02012019SOC_k_eigenstate/spin125ms_25ms_318ms_grad_',num2str(j),'.mat'),'spin1');
            
            save(strcat('simulation_results/02012019SOC_k_eigenstate/width25ms_25ms_318ms_grad_',num2str(j),'.mat'),'width');
            save(strcat('simulation_results/02012019SOC_k_eigenstate/pos25ms_25ms_318ms_grad_',num2str(j),'.mat'),'pos');

    end
end