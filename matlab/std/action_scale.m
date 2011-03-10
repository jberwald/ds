function P = action_scale(map,offset)

  if isintval(map.params)
	epsilon = (inf(map.params) + sup(map.params)) / 2;
  else
	epsilon = map.params;
  end

  P = map.P;
  b = map.tree.boxes(-1);
  %  epsterm = epsilon * cos(2*pi*boxes(1,:)) / (4*pi);

  % unvectorized for now:
  [i j] = find(P);

  action = (b(1,i) - b(1,j)).^2 / 2 - (epsilon/(4*pi^2)) * cos(2*pi*b(1,i));

  % want all paths of length k to have less weight than any of length k+1
  % so k(1+eps/4pi^2+C) = max weight(k) < min weight(k+1) = (k+1)(C-eps/4pi^2)
  % thus we must have C > k + (2k+1) eps/4pi^2
  % not knowing k, we use k < n and take
  % C = n + (2n+1) eps/4pi^2
%  fprintf('action stats: min %.4f max %.4f mean %.4f std %.4f\n',min(action),max(action),mean(action),std(action))
  if nargin < 2
	L = 100;							% estimate of the longest path
	offset = L + (2*L+1) * epsilon / (4 * pi^2);
  else
	minact = min(action);
	if minact < 0
	  offset = offset - minact;			% make them positive at least...
	end
  end
%  fprintf('using offset %d\n',offset)
  P = sparse(i, j, action + offset);

