
function goods = goodEdges(lef,E,t)
% function goods = goodEdges(lef,E,t)
%   E in numeric ids return all [u t] s.t. u in lef.SM(t) but [E; [t u]] not >=
%   some E2 in lef.BES
%
%   to enum good edges, pick u in lef.SM(t) and check that no E' in lef.BES with
%   [t u] in E' satisfies E' <= [E; t u]. (we know that E' not <= E, since E is
%   not bad, so it must be the contribution of [t u])
%

  imgt = mapimage(lef.SMpolygen,t); % image of vertex t
  edges = edge2num([repmat(t,length(imgt),1) imgt'], lef.n)'; % image as edges
%  imgt = intersect(mapimage(lef.SM,t), lef.ProbR);
%  edges = arrayfun(@(i) edge2num([t i],lef.n), imgt);

  goods = [];
  for edge = edges
	isgood = 1;
	for E2 = lef.bad_edge_sets
	  E2 = E2{:};						% get the actual vector
	  if (ismember(edge, E2) && subset(E2, [E edge]))
%		realedge = num2edge(edge,lef.n);
%		fprintf('edge [%d %d] is no good\n',realedge(1),realedge(2))
		isgood = 0;
		break; 							% edge leads to a bad edge set
	  end
	end
	if isgood==1	  
	  goods = [goods edge];
	end
  end

