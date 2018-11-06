li=[20,25,30];
fspeckle = zeros(3,Ns);
for i=1:3
    speckle = imread(strcat('speckle bench test data/12/',num2str(li(i)),'mm.png'));
    speckle = double(speckle);
    speckle = speckle - repmat(mean(speckle,2),1,Ns);
    
    %fsp = fourier_transform(speckle',Ns,deltas)';
    fsp = fftshift(fft(speckle,Ns,2),2);
    sq_fsp = sq(fsp);
    
    
    
    pow = mean(sq_fsp);
    
    fspeckle(i,:) = pow;
end
    
    
    