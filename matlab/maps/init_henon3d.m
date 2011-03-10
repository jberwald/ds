function mapobj = init_henon3d

  mapobj = struct;
  mapobj.params = [
	  -0.25 %alpha
	  -0.3 %tau
	  0.44 %a
	  0.21 %b
	  0.35 %c
				  ];
  mapobj.mapfunc = @(params) (@(v) the_map(v,params(1),params(2),params(3),params(4),params(5)));
  mapobj.invfunc = @(params) (@(v) inv_map(v,params(1),params(2),params(3),params(4),params(5)));
  mapobj.boxfunc = @(params) get_box(params);
  mapobj.space = 'Rn';

  mapobj.h1 = [0.09328969638117 1.38262210725499 -1.05758672817841]';
  mapobj.h2 = [1.48411783879203 -0.96648136242881 -0.11119773311362]';
  mapobj.h3 = [-0.80181693411610 -0.00500156011210 1.23894147655738]';
  mapobj.h4 = [0.11392233001002 -0.76125575437453 1.08244794544553]';
  mapobj.h5 = [0.93875066517793 0.29087100401361 -0.79850180982201]';
  mapobj.h6 = [-0.85017247375410 0.91798993912281 0.36765082474070]';
  mapobj.p0 = [0.67201532544553, 0.67201532544553, 0.67201532544553]';
  mapobj.p1 = [-0.37201532544553, -0.37201532544553, -0.37201532544553]';

end

function [center radius] = get_box(params)
  center = [.15 .15 .15];
  radius = [1.5 1.5 1.5];
end

function f = the_map(x, alpha, tau, a, b, c)
  f1 = alpha + tau*x(1) + x(3) + a*x(1)*x(1) + b*x(1)*x(2) + c*x(2)*x(2);
  f2 = x(1);
  f3 = x(2);
  f=[ f1,f2,f3];
end

function f = inv_map(x, alpha, tau, a, b, c)
  f1 = x(2);
  f2 = x(3);
  f3 = -alpha + x(1) - tau*x(2) - a*x(2)*x(2) - b*x(2)*x(3) - c*x(3)*x(3);
  f=[ f1, f2, f3];
end

