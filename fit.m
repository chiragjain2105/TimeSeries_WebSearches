function  cls  = fit(t, y, dpoly, dper,T)
m = length(y);
Apoly = zeros(m , dpoly + 1);
for i = 0 : 1 : dpoly
    Apoly(:, i + 1) = t.^ i;
end 
Aper = zeros(m, 2*dper);
for i = 1 : 1: dper
    Aper(:,2*i - 1) = cos( (2 * pi * i / T) *t);
    Aper(:,2*i) = sin( ( 2 * pi * i / T) *t);
end 
A = [ Apoly Aper];
lc = pinv(A);
cls = lc * y;
end
    
