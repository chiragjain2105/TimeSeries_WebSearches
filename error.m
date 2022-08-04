function J = error(y,ynet)
temp = 0;
m = length(y);
for i = 1 : 1 : m
    temp = temp + (y(i) - ynet(i)).^2;
end 
J = temp/ m;
end 