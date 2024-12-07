% Create a figure
figure;

% Draw an arrow from point (0.1, 0.1) to (0.7, 0.7)
annotation('arrow', [0.2 0.7], [0.2 0.7]);

% Adjust the plot limits
axis([0 1 0 1]);

% Add title and labels
grid on;
title('Arrow Using annotation');
xlabel('X axis');
ylabel('Y axis');
