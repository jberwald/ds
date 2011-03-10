function h=showraf_height(b, height, col, ecol)

ix=1;
iy=2;
d=2;

x = [b(:,ix)-b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)+b(:,ix+d) b(:,ix)-b(:,ix+d)];
y = [b(:,iy)-b(:,iy+d) b(:,iy)-b(:,iy+d) b(:,iy)+b(:,iy+d) b(:,iy)+b(:,iy+d)];
z = repmat(height,size(y));

h = patch(x',y',z',col,'EdgeColor',ecol);
%h = surfc(x(:),y(:),z(:),'Edgecolor',ecol);
