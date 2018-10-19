xcor_len = zeros(1,5);
ycor_len = zeros(1,5);
for i=12:13
%     filepath = strcat('speckle bench test data/numerical/',num2str(i),'.png');
%     image = imread(filepath);
inten = sq(fftshift(fft2(exp(-2*pi*1i*rand(2^i)),2^7,2^14+1)));
imagesc(inten)
colorbar
saveas(gcf,strcat('speckle bench test data/T_simu/',num2str(i),'.png'));
save(strcat('speckle bench test data\T_simu\inten_', num2str(i),'.mat'), 'inten')
    image = double(inten);
    
    [xcor,ycor] = correlation_length_of_2d_image(image);
    [~,nx] = size(xcor);
    [~,ny] = size(ycor);
    
    x = (1:1:100).*1;
    y = (1:1:100).*1;
    
    l = find(xcor<=0.135,1)*1;
    if isempty(l)
        xcor_len(1,i) = 0;
    else
        xcor_len(1,i) = l;
    end
    
    l = find(ycor<=0.135,1)*1;
    if isempty(l)
        ycor_len(1,i) = 0;
    else
        ycor_len(1,i) = l;
    end
 
    
    plot(x,xcor(1:100));
    ti = strcat('x correlation for image ',num2str(i),'.png');
    title(ti);
    xlabel('delta_x/pixel');
    ylabel('correlation')
    saveas(gcf,strcat('correlation images/T_simu/',ti))
    
    
    
    plot(y,ycor(1:100));
    ti = strcat('y correlation for image ',num2str(i),'.png');
    title(ti);
    xlabel('delta_y/um');
    ylabel('correlation')
    saveas(gcf,strcat('correlation images/T_simu/',ti))
    
end