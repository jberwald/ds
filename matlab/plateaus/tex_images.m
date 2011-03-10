function tex_images(plats,D,E,contractions,depths,dlen,imstr,repfile)
% tex_images(plats,D,E,contractions,depths,dlen,imstr)
% data: {R G M SM X A I}

  if (nargin == 7)
	load plateaus/repdat.mat
  else
	load(repfile)
  end

  K = 1000000;							% inverse of resolution for "max"
  [Y Inds] = max(floor(K*E'));

  for i = 1 : length(plats)

	if (Y(i) == 0)
	  continue;
	end


	params = reps(plats(i),:);
	ind = Inds(i);

	% index pair data, etc
	data = D{i,ind};
	R = data{1}
	X = data{5};
	A = data{6};
	I = data{7};

	% symbol matrix
	T = contractions{i,1};
	Syms = contractions{i,2};


	% index pair image
	depth = depths(ceil(ind/dlen));
	box = [2 2] + [2 2]*(mod(ind-1,dlen))/dlen;
	[tree P Adj] = get_map('henon',depth,'box',box,'params',params);
	boxes = tree.boxes(-1);

	showraf(boxes(:,A)', 'k', 'k');
	perm = randperm(length(Syms));		% mix up colors
	colvec = showregions(boxes,R,Syms(perm));
	if (length(Syms) <= 26)				% enough letters...
	  chars = num2cell(arrayfun(@(x) char('A'+x-1), perm)); % keep track of labels
	  legend('P_0', chars{:});
	end

	
	thesisfig(sprintf('%s%i-ip', imstr, i))
	close

	% entropy vs resolution plot
	plot(E(i,:));
	hold on
	plot(Inds(i),E(i,Inds(i)),'r*');	% show the point that we "zoom in" on
	thesisfig(sprintf('%s%i-ent', imstr, i),'height',3)
	close

  end 

end
