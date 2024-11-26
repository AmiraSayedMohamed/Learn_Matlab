% Define time intervals
t1 = -1:0.01:0;
t2 = 0:0.01:1;
t3 = 1:0.01:2;
t = [t1 t2 t3];

% Draw a reverse rectangle
x1 = ones(size(t1));
x2 = zeros(size(t2));
x3 = ones(size(t3));
x = [x1, x2, x3];

figure;
hold on;

% Plot the reverse rectangle
plot(t, x, 'r', 'LineWidth', 1.5);

% Draw lines
xL = [-1, -1]; % Starting and ending x-coordinates
yL = [0.5, 4]; % Starting and ending y-coordinates (vertical line)
plot(xL, yL, 'b-', 'LineWidth', 2);

% Draw upper line
xLU = [-1, 2]; % Starting and ending x-coordinates
yLU = [2.5, 2.5]; % Starting and ending y-coordinates (horizontal line)
plot(xLU, yLU, 'r-', 'LineWidth', 2);

% Draw lines
xL = [2, 2]; % Starting and ending x-coordinates
yL = [0.5, 4]; % Starting and ending y-coordinates (vertical line)
plot(xL, yL, 'b-', 'LineWidth', 2);

% Add grid, labels, and title
grid on;
xlabel('X-axis');
ylabel('Y-axis');
title('Reverse Rectangle with Additional Lines');
axis([-2 4 -3 5]);
hold off;
