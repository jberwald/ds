function mapobj = init_lpa3d_s2

  mapobj = struct;
  mapobj.params = 37.5; % f
  mapobj.mapfunc = @(params) (@(v) the_map(v,params));
  mapobj.boxfunc = @(params) get_box(params);

  mapobj.space = 'Rn';

end

function [center radius] = get_box(params)
  % the following is phenomenally stupid 
  max = 400;
  center = [max/2 max/2 max/2];  
  radius = [max/2 max/2 max/2];  
end

function W = the_map(v,f)

  mapfunc = @(v) [f*sum(v)*exp(-0.1*sum(v)) 0.8*v(1)  0.6*v(2) ];
  
  W = slice_interval(v,2);
  for i = 1:length(W)
    W(i,:) = mapfunc(W(i,:));
  end
end
  
