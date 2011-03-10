function mapobj = init_lpa3d

  mapobj = struct;
  mapobj.params = 37.5; % f

  mapobj.mapfunc = @(f) (@(v) [ f*sum(v)*exp(-0.1*sum(v)) 0.8*v(1)  0.6*v(2) ]);
  mapobj.boxfunc = @(params) get_box(params);

  mapobj.space = 'Rn';

end


function [center radius] = get_box(params)
  % the following is phenomenally stupid 
  max = 400;
  center = [max/2 max/2 max/2];  
  radius = [max/2 max/2 max/2];  
end


