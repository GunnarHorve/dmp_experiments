clc; clear; close;
%% Train DMP
% DMP training parameters
name = 'something.xml';  % file to save DMP to
n_rfs = 200;        % how many basis functions to train with
dt  = 0.001;        % integration timestep

% create DMP (save to .xml)
T = y_cubed(dt);
train_dmp(name, n_rfs, T, dt);

%% Use trained DMP
% DMP running parameters
tau = 1.0;          % go relatively faster/slower than trained DMP
%start = 0.334;          % set desired start-point of trajctory
%goal = 0.2187;           % set desired end-point of trajectory
start = 0;
goal = 1;
% load in DMP
myRunner = DMP_Runner(name, start, goal);
% Generate trajectory, Y, using DMP
for i=0:tau/dt
  Y(i+1,:) = myRunner.step(tau, dt);
end

%% Analyze Results
time = (0:dt:tau)';
plot((0:dt:tau)',[Y(:,1) T(:,1)]);
title('Generated DMP demonstration')
xlabel('Time') % x-axis label
ylabel('System trajectory') % y-axis label
legend('Original Trajectory','Trained DMP Trajectory')
aa=axis; axis([min(time) max(time) aa(3:4)]);
