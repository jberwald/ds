
function [map ImgCell performance] = grow_ip_insert(map,num_steps,ImgCell)
% function [map ImgCell performance] = grow_ip_insert(map,num_steps,ImgCell)

%=============================================================================
%      GENERAL STRATEGY:
%=============================================================================
%
% S = boxes so far
% I = invariant set so far
% P = transition matrix so far
%
% 1. compute I from P
% 2. add o(I) \cup F(I) to tree
% *. stop if no new boxes
% 3. compute interval images of new boxes
% 4. compute new P using the interval images (OPTIMIZE)
%
% stop when no new boxes (since then o(I) and F(I) are already in the tree)
%

performance = [];

  boxes = map.tree.boxes(-1);
  if (nargin < 3)
	ImgCell = interval_images(map.map,boxes);
  end

  ctr = 0;

  while 1
	ctr = ctr + 1;

	% step 1
	disp('step 1')

	S_boxes = map.tree.boxes(-1);			% save for later
	I = graph_mis(map.P);
	oI = get_nbhd(map.tree, I, map.tree.depth);
	fprintf('I has %i boxes\n',length(I));
	fprintf('oI has %i boxes\n',length(oI));

	if (mod(ctr,num_steps) == 0)
	  disp(performance)

	  close
	  showraf(S_boxes','g','g');
	  showraf(S_boxes(:,oI)','m','m');
	  showraf(S_boxes(:,I)','b','b');
	  
%	  return
%	  showraf(scale_boxes(boxes(:,S),0.4)','m','m');

      saveas(gcf,sprintf('std-970-971-%d', ctr/num_steps),'png')

%	  disp('[Press a key]')
%	  pause

	end

	% step 2
	disp('step 2')

tic

% ~quadratic.  To optimize, only 'insert' boxes that aren't already in; or at
% least, only insert boxes on the boundary of I (and not I itself again)

['use wrap_interval (in std_map) or some more general function, to compute the' ...
 ' onebox and image']

t = cputime;
	map = insert_onebox(map, S_boxes, I);	% add o(I)
performance(end+1,1) = cputime - t;

% ~quadratic.  To optimize, take oI \ I?  The notation is a bit confusing
% here... I guess oI is the old o(I)?  Careful here.
t = cputime;
	insert_image(map.tree, ImgCell, oI);	% add F(o_t(I))
performance(end,2) = cputime - t;

% Negligible
t = cputime;
	boxes = map.tree.boxes(-1);
performance(end,3) = cputime - t;

% ~quadratic.  To optimize, I fear that I'd have to change the underlying
% data structure, since once the box numbers have changed, I really do have
% to search EVERY box to get the new numbers.
t = cputime;
	S = search_boxes(map.tree,S_boxes);	    % tree has changed; get new numbers
performance(end,4) = cputime - t;

% Negligible
t = cputime;
	n = map.tree.count(-1);				% number of boxes
	new_boxes = setdiff(1:n,S);			% boxes just added to the tree
performance(end,5) = cputime - t;

	fprintf('there are %i new boxes\n',length(new_boxes));
toc
	if (isempty(new_boxes))				% no new boxes
	  disp('computing the adjacency matrix and invariant set...')
	  map.Adj = torus_adj_matrix(map.tree, map.tree.depth);
	  map.I = graph_mis(map.P);
	  return
	end
	


	% step 3
	disp('step 3 (a)')
	ImgCell(S,:) = ImgCell;				% put old images in the right places
	disp('step 3 (b)')

tic
	ImgCell = interval_images(map.map, boxes, new_boxes, ImgCell);
toc

	% step 4
	%
	% OPTIMIZATION POSSIBILITIES
	%  - lower the number tree searches, by keeping track of when an image is
    %  completely in the tree (then you don't need to call search for it ever
    %  again).  in fact, this seems guaranteed, since the image of I is
    %  always added to the tree.
	
	disp('step 4')

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

  end

end


function scrap

	if (mod(ctr,10) == 0)
	  showraf(S_boxes','g','g');
	  showraf(S_boxes(:,I)','b','b');
	  showraf(scale_boxes(boxes(:,S),0.4)','m','m');
	  disp('[Press a key]')
	  pause
	end

	%%% SANITY CHECK
	disp('sanity check:')
	all(all(P(S,S) == map.P))

end
