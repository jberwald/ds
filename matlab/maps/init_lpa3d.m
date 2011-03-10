function mapobj = init_lpa3d

  mapobj = struct;
  mapobj.params = ...
	  [
		  7.876;		% b  
		  0.01385;		% cel
		  0.01114;		% cea
		  0.35;			% cpa
		  0.1613;		% ul 
		  0.96;			% ua 
	  ];

  mapobj.mapfunc = @(params) the_map(params);
  mapobj.boxfunc = @(params) get_box(params);

end


function [center radius] = get_box(params)
  % the following is phenomenally stupid 
  max = 400;
  center = [max/2 max/2 max/2];  
  radius = [max/2 max/2 max/2];  
end


function map = the_map(params)
% LPA map

  b   = params(1);
  cel = params(2);
  cea = params(3);
  cpa = params(4);
  ul  = params(5);
  ua  = params(6);
  
  map = @(v) [ b * v(3) * exp( -cel * v(1) - cea * v(3) ) ...
			   (1 - ul) * v(1) ...
			   v(2) * exp( -cpa * v(3) ) + (1 - ua) * v(3) ];
end

