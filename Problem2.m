% Initialize variables
n_max = 100; % Number of days
M = 12; % given limit
x = zeros(1, n_max+1);
y = zeros(1, n_max+1);
ak = [0.1, 0.15, 0.25, 0.26, 0.34, 0.42, 0.25, 0.2, 0.15, 0.1, 0.1, 0.1]; % coefficients
x(1) = 1; % initial infection

% Calculate new daily infections
for n = 1:n_max
    for k = 1:M
        if n - k > 0
            y(n + 1) = y(n + 1) + ak(k) * y(n - k + 1);
        end
    end
    y(n + 1) = 1 - y(n + 1);
end

% Plot the daily infections
figure;
plot(0:n_max, y);
title('Daily Infections Over Time');
xlabel('Day');
ylabel('Daily Infections');
grid on;
figure;

% Integrate to calculate total infections
total_infections = cumsum(y);

% Plot total infections
plot(0:n_max, total_infections, 'ro-');
xlabel('Day');
ylabel('Total Infections');
title('Total Infections with R0 = 2.5');