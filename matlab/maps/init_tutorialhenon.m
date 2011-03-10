function mapobj = init_tutorialhenon

  mapobj = struct;
  mapobj.params = [1.4 0.3]; % classic parameters
  mapobj.space = 'Rn';
  mapobj.mapfunc = @(params) the_map(params);
  mapobj.boxfunc = @(params) get_box(params);

end

function [center radius] = get_box(params)
  % convention: params = [a b]
  center = [0 0]; % the box will be centered at the origin
  B = abs(params(2))+1;
  A = abs(params(1));
  R = (B + sqrt(B^2 + 4*A))/2;
  R = sup(R);
  radius = [R R]; % so, the diagonal of the box goes from (-R,-R) to (R,R)
end

function map = the_map(params)
  % returns the Henon map f_{a,b}(x,y) = (1-a*x^2 + y, b*x)
  map = @(v) [1 - params(1)*v(1)*v(1) + v(2), params(2)*v(1)];
end

