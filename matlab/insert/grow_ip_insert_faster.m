function [map ImgCell timemat] = grow_ip_insert_faster(map,opts)
% function [map ImgCell] = grow_ip_insert_faster(map,opts)
%
%=============================================================================
%      GENERAL STRATEGY:
%=============================================================================
%
% S = all boxes in the tree so far
% I = invariant set so far
% P = transition matrix so far
%
% while there are new boxes:
% 1. compute interval images of new boxes
% 2. compute new P using the interval images, new Adj (OPTIMIZE)
% 3. compute I from P, Adj using grow_iso
% 4. add o(I) \cup F(o(I)) \cup F^{-1}(o(I)) to tree
% 5. update variables / keep invariants
%

  if nargin < 2, opts = struct; end
  if ~isfield(opts,'imgsteps')
    opts.imgsteps = 5;
  end

  insert_flag = 2;

  boxes = map.tree.boxes(map.tree.depth);
    

  ImgCell = {};
  PreCell = {}; % preimages

  ctr = 0;

  numsteps = 5;
  timemat = zeros(1,numsteps);
  step = 0;
  t = cputime;

  % loop variables!
  n = size(boxes,2);
  S_last = [];
  I = 1:n;
  I_last = I;
  oI = I;
  oI_last = [];
  % oI_last_last = [];
  S_new = 1:n;
  map.P = sparse(n,n);                  % transition matrix
  s_P = 1:n;                            % what images we need to compute for map.P

  while true
	ctr = ctr + 1;
	fprintf('iteration %d: %i new boxes\n', ctr, length(S_new)), tic
	
	% step 1: compute interval images
	ImgCell(S_last,:) = ImgCell;				% put old images in the right places
	ImgCell = interval_images(map.map, boxes, S_new, ImgCell);

	if isfield(map,'inverse')
      PreCell(S_last,:) = PreCell;				% put old images in the right places
      PreCell = interval_images(map.inverse, boxes, S_new, PreCell);
    end
 
    [step t timemat] = printstep(step,t,timemat,numsteps);
    
	% step 2: compute P using the images 
	for i = s_P
	  [center radius] = ImgCell{i,:};
	  img = [];
	  for c = 1 : size(center, 2)
		img = union(img, map.tree.search_box(center(:,c), radius(:,c)) );
	  end
	  map.P(img,i) = 1;
	end
	map.Adj = adj_matrix(map);

    [step t timemat] = printstep(step,t,timemat,numsteps);
    
	% step 3: compute I from P, Adj
	B = map.tree.boxes(map.tree.depth);			% save for later
	I = grow_iso_raf(I_last,map.P,map.Adj);
	I_new = setdiff(I,I_last);
	oI = onebox(I,map.Adj);
	oI_new = setdiff(oI,oI_last);
	fprintf(' I has %i boxes (%3.2f%%)\n',length(I), percentfull(I,map.tree.depth));
	fprintf(' oI has %i boxes (%3.2f%%)\n',length(oI), percentfull(oI,map.tree.depth));

    [step t timemat] = printstep(step,t,timemat,numsteps);
    
	if (isfield(opts,'imgname') && mod(ctr,opts.imgsteps) == 0)
	  draw(map, I, oI, ctr/opts.imgsteps, opts.imgname)
	end

	disp(' inserting next layer... ')
	% step 4: adding image, preimage, and neighborhood boxes
	map.tree.unset_flags('all',insert_flag);
	map = insert_onebox(map, B, I_new, insert_flag);  	    % add o(I)
	insert_image(map.tree, ImgCell, oI_new, insert_flag);	% add F(o_t(I))

	if isfield(map,'inverse')
      insert_image(map.tree, PreCell, oI_new, insert_flag); 	% add F^{-1}(o_t(I))
    end

    [step t timemat] = printstep(step,t,timemat,numsteps);
    
	% step 5: bookkeeping
	% thank you, flags!
	boxes = map.tree.boxes(map.tree.depth);
	S_new = find(boxes(2*map.tree.dim + 1,:) == insert_flag);
    if (isempty(S_new)), break, end
    
    % WARNING: these statements are ordered /VERY/ carefully to keep invariants.
    % tree has changed; get new numbers like a /boss/
	S_last = updateboxnums(n,S_new);        % using previous n here
    n = size(boxes,2);                      % now updating n
%	S_last = search_boxes(map.tree,B);	    % tree has changed; get new numbers
	I_last = S_last(I); 					% new numbers for I
    
    %oI_last_last = S_last(oI_last);         % new numbers for oI_last
    map.P = sparse(n,n);
    s_P = 1:n;
    %P(S_last,oI_last_last) = map.P(:,oI_last);   % keep only oI_last_last (note use of oI_last /before/ we change it)
    %P(S_last,oI_last_last) = map.P(:,oI_last);   % keep only oI_last_last (note use of oI_last /before/ we change it)

	oI_last = S_last(oI);					% new numbers for oI

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

function draw(map, I, oI, ctr, imgname)
   close

   hold on
   imgI = mapimage(map.P,I);
   %
   showset(map,setdiff(imgI,I),'g');
   showset(map,I,'b');
   set(gca,'View',[-100 26])
   xlabel('x')
   ylabel('y')
   zlabel('z')
   saveas(gcf,sprintf('%s-grow-ip-insert-%d', imgname, ctr),'fig')

   %    show3(B','g',3,[1 2 3],'g');
% %   show3(B(:,oI)','m','m');
%    show3(B(:,I)','b',3,[1 2 3],'b');
% %   set(gca,'xlim',[0 1])
% %   set(gca,'ylim',[0 1])
%    saveas(gcf,sprintf('ims/%s-grow-ip-insert-%d', imgname, ctr),'png')
  
%   close

%   B2 = shift_boxes(B,0.5,1);
%   showraf(B2','g','g');
%   showraf(B2(:,oI)','m','m');
%   showraf(B2(:,I)','b','b');
%   set(gca,'xlim',[0 1])
%   set(gca,'ylim',[0 1])
%   saveas(gcf,sprintf('%s-grow-ip-insert-slid-%d', imgname, ctr),'png')
  
%	  disp('[Press a key]')
%	  pause
end

function p = percentfull(S,depth)
  p = 2^(log(length(S))/log(2)-depth)*100;
end


%     if ctr==-1
%       str = who;
%       fast = struct;
%       for s = str'
%         fast.(s{:}) = eval(s{:});
%       end
%       save stdtest_fast fast
%       return
%     end

