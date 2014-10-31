%% Clean up
close all;
clear all;
clc;
format;


%% ------------Ignore this, it just makes some random data-----------------
%  ------------------------------------------------------------------------
N = 100;          % Number of particles.
M = 2000;         % Number of time steps.
r = zeros(M,3*N); % Position data.
v = zeros(M,3*N); % Velocity data.

% Generate randomized initial positions.
r(1,:) = rand(1,3*N)*2-1;

% Generate randomized initial velocities.
v(1,:) = rand(1,3*N)*2-1;

% Integrate toy differential equation just to get some data.
t  = 0;           % Current time.
dt = 0.001;       % Time step.

for i=2:M
    v(i,:) = v(i-1,:) - dt * r(i-1,:);
    r(i,:) = r(i-1,:) + dt * v(i,:);
end
%  ------------------------------------------------------------------------
%  ------------------------------------------------------------------------


%% This is the actual animation of the data
% Reorganize the data a bit.
x = r(:,1:N);
y = r(:,N+1:2*N);
z = r(:,2*N+1:end);

% First, set up a figure, plot the initial state (and make the figure
% pretty).
figure(1);
plotObject = plot3(x(1,:),y(1,:),z(1,:),'bo');
hold on;
axis([-1 1 -1 1 -1 1]);
title ('This is some random data', 'FontSize', 15, 'interpreter', 'latex');
xlabel('x', 'FontSize', 15, 'interpreter', 'latex');
ylabel('y', 'FontSize', 15, 'interpreter', 'latex');
zlabel('z', 'FontSize', 15, 'interpreter', 'latex');

% Add a slider to control the time in the plot.
plotSlider = uicontrol('style','slider',...
                       'min', 1,...
                       'max', M,...
                       'value',1,...
                       'sliderstep',[.001 0.01],...
                       'units','normalized',...
                       'position',[.02 .02 .98 .02]);

% Add a text-box which displays the current time in the plot.
plotText = text(0.9, 0,...
                't = 0.0',...
                'units', 'normalized',...
                'FontSize', 15,...
                'interpreter', 'latex');
                 
% Now, animate the data with the slider.
while true
    % Find the current value of the slider.
    i = round(get(plotSlider,'value'));
    
    % Adjust the plot accordingly.
    set(plotObject, 'XData', x(i,:),...
                    'YData', y(i,:),...
                    'ZData', z(i,:));
	
    % Set the text box value to the actual time.            
	set(plotText, 'string', sprintf('t = %3.2f', i*dt));
    
    % Set a small break for every time we go through here, so that we force
    % matlab to actually update and show us the plot.
    pause(1e-5);
end














    