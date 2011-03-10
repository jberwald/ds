function [map data] = std_newconns(eps,depth,iterations,opts)

  if nargin < 4, opts = struct; end

  depth = 2*depth;
  map = get_map('std',2,'params',eps);
  
  e = map.params
  f = @(v) mod([v(1) + v(2) + (e/(2*pi))*sin(2*pi*v(1)); v(2) + (e/(2*pi))*sin(2*pi*v(1))],1);
  finv = @(v) mod([v(1) - v(2); v(2) - (e/(2*pi))*sin(2*pi*(v(1)-v(2)))],1);
  
  map.tree = crop_tree(map.tree);

  q = 2^(-depth);
  [x1 y1 x2 y2] = draw_invariant_manifolds2(map.params,depth);

  ints = {[0.5; y1] [.5; 1-y1] [x2; y2] [1-x2; 1-y2]};  % intersections
  fpts = {[q;q] [1-q;q] [q;1-q] [1-q;1-q]};

  forward_points = {
	  ints{1} fpts{2};
	  ints{3} fpts{2};
	  ints{2} fpts{3};
	  ints{4} fpts{3};
				   };

  backward_points = {
	  fpts{1} ints{1};
	  fpts{1} ints{3};
	  fpts{4} ints{2};
	  fpts{4} ints{4};
					};

  points = [];
  sensitivity = 0.00001
  for i=1:size(forward_points,1)
	[map.tree p] = insert_iterates_smart(map.tree, f, forward_points{i,1}, iterations, ...
										 depth, forward_points{i,2}, sensitivity);
	points = [points p];
  end
  for i=1:size(backward_points,1)
	[map.tree p] = insert_iterates_smart(map.tree, f, backward_points{i,1}, iterations, ...
										 depth, backward_points{i,2}, sensitivity);
	points = [points p];
  end

  for i = 1:length(fpts)
	map.tree.insert_box(fpts{i}, [sensitivity;sensitivity], map.tree.depth);
  end
  map.P = rigorous_matrix(map);



  if isfield(opts,'imgname')
	boxes = map.tree.boxes(-1);
	I = graph_mis(map.P);
	bigboxes = boxes;
	bigboxes(3:4,:) = bigboxes(3:4,:)*256;
	showraf(bigboxes','g','g');
	showraf(bigboxes(:,I)','b','b');
  end

  

%  disp('growing invariant set...')
%  map = grow_ip_insert(map,opts);
%  disp('computing symbolics...')
%  data = compute_symbolics(map.I,map,{'noims'});
  data.points = points;
