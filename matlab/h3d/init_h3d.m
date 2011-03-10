function mapobj = h3d

  mapobj = struct;
  mapobj.params = [0.44 0.21 0.35 -0.25 -0.3]; %   [a b c alpha tau]
  mapobj.space = 'Rn';
  mapobj.mapfunc = @(params) the_map(params);
  mapobj.boxfunc = @(params) get_box(params);
  mapobj.inverse = @(v)[v(2), v(3), -map.params(4) + v(1) - map.params(5)*v(2) - map.params(1)*v(2)*v(2)- map.params(2)*v(2)*v(3) - map.params(3)*v(3)*v(3)];

end

function [center radius] = get_box(params)
  center = [.15 .15 .15]
  radius = [3.276 3.276 3.276]
end

function map = the_map(params)
  % The 3D Henon is the following:
  % f1 = alpha + tau*x(1) + x(3) + a*x(1)*x(1) + b*x(1)*x(2) + c*x(2)*x(2);
  % f2 = x(1);
  % f3 = x(2);
  % f= [f1,f2,f3];
  map = @(v) [params(4) + params(5)*v(1) + v(3) + params(1)*v(1)*v(1) + params(2)*v(1)*v(2) + params(3)*v(2)*v(2), v(1), v(2)];
end

function map = the_inverse(params)

  map = @(v) [v(2), v(3), -params(4) + v(1) - params(5)*v(2) - params(1)*v(2)*v(2) - params(2)*v(2)*v(3) - params(3)*v(3)*v(3)];

% THE INVERSE IS GIVEN BY:
%
%  f=inv_henon3D(x, alpha, tau, a, b, c)
%
%  f1 = x(2);
%  f2 = x(3);
%  f3 = -alpha + x(1) - tau*x(2) - a*x(2)*x(2) - b*x(2)*x(3) - c*x(3)*x(3)

end
