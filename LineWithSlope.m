%% How to draw a straight line with a 45-degree angle

x = 0:0.01:20;  % Create a range of x values
m = 1;          % Slope of the line (45-degree angle has slope = 1)
c = 0;          % y-intercept (can change if you want to shift the line up/down)
y = m * x + c;  % Equation of the straight line (y = mx + c)

% Plot the line
plot(x, y, 'b-', 'LineWidth', 2);  % 'b-' for blue solid line
xlabel('x label');
ylabel('y label');
title('Straight Line with 45-degree Angle');
grid on;
