function [map ImgCell timemat] = grow_ip_insert(map,opts)
% function [map ImgCell] = grow_ip_insert(map,opts)
%
%=============================================================================
%      GENERAL STRATEGY:
%=============================================================================
%
% S = boxes so far
% I = invariant set so far
% P = transition matrix so far
%
% while there are new boxes:
% 1. compute interval images of new boxes
% 2. compute new P using the interval images, new Adj (OPTIMIZE)
% 3. compute I from P, Adj using grow_iso
% 4. add o(I) \cup F(o(I)) \cup F^{-1}(o(I)) to tree
%

  if nargin < 2, opts = struct; end

  boxes = map.tree.boxes(map.tree.depth);
  numsteps = (nargin < 2)*100000 + 1;

  ImgCell = {};
  PreCell = {}; % preimages

  numsteps = 5;
  timemat = zeros(1,numsteps);
  step = 0;
  t = cputime;
  
  ctr = 0;
  n = size(boxes,2);
  S = [];
  I = 1:n;
  %  I = map.I;  %2/20/2010
  new_boxes = 1:n;


  % todo: clean up the variables: boxes + S_boxes, I, S, etc... make sure
  % they have clear invariants associated with them


  while ~isempty(new_boxes)
	ctr = ctr + 1;
	fprintf('iteration %d: %i new boxes\n', ctr, length(new_boxes)), tic
	
	% step 1: compute interval images
	ImgCell(S,:) = ImgCell;				% put old images in the right places
	PreCell(S,:) = PreCell;				% put old images in the right places
	ImgCell = interval_images(map.map, boxes, new_boxes, ImgCell);
	PreCell = interval_images(map.inverse, boxes, new_boxes, PreCell);

    [step t timemat] = printstep(step,t,timemat,numsteps);

	% step 2: compute P using the images 
	P = sparse(n,n);     					% Initialize transition matrix
	for i = 1 : n
	  [center radius] = ImgCell{i,:};
	  img = [];
	  for c = 1 : size(center, 2)
		img = union(img, map.tree.search_box(center(:,c), radius(:,c)) );
	  end
	  P(img,i) = 1;
	end
	map.P = P;
	map.Adj = adj_matrix(map);

    [step t timemat] = printstep(step,t,timemat,numsteps);

	% step 3: compute I from P, Adj
	S_boxes = map.tree.boxes(map.tree.depth);			% save for later
	I = grow_iso_raf(I,map.P,map.Adj);
	oI = onebox(I,map.Adj);
	fprintf(' I has %i boxes (%3.1f%%)\n',length(I), percentfull(I,map.tree.depth));
	fprintf(' oI has %i boxes (%3.1f%%)\n',length(oI), percentfull(oI,map.tree.depth));

    [step t timemat] = printstep(step,t,timemat,numsteps);

    if (isfield(opts,'imgname') && mod(ctr,numsteps) == 0)
	  draw(S_boxes, I, oI, ctr/numsteps, opts.imgname)
	end

	disp(' inserting next layer... ')
	% step 4: adding image, preimage, and neighborhood boxes
	map = insert_onebox(map, S_boxes, I);	% add o(I)
	insert_image(map.tree, ImgCell, oI);	% add F(o_t(I))
	insert_image(map.tree, PreCell, oI); 	% add F^{-1}(o_t(I))

    [step t timemat] = printstep(step,t,timemat,numsteps);

	% step 5: bookkeeping
	boxes = map.tree.boxes(map.tree.depth);
	S = search_boxes(map.tree,S_boxes);	    % tree has changed; get new numbers
	I = S(I); 							% new numbers for I
	n = map.tree.count(map.tree.depth);	% number of boxes
	new_boxes = setdiff(1:n,S);			% boxes just added to the tree

    [step t timemat] = printstep(step,t,timemat,numsteps);
    timemat = [timemat; zeros(1,step)];
  end

  
  disp('computing the adjacency matrix and invariant set...')
  %  sinv = invperm(S);
  %  map.P = P(sinv,sinv);
  map.Adj = adj_matrix(map);
  map.I = I;
  
end

function [s t T] = printstep(s,t,T,n)
  s = mod(s, n) + 1;
  fprintf('  step %i: %.2f\n', s, cputime-t)
  T(end,s) = cputime-t;
  t = cputime;
end

function draw(boxes, I, oI, ctr, imgname)

  close
  showraf(boxes','g');
  showraf(boxes(:,oI)','m');
  showraf(boxes(:,I)','b');
  set(gca,'xlim',[0 1])
  set(gca,'ylim',[0 1])
  saveas(gcf,sprintf('%s-grow-ip-insert-%d', imgname, ctr),'png')
  
  close
  boxes = shift_boxes(boxes,0.5,1);
  boxes = shift_boxes(boxes, -0.5);
  showraf(boxes','g');
  showraf(boxes(:,oI)','m');
  showraf(boxes(:,I)','b');
  set(gca,'xlim',[-0.5 0.5])
  set(gca,'ylim',[-0.5 0.5])
  saveas(gcf,sprintf('%s-grow-ip-insert-slid-%d', imgname, ctr),'png')
  
end

function p = percentfull(S,depth)
  p = 2^(log(length(S))/log(2)-depth)*100;
end
