function h=showraf(b, col, ecol)

if nargin < 3
  ecol = col;
end

ix=1;
iy=2;
d=2;
 
x = [b(:,ix)-b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)-b(:,ix+d)];
y = [b(:,iy)-b(:,iy+d) b(:,iy)-b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)+b(:,iy+d)];
h = patch(x',y',col','EdgeColor',ecol');
