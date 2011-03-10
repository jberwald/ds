function [s t] = num2edge(v,n)
% function E = num2edge(v,n)
% function [s t] = num2edge(v,n)
% converts a number v to an edge [v%n v/n]

  n = n+1;								% nums go up to n
  if nargout <= 1
	if (size(v,1) > size(v,2))			% col vec
	  v = v';
	end
	s = [mod(v,n); fix(v/n)];
  else
	s = mod(v,n);
	t = fix(v/n);
  end
