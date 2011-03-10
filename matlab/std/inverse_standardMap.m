function f=inverse_standardMap(x, theta, epsilon)

f=[mod(x - epsilon*sin(theta - x), 2*pi), 
   mod(theta - x, 2*pi)];