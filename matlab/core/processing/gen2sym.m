function G = gen2sym(tree,filename,regions)
% function G = gen2sym(tree,filename,regions)
% output: cell array G so that G{r} lists the generators for region r

  cubes = parsegens(filename);
  G = {};

  b = tree.boxes(-1);
%  show2(b(:,cat(2,regions{:}))','g');

  for i = 1:length(cubes)

	boxes = cub2box(tree,cubes{i});
  
	k_g = length(boxes);
	k_r = length(regions);
	G{i} = cell(1,k_r);

	for g = 1 : k_g

%	  show2(scale_boxes(b(:,boxes{g}),0.8)','b');
  
	  regions_found = 0;

	  for r = 1 : k_r
		if (~disjoint(boxes{g}, regions{r}))
		  G{i}{r} = [G{i}{r} g];;				% append the generator
		  regions_found = regions_found + 1;
		end
	  end

	  if (regions_found ~= 1)
		boxes{g}
		show2(scale_boxes(b(:,boxes{g}),0.8)','r');

		disp('*****************************************')
		disp('*****************************************')
		fprintf('***  GENERATOR %d HAS %d REGIONS\n',g,regions_found);
		disp('*****************************************')
		disp('*****************************************')
	  end
	end
  end
  
