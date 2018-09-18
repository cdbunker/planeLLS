%This script uses Linear Least Squares to find the equation for a plane
%that best fits a set of (x,y,z) points.

N = 1000; % number of points

%choose a normal and d
d = 3;

n = [1 0.25 0.75];
n = n/norm(n);

a = n(1);
b = n(2);
c = n(3);

%create datapoints on plane with some error
xy = (rand(N,2)-0.5)*10;
z = -(a*xy(:,1) + b*xy(:,2) - d)/c + (rand(N,1)-0.5)*1;

%Plot this data with the original plane
figure()
[x, y] = meshgrid(-5:1:5); % Generate x and y data
z_plane = -(a*x + b*y - d)/c; % Solve for z data
surf(x,y,z_plane) %Plot the surface
hold on
plot3(xy(:,1), xy(:,2), z(:), 'x')
title('Actual Plane')
ylabel('Y')
xlabel('X')
zlabel('Z')

%mean center
x_mean_centered = xy(:,1) - mean(xy(:,1));
y_mean_centered = xy(:,2) - mean(xy(:,2));
z_mean_centered = z(:,1) - mean(z(:,1));

%LLS
A = [x_mean_centered, y_mean_centered, z_mean_centered];
cov = A'*A;
[V,D] = eig(cov);

n_calculated = V(:,1)'; %choose the eigenvector with smallest eigenvalue
n_calculated = n_calculated/norm(n_calculated);
a_calculated = n_calculated(1);
b_calculated = n_calculated(2);
c_calculated = n_calculated(3);
d_calculated = a_calculated*mean(xy(:,1)) + b_calculated*mean(xy(:,2)) + c_calculated*mean(z(:,1));

%Plot calculated plane
figure()
title('Calculated Plane')
z_plane = -(a_calculated*x + b_calculated*y - d_calculated)/c_calculated; % Solve for z data
surf(x,y,z_plane) %Plot the surface
hold on
plot3(xy(:,1), xy(:,2), z(:), 'x')
title('Calculated Plane')
ylabel('Y')
xlabel('X')
zlabel('Z')