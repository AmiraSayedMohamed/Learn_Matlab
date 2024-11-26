%% Program to plot Rectangle using matlab function
 
%% first code  
% x = [2 7 7 2 2];
% y = [2 2 8 8 2];
% plot(x,y);
% axis([0 10 0 10]); % to set axis property

% ---------------------------------------------------

%% Second Code

% % Create a figure
% figure;
% 
% % Define the rectangle position [x, y, width, height]
% x = 2;  % x-coordinate of the bottom-left corner
% y = 3;  % y-coordinate of the bottom-left corner
% width = 4;  % width of the rectangle
% height = 2;  % height of the rectangle
% 
% % Draw the rectangle
% rectangle('Position', [x, y, width, height], 'EdgeColor', 'b', 'LineWidth', 2);
% 
% % Set axis limits
% axis([0 10 0 10]);
% 
% % Add title and labels
% title('Rectangle Drawing');
% xlabel('X axis');
% ylabel('Y axis');
% grid on; % Optional, adds grid lines for better visualization

% ----------------------------------------------------------------------------

%% Third Try
% rectangle('position', [2 2 5 6]);

%---------------------------------------------------------------------------

%% Fourth Try

% t1 = -1:0.01:0;           % Create a time vector t1 from -1 to 0 with a step size of 0.01
% t2 = 0:0.01:1;            % Create a time vector t2 from 0 to 1 with a step size of 0.01
% t3 = 1:0.01:2;            % Create a time vector t3 from 1 to 2 with a step size of 0.01
% t = [t1 t2 t3];           % Combine t1, t2, and t3 to form a single time vector t
% x1 = zeros(size(t1));     % Create a vector x1 of zeros, with the same length as t1
% x2 = ones(size(t2));      % Create a vector x2 of ones, with the same length as t2
% x3 = zeros(size(t3));     % Create a vector x3 of zeros, with the same length as t3
% x = [x1, x2, x3];         % Combine x1, x2, and x3 to form a single signal vector x
% plot(t, x);               % Plot the signal x against the time vector t
% ylim([-0.5 1.5]);         % Set the y-axis limits to range from -0.5 to 1.5


%% Fifth Try

x1 = ones(size(t1));
x2 = zeros(size(t2));
x3 = ones(size(t3));
x = [x1, x2, x3];
plot(t, x);
ylim([-0.5, 1.5]);
