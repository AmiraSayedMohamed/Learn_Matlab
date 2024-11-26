% Define x and y coordinates for the line
x = [0, 10]; % Starting and ending x-coordinates
y = [5, 5];  % Starting and ending y-coordinates (horizontal line)

% Plot the line
figure;
plot(x, y, 'b-', 'LineWidth', 2);
grid on;
xlabel('X-axis');
ylabel('Y-axis');
title('Straight Line');


% plot(x, y, 'r--o', 'LineWidth', 1.5); % Red dashed line with circle markers
% plot(x, y, 'g-.s', 'LineWidth', 2);  % Green dash-dot line with square markers
% plot(x, y, 'b:*', 'LineWidth', 1);   % Blue dotted line with asterisks
