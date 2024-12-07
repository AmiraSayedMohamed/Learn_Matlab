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

% Draw vertical lines
xL = [-1, -1]; % Starting and ending x-coordinates
yL = [0.5, 4]; % Starting and ending y-coordinates (vertical line)
plot(xL, yL, 'b-', 'LineWidth', 2);

xL = [2, 2]; % Starting and ending x-coordinates
yL = [0.5, 4]; % Starting and ending y-coordinates (vertical line)
plot(xL, yL, 'b-', 'LineWidth', 2);

% Draw upper horizontal line
xLU = [-1, 2]; % Starting and ending x-coordinates
yLU = [2.5, 2.5]; % Starting and ending y-coordinates (horizontal line)
plot(xLU, yLU, 'r-', 'LineWidth', 2);

% Draw arrows using quiver
quiver(-1, 3, 0.6, 0, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Arrow at y=3
quiver(-1, 3.5, 0.6, 0, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Arrow at y=3.5

% Draw mirrored arrows
quiver(2, 3, -0.6, 0, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Mirrored arrow at y=3
quiver(2, 3.5, -0.6, 0, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Mirrored arrow at y=3.5

% Add grid, labels, and title
axis([-4 4 -2 6]);
grid on;
xlabel('X-axis');
ylabel('Y-axis');
title('Reverse Rectangle with Additional Lines and Mirrored Arrows');
hold off;
