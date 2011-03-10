function [map points] = insert_attractor(map,p,iter,rad,depth,start_iter)
% function [map points] = insert_attractor(map,p,iter,rad,depth,start_iter)
% insert an attractor at some depth
% map - map object
% p - starting point (/row/ vector)
% iter - how many iterates to take for the attractor
% rad - radius of boxes around each point to insert
% depth - depth to insert (in 'map' space, not tree space)
% start_iter - optional; iterate this many times before inserting
%
  if nargin < 5
    start_iter = 50;
  end
  if nargout > 1
    points = zeros(iter,length(p));
  end
  
  for i = 1:start_iter
    p = map.map(p);
  end
  
  if nargout > 1
    for i = 1:iter
      map.tree.insert_box(p',rad',map.tree.dim*depth);
      points(i,:) = p;
      p = map.map(p);
    end
  else
    for i = 1:iter
      map.tree.insert_box(p',rad',map.tree.dim*depth);
      p = map.map(p);
    end
  end
  