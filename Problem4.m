% Define parameters
R0 = 1.15;  % Reproduction number
K = 1e6;   % Population size
n_max = 100;  % Number of days

% Initialize arrays for the logistic and first-order models
x_logistic = zeros(1, n_max + 1);
x_first_order = zeros(1, n_max + 1);

% Initialize parameters for derivative calculation
D1_filter = [1, -1];  % First derivative filter coefficients
D2_filter = [1, -2, 1];  % Second derivative filter coefficients

% Apply the logistic model
for n = 0:n_max
    x_logistic(n + 1) = K / (1 + (K * (R0 - 1) - R0) * R0^(-(n + 1)) / (R0 - 1));
end

% Apply the first-order model
M = 12;  % Order of the first-order filter (adjust as needed)
ak = ones(1, M);  % Coefficients for the first-order model
x_first_order(1) = 1;  % Initial condition

for n = 1:n_max
    for k = 1:M
        if n - k > 0
            x_first_order(n + 1) = x_first_order(n + 1) + ak(k) * x_first_order(n - k + 1);
        end
    end
    x_first_order(n + 1) = 1 - x_first_order(n + 1);
end

% Plot the results
figure;
plot(0:n_max, x_logistic, 'b', 'LineWidth', 2);
hold on;
plot(0:n_max, x_first_order, 'r--', 'LineWidth', 2);
title('Total Infections: Logistic vs. First-Order Model');
legend('Logistic Model', 'First-Order Model');
xlabel('Day');
ylabel('Total Infections');
grid on;

% Calculate first derivative and second derivative
first_derivative = conv(x_logistic, D1_filter, 'valid');
second_derivative = conv(x_logistic, D2_filter, 'valid');

% Find the inflection point
[~, max_derivative_index] = max(first_derivative);
zero_crossing_index = find(diff(sign(second_derivative)) == 2, 1);

disp(['Inflection point (First Derivative Maximum): Day ' num2str(max_derivative_index)]);
disp(['Inflection point (Zero-Crossing of Second Derivative): Day ' num2str(zero_crossing_index)]);