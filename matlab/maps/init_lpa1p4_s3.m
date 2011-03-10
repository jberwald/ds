function mapobj = init_lpa3d_s3

  mapobj = struct;
  mapobj.params = 37.5; % f
  mapobj.mapfunc = @(params) (@(v) the_map(v,params));
  mapobj.boxfunc = @(params) get_box(params);
  mapobj.slices = 3;  
  mapobj.pointmapfunc = @(params) (@(v) [params*sum(v)*exp(-0.1*sum(v)) 0.8*v(1)  0.6*v(2) ]);
  mapobj.parmapfunc = @(f) (@(V) par_map(par_map(par_map(par_map(V,f),f),f),f));
  mapobj.space = 'Rn';

end

function [center radius] = get_box(params)
  % the following is phenomenally stupid 
  max = 120;
  center = [max/2 max/2 max/2];  
  radius = [max/2 max/2 max/2];  
end

function W = the_map(v,f)
  F = @(v) [f*sum(v)*exp(-0.1*sum(v)) 0.8*v(1)  0.6*v(2) ];

  W = slice_interval(v,3);
  for i = 1:length(W)
    W(i,:) = F(F(F(F(W(i,:)))));
  end
end
  
function W = par_map(V,f) % row vectors!
  S = sum(V,2);
  W = [f*S*exp(-0.1*S) 0.8*V(:,1)  0.6*v(:,2) ];
end