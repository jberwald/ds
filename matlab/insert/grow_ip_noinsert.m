function [map ImgCell] = grow_ip_insert(map,I,opts)
% function [map ImgCell] = grow_ip_insert(map,I,opts)
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

  boxes = map.tree.boxes(-1);
  numsteps = (nargin < 2)*100000 + 1;

  ImgCell = {};
  PreCell = {}; % preimages

  ctr = 0;
  n = size(boxes,2);
  map.P = sparse(n,n);
  map.Adj = sparse(n,n);
  new_boxes = I;
  curr_boxes = [];

  
  
  while ~isempty(new_boxes)
	ctr = ctr + 1;
	disp(' . ')
	fprintf('iteration %d: %i new boxes\n', ctr, length(new_boxes)), tic
	

	
	% step 1: compute interval images
	disp('step 1')
	ImgCell = interval_images(map.map, boxes, new_boxes, ImgCell);
%	PreCell = interval_images(map.inverse, boxes, new_boxes, PreCell);
	

	
	
	
	% step 2: add new entries to P using the images 
	disp('step 2')
	for i = new_boxes
	  [center radius] = ImgCell{i,:};
	  img = [];
	  for c = 1 : size(center, 2)
		img = union(img, map.tree.search_box(center(:,c), radius(:,c)) );
	  end
	  map.P(img,i) = 1;
	end
	map.Adj = map.Adj + adj_matrix(map,map.tree.depth,new_boxes);


	
	% step 3: compute I from P, Adj
	disp('step 3')
	tic
	
%	P = map.P(curr_boxes,curr_boxes);
	I = grow_iso_raf(I,map.P,map.Adj);
	oI = onebox(I,map.Adj);


	
	fprintf(' I has %i boxes (%3.1f%%)\n',length(I), percentfull(I,map.tree.depth));
	fprintf(' oI has %i boxes (%3.1f%%)\n',length(oI), percentfull(oI,map.tree.depth));
	if (isfield(opts,'imgname') && mod(ctr,numsteps) == 0)
	  draw(boxes, I, oI, ctr/numsteps, opts.imgname)
	end


	
	
	
	% step 4: adding image, preimage, and neighborhood boxes
	disp('step 4')
	fprintf(' '), toc, fprintf(' inserting next layer... '), tic
	FoI = mapimage(map.P,oI);
	new_boxes = setdiff(union(FoI,oI),curr_boxes);			% new images to compute
	curr_boxes = [curr_boxes new_boxes];
	
	toc
  end

  
  disp('computing the adjacency matrix and invariant set...')
%%  map.Adj = adj_matrix(map);
  map.I = I;

end

function draw(S_boxes, I, oI, ctr, imgname)
   close
%    show3(S_boxes','g',3,[1 2 3],'g');
% %   show3(S_boxes(:,oI)','m','m');
%    show3(S_boxes(:,I)','b',3,[1 2 3],'b');
% %   set(gca,'xlim',[0 1])
% %   set(gca,'ylim',[0 1])
%    saveas(gcf,sprintf('ims/%s-grow-ip-insert-%d', imgname, ctr),'png')
  
%   close
  S_boxes2 = shift_boxes(S_boxes,0.5,1);
  showraf(S_boxes2','g','g');
  showraf(S_boxes2(:,oI)','m','m');
  showraf(S_boxes2(:,I)','b','b');
  set(gca,'xlim',[0 1])
  set(gca,'ylim',[0 1])
  saveas(gcf,sprintf('ims/%s-grow-ip-insert-slid-%d', imgname, ctr),'png')
  
%	  disp('[Press a key]')
%	  pause
end

function p = percentfull(S,depth)
  p = 2^(log(length(S))/log(2)-depth)*100;
end
