function mapobj = init_oneisland

  mapobj = struct;

  mapobj.params = [.03 .95 .15]; % m, q, b
  mapobj.mapfunc = @(params) (@(x0) the_map(params,x0));
  mapobj.boxfunc = @(params) get_box(params);
  mapobj.space = 'Rn';

end


function [center radius] = get_box(params)

  center = [0.5 10];
  radius = [0.5 10];
end


function evaluated = the_map(params,x0)

  m = params(1);
  q = params(2);
  b = params(3);
  
  p = x0(1);
  x = x0(2);
  
  fAA = exp(1-b*x);
  fAa = exp(.5-x);
  faa = exp(3-.3*x);
  fA = p*fAA + (1-p)*fAa;
  fa = p*fAa + (1-p)*faa;
  f = p*fA + (1-p)*fa;
  
  p2 = (p*fA + q*m)/(f+m);
  x2 = x*(f+m);
  evaluated = [p2 x2];
end

