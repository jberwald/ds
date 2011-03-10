function cubes = parseallgens(filename)  
% function cubes = parseallgens(filename)
% retrieves /all/ representative cubes from the generators in filename
% useful for debugging (compare with normal parsegens.m)

  fid = fopen(filename,'r');
  str = fscanf(fid,'%s',inf);
  str = regexprep(str,'The.{1,30}follow:','',1); % cut the beginning out

  str = regexprep(str,'generator[-0-9*]+','{[',1);
  str = regexprep(str,'generator[-0-9*]+','],[');
  str = regexprep(str,'\][-0-9*]+\[',';');
  str = regexprep(str,'(','[');
  str = regexprep(str,')',']');
  str = regexprep(str,'\]\[','];[');
  str = regexprep(str,'\[\[\[','[[');
  str = regexprep(str,'\]\]\]',']]');

  cubes = eval([str '}']);

  fclose(fid);
