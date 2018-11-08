li=[20,25,30];

r = (1:1:300)*deltasf/k_R*4*pi;
pow_r = zeros(3,300);
for i=1:3
    speckle = imread(strcat('speckle bench test data/12/',num2str(li(i)),'mm.png'));
    speckle = double(speckle);
    speckle = speckle - repmat(mean(speckle,2),1,Ns);
    
    %fsp = fourier_transform(speckle',Ns,deltas)';
    fsp = fftshift(fft2(speckle));
    fp = sq(fsp);
    %fp = fp./max(max(fp));
    [maxr,maxc] = find(fp==max(max(fp)));
    
    
    
    X_cord = repmat((1:1:1280),1024,1);
    Y_cord = repmat((1:1:1024)',1,1280);
    
    X_cord = X_cord - mean(maxc);
    Y_cord = Y_cord - mean(maxr);
    
    r_cord = sqrt(X_cord.^2 + Y_cord.^2);
    for k=1:300
        [cordr,cordc] = find(r_cord<=k & r_cord>(k-1));
        num = size(cordr,1);
        po = 0;
        for j=1:num
            po  = po + fp(cordr(j),cordc(j));
        end
        po = po/num;
        pow_r(i,k) = po;
    end
        
        
%     figure(i)
%     subplot(121)
%     plot(r(3:end),pow_r(i,3:end))
%     title('PDS')
%     xlabel('k/k_R in radial direction')
%     ylabel('power density')
%     subplot(122)
%     plot(r,log(pow_r(i,:)))
%     title('log PDS')
%     xlabel('k/k_R in radial direction')
%     ylabel('log power density')
    
    figure(i)
    f = fit(r(7:end)',pow_r(i,7:end)','a*max(1-x/b,0)','StartPoint',[max(pow_r(i,7:end)),0.15]);
    coe = coeffvalues(f);
    plot(f,r(7:end),pow_r(i,7:end))
    title('fit linear PSD to data')
    xlabel('k/k_R in radial direction')
    ylabel('power density')
    text(0.3,2e11,strcat('k_m_a_x = ',num2str(coe(2))))
end
    
    
    