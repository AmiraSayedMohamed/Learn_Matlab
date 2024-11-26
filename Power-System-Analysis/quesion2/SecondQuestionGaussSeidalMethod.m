% Define x values
x = 0:0.5:10;

% Define y values with an offset for each line
y_base = sin(x); % Base sine wave
offsets = linspace(-1.5, 1.5, 20); % Offsets for each line

% Line styles, marker styles, and colors
line_styles = {'-', '--', ':', '-.'};
marker_styles = {'o', '+', '*', '.', 'x', 's', 'd', '^', 'v', '>', '<', 'p', 'h'};
colors = {'b', 'g', 'r', 'c', 'm', 'y', 'k'};

% Create a new figure
figure;
hold on;

% Counter to track combinations
comb_counter = 1;

% Loop through combinations
for ls = 1:length(line_styles)
    for ms = 1:length(marker_styles)
        for c = 1:length(colors)
            % Stop if we've exhausted the offset range
            if comb_counter > length(offsets), break; end
            
            % Compute y values with offset
            y = y_base + offsets(comb_counter);
            
            % Generate style string
            style = strcat(colors{c}, line_styles{ls}, marker_styles{ms});
            
            % Plot with the current style
            plot(x, y, style, 'LineWidth', 1.5, 'MarkerSize', 6);
            
            % Increment counter
            comb_counter = comb_counter + 1;
        end
    end
end

% Add labels, title, and legend
xlabel('X-axis');
ylabel('Y-axis');
title('Demonstration of Line, Marker, and Color Styles');
grid on;

% Adjust plot limits
ylim([-3 3]);
hold off;
