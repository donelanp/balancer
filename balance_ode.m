function xdot = balance_ode(t, x, u)
xdot = zeros(4,1);

x2 = x(2);
x3 = x(3);
x4 = x(4);

% system parameters
g = 9.81;
L = 0.095;
mp = 0.187;
mw = 0.036;
Rw = 0.0216;
Rm = 5.2;
Kt = 0.32;
Kb = 0.495;

% get input torque from input voltage
T = Kt*(u-Kb*(-x2/Rw-x4))/Rm;

C = [0 mw 0 0             -1        0         0 1;...
     0 0  0 0             0         1         1 0;...
     0 mp 0 -mp*L*cos(x3) 1         0         0 0;...
     0 0  0 mp*L*sin(x3)  0         -1        0 0;...
     0 0  0 0             0         0         0 Rw;...
     0 0  0 0             L*cos(x3) L*sin(x3) 0 0;...
     1 0  0 0             0         0         0 0;
     0 0  1 0             0         0         0 0];
 
 b = [0; mw*g; -mp*x4^2*L*sin(x3); mp*g-mp*x4^2*L*cos(x3); T-0.5*mw*Rw^2; T; x(2); x(4)];
 
 xdot_RxRyNFf = C\b;
 
 xdot = xdot_RxRyNFf(1:4);
end