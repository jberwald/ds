function h=showraf_surf(b, height, col, ecol, fcol)

ix=1;
iy=2;
d=2;

cx = b(:,ix);
rx = b(:,ix+d);
cy = b(:,iy);
ry = b(:,iy+d);

x = [cx-rx cx+rx cx+rx cx-rx cx-rx];
y = [cy-ry cy-ry cy+ry cy+ry cy-ry];
%z_max = repmat(height,size(y));
%z_min = zeros(size(y));
%x = [x;x];
%y = [y;y];
%z = [z_max;z_min];

%h = patch(x',y',z',col','EdgeColor',ecol);
%h = surf(x,y,z,'Edgecolor',ecol);

for i = 1:size(b,1)
%  if (rx(i)^2 + ry(i)^2 > 0.001)
	h = drawbar(x(i,:), y(i,:), height, ecol, fcol);
%  end
end

end

function h=drawbar(X,Y,z,ecol,fcol)
  Z = [repmat(z,size(X)); zeros(size(X))];
  h = surf([X;X],[Y;Y],Z,'EdgeColor',ecol);
  hold on
end
