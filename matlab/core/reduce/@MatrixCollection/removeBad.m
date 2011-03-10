function matcol = removeBad(matcol,E)
% function matcol = removeBad(matcol,E)
%   remove all entries in matcol with edge set containing E
%   this is only for optimization (not used often in practice though :/)
%   uses numeric ids

  for s = 1:matcol.n
	for t = 1:matcol.n
	  kill_list = [];
	  for i = 1:size(matcol.C{s,t},1)	% all rows (entries)
		if (subset(E,matcol.C{s,t}{i,1})) % bad edge set within
		  kill_list(end+1) = i;			% eliminate newly tainted entry
		end
	  end
%	  if ~isempty(kill_list)
%		disp('pruned search in removeBad')
%	  end
	  matcol.C{s,t}(kill_list,:) = [];
	end
  end
