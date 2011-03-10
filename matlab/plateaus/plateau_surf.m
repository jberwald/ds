function h = plateau_surf(tree, R_plat, entvec, resolution)
% h = plateau_surf(tree, R_plat, entvec, resolution)
% tree is the tree for the plateaus: tree = Tree('plateaus/zinarai.tree')

if nargin==2							% only entropies and resolution entered
  entvec = tree;
  resolution = R_plat
  tree = Tree('plateaus/zinarai.tree')
  load plateaus/repdat
  load ../thesis/good_plats
  R_plat = R_plat(good_plats)
end

%colors = colormap;
top_offset = 0.01;

boxes = tree.boxes(-1);

centers = boxes(1:2,:);
radii = boxes(3:4,:);

x_real = min(centers' - radii')'
y_real = max(centers' + radii')'


minrad = min(radii')' * resolution;					% min goes down cols
for i=1:2
  centers(i,:) = centers(i,:)/minrad(i);
  radii(i,:) = radii(i,:)/minrad(i);
end

origin = (tree.center - tree.radius)'./minrad - 1 % off-by-1

x_int = floor(min(centers' - radii'))'
y_int = ceil(max(centers' + radii'))'

Z = zeros(y_int(1)-x_int(1), y_int(2)-x_int(2));

figure
hold on

X = [];
Y = [];
E = [];
for r = 1:length(R_plat)

  plateau = R_plat{r};
  entropy = entvec(r);

  for b = 1:length(plateau)

	center = centers(:,plateau(b));
	radius = radii(:,plateau(b));
	x = floor(center - radius - origin);
	y = ceil(center + radius - origin);

	X = [X x];
	Y = [Y y];
	E(end+1) = entropy;
	Z(x(1):y(1), x(2):y(2)) = entropy - top_offset;

%	showraf_height([(x+y)/2;(y-x)/2]', entropy, 'm', 'none');

  end
end

[i j] = find(Z);
Z = Z(min(i):max(i), min(j):max(j));
x = interpolate(x_real(1), ...
				y_real(1), size(Z,1)); % surf is weird
y = interpolate(x_real(2), ...
				y_real(2), size(Z,2));
h = surf(x,y,Z');
shading interp
axis tight

%for i = 1:size(X,2)
%  x = X(:,i);
%  y = Y(:,i);
%  entropy = E(i);
%  showraf_height([(x+y)/2;(y-x)/2]', entropy, 'm', 'm');
%end

for r = 1:length(R_plat)
%  c = ceil(entvec(r)*length(colors)/max(entvec));
  showraf_height(boxes(:,R_plat{r})',entvec(r), 'r', 'k');
%  showraf_lines(boxes(:,R_plat{r})',entvec(r));
end

grid on

end



function v = interpolate(a,b,n)
  if (n > 1)
	v = a : (b-a)/(n-1) : b;
  else
	v = a;
  end
end
