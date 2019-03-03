%Problem 2 Euler Bernoulli beam bending
%David Curry
%ID: 304755606
clear all;
clc;
rng('default');
%create initial conditions
L = 1;
R = 0.013;
r = 0.011;
P = -2000;
d = 0.01;
E = 70*10^9;
I = (pi/4)*(R^4 - r^4);
nodes = 20;
step = L/(nodes-1);
A = zeros(nodes,nodes);
for row = 1:nodes
    for col = 1:nodes
        if row == 1 && col == 1
            A(row,col) = 1;
        elseif row == nodes && col == nodes 
            A(row,col) = 1;
        elseif row == col
            A(row,col) = -2;
            A(row, col+1) = 1;
            A(row,col-1) = 1;
        end
    end
end

b = zeros(nodes,1);
M = zeros(1,nodes);
for k = 1:nodes
    if k < d*nodes
        M(k) = (-P*(L - d)*step*(k-1))/L;
    else
        M(k) = (-P*d*(L - (step*(k-1))))/L;
    end
    if k == 1 || k == nodes 
        b(k) = 0;
    else 
        b(k) = ((step^2)*M(k))/(E*I);
    end
end

y = A\b;
x = linspace(0,1,nodes);
plot(x,y,'o-');
xlabel('Distance along beam');
ylabel('Deflection');
title('Deflection versus the distance along beam');

maxi = min(y);
for k = 1:nodes
    if y(k) == maxi
        maxi_x = x(k);
    end
end
c = min(d,L-d);
max2 = (P*c*(L^2 - c^2)^1.5)/(9*sqrt(3)*E*I*L);
error = abs(maxi - max2);

fprintf('Maximum displacement occurred at %.3f meters\n', maxi_x);
fprintf('Maximum displacement was %.5f meters\n',maxi);
fprintf('The error between the actual and calculated maximums is %.5f meters\n',error);