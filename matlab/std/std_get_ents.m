function [ents syms deps] = std_get_ents(epsilons,depths,plotp)
% function ents = std_get_ents(epsilons,depths,plotp)
% E = std_get_ents([0.7:0.001:0.999 1.0:0.005:2.03],8:13,1);
  ents = zeros(size(epsilons));
  syms = zeros(size(epsilons));
  deps = zeros(size(epsilons));
  for i = 1:length(epsilons)-1
	width = round(1000*epsilons(i+1) - 1000*epsilons(i));
	for d = depths
	  fname = sprintf('stdoutput/std_%1.3f_d%i_%03.0f',epsilons(i),d,width);
	  fname = [strrep(fname,'.','p') '.mat'];

	  %	  if (exist(fname,'file'))
	  try
		load(fname);
		ent = log_max_eig(dat.SM{2});
		sym = length(graph_mis(dat.SM{2}));
		if ent > ents(i)
		  ents(i) = ent;
		  syms(i) = sym;
		  deps(i) = d;
		  fprintf('%s: %.4f %d\n',fname,ent,sym)
		end
	  end
	end
  end

  if nargin > 2 && plotp
	std_plot_ents(epsilons,ents,syms,deps);
  end

