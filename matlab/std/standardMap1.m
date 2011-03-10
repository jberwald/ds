function f=standardMap(x, theta, epsilon)

f=[mod(x + epsilon*sin(theta), 2*pi), 
   mod(x + theta + epsilon*sin(theta), 2*pi)];