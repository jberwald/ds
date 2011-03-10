function [center radius] = henon_bounding_box(params)

center = [0 0];

B = abs(params(2))+1;
A = abs(params(1));
R = (B + sqrt(B^2 + 4*A))/2;
R = sup(R);

radius = [R R];
