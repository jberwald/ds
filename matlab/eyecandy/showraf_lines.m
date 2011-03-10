function h=showraf_lines(b, height, ecol)

for k = 1:size(b,1)
  center = b(k,1:2);
  radius = b(k,3:4);

  M = [center' - radius'...
	   center' + [radius(1); -1*radius(2)] ...
	   center' + radius' ...
	   center' + [-1*radius(1); radius(2)]; ...
	   repmat(height,1,4) ];
  h = line(M,M(:,[2 3 4 1]));
end
%h = surfc(x(:),y(:),z(:),'Edgecolor',ecol);
