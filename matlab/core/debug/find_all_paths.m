%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% find_all_paths
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function paths = find_all_paths(P, s, t, path)
  if (nargin < 4), path = []; end;
  
  path = [path s];
  if (s == t)
	paths = {path};
	return;
  end
  
  paths = {};  
  for node = find(P(:,s))'
	if (~ismember(node,path))
	  newpaths = find_all_paths(P, node, t, path);
      paths = {paths{:} newpaths{:}};
	end
  end
end
