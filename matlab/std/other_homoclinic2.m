
function [x y] = other_homoclinic(x1, y1, stablex, stabley, unstablex, unstabley, epsilon)
%
% function [x y] = other_homoclinic(x1, y1, stablex, stabley,unstablex, unstabley, epsilon)
%
% This function computes the other "main" homoclinic orbit which is not 
% the one when x = .5 given the stable and unstable manifolds and the first
% homoclinic intersection.
%

right = x1 + y1 +epsilon*sin(x1);
start = (x1 + right)/2;

i = 1;
j = 1;

while (unstablex(i) < start)
  i = i + 1;
end

while (unstablex(j) < right)
  j = j + 1;
end

for k = i : j

  n = 1;
  while (stablex(n) > unstablex(k))
     n = n + 1;
  end
  height = stabley(n) - unstabley(k);
  if (height <= 0)
     x = (unstablex(k-1)+unstablex(k-2))/2;
     y = (unstabley(k-1)+unstabley(k-2))/2;
     return
  end

end
