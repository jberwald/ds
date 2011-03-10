function M = index_map_standard(X,A,I,boxes,mapname,P,depth)
% function M = index_map_standard(X,A,I,boxes,mapname,P,fulldepth)
  mapname
  
  % Finding the image, [Y, B], of [X, A] under P.
  n = size(P,1);
  FX = find(P*flags(X,n));               
  Y = union(X,FX);

  if (isempty(A))
	xname = sprintf('topdata/%s-X.dat', mapname);
	yname = sprintf('topdata/%s-Y.dat', mapname);
	mapfile = sprintf('topdata/%s.map', mapname);
	genfile = sprintf('topdata/%s.gen', mapname)
	box2cub(boxes(:,X),xname);
	box2cub(boxes(:,Y),yname);
	tm2map_raf(boxes, X, Y, P, mapfile);

	[s r] = unix(sprintf('/home/rtrevino/chom/bin/chkmvmap %s %s %s -s',mapfile,xname,yname))
	if (strfind(r,'NO! This is NOT a valid map for homology'))
	  r
	  disp('map failed chkmvmap (!), aborting');
	  M = []; return;
	else
	  %	disp('map passed chmvmap (hurrah)');
	end
	
	[s r] = unix(sprintf('/home/rtrevino/chom/bin/homcubes -a -i %s %s %s -g %s', ...
						 mapfile, xname, yname, genfile));

	unix(sprintf('/home/rtrevino/chom/bin/homcubes -a -i %s %s %s -g %s > homcubes.out', ...
				 mapfile, xname, yname, genfile));
	M = [];
	return;
  end
  
  
  B = setdiff(Y,I);
  
  % Save sets, map t
  % Now we check if these orbits which are on the gaps are next to any part
  % of the index pao files.
  
  xname = sprintf('topdata/%s-X.dat', mapname);
  yname = sprintf('topdata/%s-Y.dat', mapname);
  aname = sprintf('topdata/%s-A.dat', mapname);
  bname = sprintf('topdata/%s-B.dat', mapname);
  mapfile = sprintf('topdata/%s.map', mapname);
  genfile = sprintf('topdata/%s.gen', mapname);
  box2cub(boxes(:,X),xname);
  box2cub(boxes(:,A),aname);
  box2cub(boxes(:,Y),yname);
  box2cub(boxes(:,B),bname);
  tm2map_raf(boxes, X, Y, P, mapfile);
  
%  [s r] = unix(sprintf('chkmvmap %s %s %s %s %s -s',mapfile,xname,aname,yname,bname));
%  if (strfind(r,'NO! This is NOT a valid map for homology'))
%	r
%	disp('map failed chkmvmap (!), aborting');
%	M = []; return;
%  else
%	disp('map passed chmvmap (hurrah)');
%  end
  
  [s r] = unix(sprintf('homcubes -a -i -w%d %s %s %s %s %s -g %s', ...
					   2^(depth/2), mapfile, xname, aname, yname, bname, genfile));

  unix(sprintf('homcubes -a -i -w%d %s %s %s %s %s -g %s > homcubes.out', ...
			   2^(depth/2), mapfile, xname, aname, yname, bname, genfile));


  
  M = parsecubes(r);
