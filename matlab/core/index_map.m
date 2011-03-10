function [M G idstr] = index_map(X,A,I,R,map)
% function [M G idstr] = index_map(X,A,I,R,map)
  
  % Finding the image, [Y, B], of [X, A] under P.

  torus = 0;
  if (strcmp(map.space,'torus'))
    fprintf(' torus');
	torus = 1;
	wrap = 2^(map.tree.depth/2);
  end

  n = size(map.P,1);
  FX = find(map.P*flags(X,n));               
  Y = union(X,FX);

  prefix = get_filename(data_dir());
  idstr = prefix(end-5:end);

  boxes = map.tree.boxes(-1);

  B = setdiff(Y,I);
  
  xname = sprintf('%s-%s-X.dat', prefix, map.name);
  yname = sprintf('%s-%s-Y.dat', prefix, map.name);
  if (~isempty(A))
	aname = sprintf('%s-%s-A.dat', prefix, map.name);
	bname = sprintf('%s-%s-B.dat', prefix, map.name);
	box2cub(boxes(:,A),aname);
	box2cub(boxes(:,B),bname);
  end
  mapfile = sprintf('%s-%s-map.dat', prefix, map.name);
  genfile = sprintf('%s-%s-gen.dat', prefix, map.name);
  box2cub(boxes(:,X),xname);
  box2cub(boxes(:,Y),yname);

  tm2map_raf(boxes, X, Y, map.P, mapfile);

  if torus

	if (isempty(A))
	  [s r] = unix(sprintf('homcubes -a -i -w%d %s %s %s -g %s', ...
						   wrap, mapfile, xname, yname, genfile));
	else
	  [s r] = unix(sprintf('homcubes -a -i -w%d %s %s %s %s %s -g %s', ...
						   wrap, mapfile, xname, aname, yname, bname, genfile));
	end

  else

	if (isempty(A))
	  [s r] = unix(sprintf('chkmvmap %s %s %s -s',mapfile,xname,yname));
	else
	  [s r] = unix(sprintf('chkmvmap %s %s %s %s %s -s',mapfile,xname,aname,yname,bname));
	end

	if (strfind(r,'NO! This is NOT a valid map for homology'))
	  r
	  disp('map failed chkmvmap (!), aborting');
	  return;
	end

	if (isempty(A))
	  [s r] = unix(sprintf('homcubes -a -i %s %s %s -g %s', ...
						   mapfile, xname, yname, genfile));
	else
	  [s r] = unix(sprintf('homcubes -a -i %s %s %s %s %s -g %s', ...
						   mapfile, xname, aname, yname, bname, genfile));
  	end

  end
    
%  validate_mapfile(mapfile,X,xname,Y,yname);

  [M parsecubes_error] = parsecubes(r);
  if (parsecubes_error)
    M = {};
	G = {[]};
  else
	G = gen2sym(map.tree, genfile, R); 		% regions to their generators
  end
end

function filename = get_filename(dir)
  [s r] = unix(sprintf('mktemp -u %s/tmp/tmp-XXXXXX',dir));
  filename = regexprep(r,'\n','');
end
