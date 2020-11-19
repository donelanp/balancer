%--------------------------------------------------------------------------
% system parameters
%--------------------------------------------------------------------------
% operating point
xs = [0; 0; 0; 0];
us = 0;

% linear model
[A, B] = GetLinModFtxu(@balance_ode, [], xs, us);
C = eye(4);
D = zeros(4,1);

% LQR parameters
R = 1;
Q = 100 * [1 0 0 0;...
           0 1 0 0;...
           0 0 1 0;...
           0 0 0 1];
K = lqr(A, B, Q, R);

% wheel radius
Rw = 0.0216;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% linear model
%--------------------------------------------------------------------------
simulation_time = 5;
sample_time = 0.03;

% initial state
x0 = [0; 0; deg2rad(2); 0];

% simulate the linear model
sim('linear_model');

% plot position vs time
figure(1);
plot(t, x_linear(:,1), 'b');
xlabel('time (seconds)');
ylabel('position (meters)');
title('Patrick Donelan position vs time');

% plot alpha vs time
figure(2);
plot(t, x_linear(:,3), 'g');
xlabel('time (seconds)');
ylabel('alpha (radians)');
title('Patrick Donelan alpha vs time');
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% nonlinear model
%--------------------------------------------------------------------------
simulation_time = 5;
sample_time = 0.03;

% initial state
x0 = [0; 0; deg2rad(2); 0];

% simulate the linear model
sim('nonlinear_model');

% plot position vs time
figure(3);
plot(t, x_nonlinear(:,1), 'b');
xlabel('time (seconds)');
ylabel('position (meters)');
title('Patrick Donelan position vs time');

% plot alpha vs time
figure(4);
plot(t, x_nonlinear(:,3), 'g');
xlabel('time (seconds)');
ylabel('alpha (radians)');
title('Patrick Donelan alpha vs time');
%--------------------------------------------------------------------------