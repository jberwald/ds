function [center radius] = map_box_int(box,interval_map)
% function [center radius] = map_box_int(box,interval_map)
%   center, radius are column vectors

  d = (size(box,1)-2)/2;
  v = box2intval(box(1:d),box(d+1:2*d));  % convert to intervals
  I = interval_map(v);       			% image of the box under the map

  center = zeros(d,size(I,1));
  radius = zeros(d,size(I,1));
  
  for i = 1 : size(I,1)					% number of boxes returned
	[ctr rad] = intval2box(I(i,:));		% convert back to a box
	center(:,i) = ctr;
	radius(:,i) = rad;
  end
