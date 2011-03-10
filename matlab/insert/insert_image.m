function tree = insert_image(tree, Imgs, S, flag)
% function tree = insert_image(tree, Imgs, S, flag)
% function tree = insert_image(tree, Imgs, S)
% function tree = insert_image(tree, Imgs)

  if (nargin < 3)
	S = 1 : size(Imgs,1);
  end

  if nargin < 4
	flag = 2;
  end

  for i = S
	[center radius] = Imgs{i,:};
	for c = 1 : size(center, 2)
	  tree.insert_box(center(:,c), radius(:,c), tree.depth, flag);
	end
  end
end
