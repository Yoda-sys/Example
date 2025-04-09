% Group 12 Code
% Avery Ribich, Declan Roberts


clc
clear

% Simplified Function
f = @(x) 51.69375 * tan(0.18977 * x) - 50;

% Interval
xl = 0;
xu = 5; 

% Plot the function to check its behavior
figure;
time = linspace(0, 5, 1000); 
velocity = f(time); 
plot(time, velocity, 'b', 'LineWidth', 2);
hold on;
yline(0, '--k'); 
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Velocity vs Time (0-5s)');
grid on;
xlim([0, 5]);
ylim([-50, 30]); 
legend('Velocity Curve', 'y=0 Line');

% Check if sign change exists in the interval
if f(xl) * f(xu) > 0
    error('Function does not change sign in the given interval. Choose a different interval.');
end

tol = 1; 
max_iter = 100;

iter = 0;
errors = []; 
roots = [];  
approx_error = 100; 

% Display table header
fprintf('%-10s %-15s %-15s\n', 'Iteration', 'Approximate Root', 'Error (%)');
fprintf('--------------------------------------------------\n');

% Bisection method loop
while iter < max_iter
    xr = (xl + xu) / 2; 
    roots = [roots, xr]; 
    
    % Compute error after the first iteration
    if iter > 0
        approx_error = abs((roots(end) - roots(end-1)) / roots(end)) * 100;
        errors = [errors, approx_error]; 
    else
        approx_error = NaN; 
    end

    % Display iteration results
    fprintf('%-10d %-15.6f %-15.6f\n', iter + 1, xr, approx_error);

    % Stopping condition: exit when error < 1%
    if iter > 0 && approx_error < tol
        break;
    end

    % Bisection logic
    if f(xr) == 0  
        break;
    elseif f(xl) * f(xr) < 0
        xu = xr;
    else
        xl = xr;
    end

    iter = iter + 1;
end

% Estimated root
root = xr;

% Final results
fprintf('--------------------------------------------------\n');
fprintf('Final Estimated Root: %.6f\n', root);
fprintf('Total Iterations: %d\n', iter);
