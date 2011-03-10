
function v = standard_int_image_old(x,y)

% This computes the interval image of the standard map
% S(x,y) = (x + y + (e/2*pi)*sin(2*pi*x), y + (e/2*pi)*sin(2*pi*x)) 
% where x and y are intervals and 0 < e < 2 or so.

e = 0.8;

X = x + y + (e/(2*pi))*sin(2*pi*x);

Y = y + (e/(2*pi))*sin(2*pi*x);

X0 = mod(inf(X),1);
X1 = mod(sup(X),1);

Y0 = mod(inf(Y),1);
Y1 = mod(sup(Y),1);

X = infsup(min(X0,X1), max(X0,X1));
Y = infsup(min(Y0,Y1), max(Y0,Y1));

				% We compare all sorts of areas of boxes
				% wrapped around in different ways. So
				% the smallest area corresponds to the
				% right way of wrapping the image around.

box_area = (sup(Y)-inf(Y))*(sup(X)-inf(X));
split_X = (sup(Y) - inf(Y))*inf(X) + (sup(Y) - inf(Y))*(1-sup(X));
split_Y = (sup(X) - inf(X))*inf(Y) + (sup(X) - inf(X))*(1-sup(Y));
split_both = inf(X)*inf(Y) + inf(X)*(1-sup(Y)) + inf(Y)*(1-sup(X)) + (1-sup(X))*(1-sup(Y));

v = [X Y];

if (split_X < box_area)

%   left = Y*infsup(0,inf(X));
%   right = Y*infsup(sup(X),1);

  box_area = split_X;
  
  v = [infsup(0,inf(X)) Y; infsup(sup(X),1) Y];

end

if (split_Y < box_area)

%   down = X*infsup(0,inf(Y));
%   up = X*infsup(sup(Y),1);

  box_area = split_Y;
  
  v = [X infsup(0,inf(Y)); X infsup(sup(Y),1)];
  
end

if (split_both < box_area)

%   low_left = infsup(0,X0)*infsup(0,Y0);
%   low_right = infsup(X1,1)*infsup(0,Y0);
%   up_left = infsup(0,X0)*infsup(Y1,1);
%   up_right = infsup(X1,1)*infsup(Y1,1);

  v = [infsup(0,inf(X)) infsup(0,inf(Y)); infsup(0,inf(X)) infsup(sup(Y),1); infsup(sup(X),1) infsup(0,inf(Y)); infsup(sup(X),1) infsup(sup(Y),1)];

end



