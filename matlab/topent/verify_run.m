function [R G M SM] = verify_run(prefix,depth)
  load(sprintf('%s_interval_%i_trans.mat',prefix,depth)); % P
  tree = Tree(sprintf('%s_interval_%i.tree',prefix,depth)); % tree
  boxes = tree.boxes(-1);

  disp('getting index map...')
  tic
  [R G M] = verify_index_map(prefix,tree);
  toc

  disp('validating index map...')
  tic
  validate_index_map(R,G,M,P,boxes);
  toc

  disp('reducing index map...')
  tic
  SM = reduce_index_map(M,G);
  toc
end




function [R G M] = verify_index_map(prefix,tree)
% function [M G idstr] = index_map(X,A,I,R,tree,mapname,P)
  
  load([prefix '.mat']);				% R G M SM
  
  xname = sprintf('%s-X.dat', prefix);
  yname = sprintf('%s-Y.dat', prefix);
  aname = sprintf('%s-A.dat', prefix);
  bname = sprintf('%s-B.dat', prefix);
  mapfile = sprintf('%s.map', prefix);
  genfile = sprintf('%s.gen', prefix);

  [s r] = unix(sprintf('chkmvmap %s %s %s %s %s -s',mapfile,xname,aname,yname,bname));
  if (strfind(r,'NO! This is NOT a valid map for homology'))
	r
	disp('map failed chkmvmap (!), aborting');
	M = [];
	G = {};
	return;
  else
%	disp('map passed chmvmap (hurrah)');
  end

  [s r] = unix(sprintf('homcubes -a -i %s %s %s %s %s -g %s', ...
					   mapfile, xname, aname, yname, bname, genfile));
  
  [M parsecubes_error] = parsecubes(r);
  if (parsecubes_error)
	G = {};
  else
	G = gen2sym(tree, genfile, R); 		% regions to their generators
  end
end

function filename = get_filename(dir)
  [s r] = unix(sprintf('mktemp -u %s/tmp/tmp-XXXXXX',dir));
  filename = regexprep(r,'\n','');
end
