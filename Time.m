function ynet = Time(cls1, dpoly1, dper1, t, T)
y11 = zeros(length(t),1);
y12 = zeros(length(t),1);
cpoly1 = cls1(1: (dpoly1 + 1)); 
cper1 = cls1((dpoly1 + 2) : end);
for i = 0 : dpoly1
    temp11(:,i+1) = t.^i;
end 
temp12 = zeros(length(t), 2*dper1);

for i = 1 : 1 : dper1
    temp12(:,2*i-1) = cos( (2 * pi * i / T) *t);
    temp12(:,2*i) = sin( ( 2 * pi * i / T) * t);
end 
y11 = temp11 * cpoly1;
y12 = temp12 * cper1;
ynet = y11 + y12;
end 