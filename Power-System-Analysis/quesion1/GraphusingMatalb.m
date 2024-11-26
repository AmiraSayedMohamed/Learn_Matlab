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

% Draw  horizontal arrows using quiver
quiver(-1, 3, 0.6, 0, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Arrow at y=3  - (40 MW )
quiver(-1, 3.5, 0.6, 0, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Arrow at y=3.5 -  ( 15MVAR )

% Draw mirrored arrows
quiver(2, 3, -0.6, 0, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Mirrored arrow at y=3  (60 MW)
quiver(2, 3.5, -0.6, 0, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Mirrored arrow at y=3.5  (45 MVAR)

% Draw PG2 Arrow
quiver(2.6, 1.2, -0.6, 0, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Arrow at y=3

% Draw Vertical arrows 
quiver(0.3, 0, 0, 1, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Arrow at y=3
quiver(0.7, 0, 0, 1, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.5); % Arrow at y=3.5


% Add annotations
text(-1.9, 3.1, '40 MW', 'FontSize', 10, 'Color', 'k'); % Left arrow value lower
text(-2, 3.6, '15 MVAR', 'FontSize', 10, 'Color', 'k'); % Left arrow value upper
text(2.3, 3.1, '60 MW', 'FontSize', 10, 'Color', 'k'); % Right arrow value
text(2.3, 3.6, '45 MVAR', 'FontSize', 10, 'Color', 'k'); % Right arrow value
text(-0.1, 1.4, '90 MVAR', 'FontSize', 6, 'Color', 'k'); % Right arrow value
text(0.6, 1.4, '100 MW', 'FontSize', 7, 'Color', 'k'); % Right arrow value
text(2.2, 1, 'PG2 = 100 MW', 'FontSize', 7, 'Color', 'k'); % Right arrow value
% write text of z values
text(0.6, 1.4, '100 MW', 'FontSize', 7, 'Color', 'k'); % Right arrow value
text(0.6, 1.4, '100 MW', 'FontSize', 7, 'Color', 'k'); % Right arrow value
text(0.6, 1.4, '100 MW', 'FontSize', 7, 'Color', 'k'); % Right arrow value
% Node labels
text(0, 2.7, 'J0.08', 'FontSize', 10, 'Color', 'b');
text(-0.9, 1.2, 'J0.05', 'FontSize', 10, 'Color', 'b');
text(1.1, 1.2, 'J0.06', 'FontSize', 10, 'Color', 'b');

% Add grid, labels, and title
axis([-4 4 -2 6]);
grid on;
xlabel('X-axis');
ylabel('Y-axis');
title('Reverse Rectangle with Annotated Values');
hold off;
