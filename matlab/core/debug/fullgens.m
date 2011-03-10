function FG = fullgens(tree,idstr,mapname)
% function FG = fullgens(tree,idstr,mapname)
% returns a regions -> generator mapping using parseallgens
% useful for debugging
  
  genfile = sprintf('%s/tmp/tmp-%s-%s-gen.dat', data_dir(), idstr, mapname);
  cubes = parseallgens(genfile);
  FG = cell(1,length(cubes));
  for i = 1:length(cubes)
 	a = cub2box(tree,cubes{i}');
 	a = cat(1,a{:})';
 	FG{i} = unique(a(:));
  end
  
