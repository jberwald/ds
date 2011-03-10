function map = insert_connections(map, C, depth, opts)
% function map = insert_connections(map, C, depth, opts)
%
% map - map object
% C - cell array of connections: {x1 y1; x2 y2; ...}
%     where xi -> yi, and xi, yi are column vectors
% depth - final depth to stop
%

  delflag = 1;
  divflag = 8;

  points = unique(cell2mat(C(:)')','rows')'; % the points we need
  imgctr = 1;

  for d = map.depth : depth

	% see if the current tree has all the right connections
	[S failedpaths] = connection_set(map,C,opts);
	if isfield(opts,'imgname'), imgctr = draw(map,C,S,imgctr,opts.imgname); end

	% while some connection is not there, add a onebox neighborhood and try again
	while any(failedpaths)
	  fprintf('there were %d cut paths:',sum(failedpaths))
	  fprintf(' %d',find(failedpaths))
	  fprintf('\n')

	  map = insert_onebox(map);
	  map.P = rigorous_matrix(map);
	  [S failedpaths] = connection_set(map,C,opts);

	  if isfield(opts,'imgname'), imgctr = draw(map,C,S,imgctr,opts.imgname); end
	end
	fprintf('total connection length: %d\n',length(S))

	% beef it up a bit, since we will probably end up adding 2 layers anyway
	S = get_nbhd(map.tree,S,-1);
	S = get_nbhd(map.tree,S,-1);

	% keep only the connections and remove all other boxes
	inv_bits = repmat('0',[1 size(map.P,1)]);
	inv_bits(S) = '1';
	map.tree.unset_flags('all',delflag);
	map.tree.set_flags(inv_bits,delflag); 	% flag boxes in S
	map.tree.remove(delflag);				% remove non-flagged boxes

	fprintf('depth = %d   count = %d\n', map.tree.depth, map.tree.count(-1));

	disp('computing the map...')

	% go to a higher depth
	if d < depth
	  for j = 1 : map.tree.dim
		map.tree.set_flags('all', divflag);
		map.tree.subdivide;
	  end
	  map.depth = map.depth + 1;
	end

	fprintf('depth = %d   count = %d\n', map.tree.depth, map.tree.count(-1));

	% compute the map on the new boxes
	map.P = rigorous_matrix(map);
  end
  
  disp('computing the adjacency matrix and invariant set...')
  map.Adj = adj_matrix(map);
  map.I = graph_mis(map.P);

  if isfield(opts,'imgname'), imgctr = draw(map,C,map.I,imgctr,opts.imgname); end
end


function imgctr = draw(map,C,S,imgctr,imgname)
  if nargin < 4
	imgctr = 1;
  end

   close
   boxes = map.tree.boxes(-1);
   showraf(boxes','g','g');
   showraf(boxes(:,S)','b','b');
   set(gca,'xlim',[0 1])
   set(gca,'ylim',[0 1])
   saveas(gcf,sprintf('%s-homoclinic-insertion-%d', imgname, imgctr),'png')

  close
  boxes = shift_boxes(boxes, 0.5, 1);
  showraf(boxes','g','g');
  showraf(boxes(:,S)','b','b');
  hold on

  C = mod(cell2mat(C(:)')+0.5, 1); % convert pts to a matrix and shift
  plot(C(1,:)',C(2,:)','k*');

  set(gca,'xlim',[0 1])
  set(gca,'ylim',[0 1])
  saveas(gcf,sprintf('%s-homoclinic-insertion-slid-%d', imgname, imgctr),'png')
  imgctr = imgctr + 1;
end
