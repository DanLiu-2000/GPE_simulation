function [c1,c2,c3,c4,c5,c6,c7] = exact_ode(mat,t)
m = mat/1e5/1i;
[~,eigen,left] = eig(m);
coeff = left'*[0;0;0;1;0;0;0];
c = zeros(7,1);
for j = 1:7
    c(j) = coeff(j)*exp(eigen(j,j)*1i*1e5*t);
end
asw = left*c;
c1 = asw(1);
c2 = asw(2);
c3 = asw(3);
c4 = asw(4);
c5 = asw(5);
c6 = asw(6);
c7 = asw(7);
end
