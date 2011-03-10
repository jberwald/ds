
function grow_iso_insert(map)

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
% 4. compute new P using the interval images
%
% stop when no new boxes (since then o(I) and F(I) are already in the tree)
%

  boxes = map.tree.boxes(-1);
  ImgCell = interval_images(map.map,boxes);

  ctr = 0;

  while 1
	ctr = ctr + 1;

	% step 1
	disp('step 1')

	I = graph_mis(map.P);
	fprintf('I has %i boxes\n',length(I));

	% step 2
	disp('step 2')

	S_boxes = map.tree.boxes(-1);			% save for later
	insert_onebox(map.tree, S_boxes, I);	% add o(I)
	insert_image(map.tree, ImgCell, I);	    % add F(I)
	boxes = map.tree.boxes(-1);
	S = search_boxes(map.tree,S_boxes);	    % tree has changed; get new numbers

	if (mod(ctr,10) == 0)
	  showraf(S_boxes','g','g');
	  showraf(S_boxes(:,I)','b','b');
	  showraf(scale_boxes(boxes(:,S),0.4)','m','m');
	  disp('[Press a key]')
	  pause
	end


	% step *
	disp('step *')

	n = map.tree.count(-1);				% number of boxes
	new_boxes = setdiff(1:n,S);			% boxes just added to the tree
	if (isempty(new_boxes))				% no new boxes
	  return
	end
	
	fprintf('there are %i new boxes\n',length(new_boxes));


	% step 3
	disp('step 3')


%%% ERROR IS HERE:
	ImgCell(S,:) = ImgCell;				% put old images in the right places
%%%

	ImgCell = interval_images(map.map, boxes, new_boxes, ImgCell);
%    ImgCell(n,:) = {[] []};

	% step 4 (to be optimized...)
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

	%%% SANITY CHECK

	disp('sanity check:')
	all(all(P(S,S) == map.P))

	map.P = P;

  end

end

