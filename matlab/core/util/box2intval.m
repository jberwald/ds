function I = box2intval(center,radius)

  I = [intval(0)];
  
  for j = 1:length(center)
	% Gets the box in terms of its intervals:
	I(j) = infsup((center(j)-radius(j)), (center(j)+radius(j)));
  end
