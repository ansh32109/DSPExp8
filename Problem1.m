R0 = 2.5; % Example R0 value        %a
numerator = 1;
denominator = [1, -R0];

H1 = tf(numerator, denominator);

% Pole-Zero Plot
pzmap(H1);

n = 20; % Number of days    %b
y = zeros(1, n);
y(1) = 1; % Assuming initial infection on day 1

% Iterate to find daily infections
for k = 2:n
    y(k) = 1 + R0 * y(k - 1);
end

% Display the results
disp(y);
% 
% threshold = 1e6; % 1 million            %c
% days_to_reach_threshold = ceil(log(threshold) / log(R0)) + 1;
% 
% disp(['It takes approximately ', num2str(days_to_reach_threshold), ' days to reach 1 million new daily infections.']);
% 
% % one-point method          %d
% Y = 34285612;
% R01 = 1-1/(Y)
%  
% 
% % Initialize variables          %e
% n = 20; % Number of days
% y = zeros(1, n);
% y(1) = 1; % Assuming initial infection on day 1
% 
% % Calculate new daily infections
% for k = 2:n
%     y(k) = 1 + R0 * y(k - 1);
% end
% 
% % Plot new daily infections
% figure;
% subplot(2, 1, 1);
% plot(1:n, y, 'bo-');
% xlabel('Day');
% ylabel('New Daily Infections');
% title('New Daily Infections with R0 = 2.5');
% 
% % Integrate to calculate total infections
% total_infections = cumsum(y);
% 
% % Plot total infections
% subplot(2, 1, 2);
% plot(1:n, total_infections, 'ro-');
% xlabel('Day');
% ylabel('Total Infections');
% title('Total Infections with R0 = 2.5');