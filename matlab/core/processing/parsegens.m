function cubecell = parsegens(filename)  
% function cubecell = parsegens(filename)
% retrieves representative cubes from the generators in filename, and places
% them by dimension into cubecell, so that cubecell{d} has the cubes of
% dimension d
  
  fid = fopen(filename,'r');
  str = fscanf(fid,'%s',inf);

  % parse the H_* statements to see which part of the array things should go
  % into... keep the off-by-one error in mind
  dims = regexp(str,'H_([0-9]+)','tokens');
  dims = cellfun(@(x) str2num(x{:}), dims);

  str = regexprep(str,'The[0-9]*generators*ofH_([0-9]+)follows*', ...
				  'transpose([');

  % if there are multiple generators, the first one has a : in front
  str = regexprep(str,':(generator)*[^(]+\(','<');

  % the rest act as separators
  str = regexprep(str,'generator[^(]+\(','; <');
  str = regexprep(str,'<([^\)]+)\)[^t;]*','$1;');
  str = regexprep(str,';t',']), t');
  str = regexprep(str,'; *;',';');
  str = ['{' str(1:end-1) '])};'];
  C = eval(str); % evaluate to a cell array
  cubecell = {};
  cubecell(dims + 1) = C;
  fclose(fid);
