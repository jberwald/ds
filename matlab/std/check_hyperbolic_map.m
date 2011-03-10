
function y = check_hyperbolic_map(n,S,map)

%
% function check_hyperbolic(n,x)
%
% This function checks to see if a periodic orbit of the standard map of
% period n is hyperbolic or not at the point x = (x(1),x(2)). Outputs 1 
% if it is, 0 if it is not.
%
  
  y = 1;
  b = map.tree.boxes(-1);
  for s = S(:)'
    y = check_hyperbolic(n,b(1:2,s),map.params);
    if ~y
      return
    end
  end
  return
