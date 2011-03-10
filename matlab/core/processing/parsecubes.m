function [A stop] = parsecubes(str)

stop = false;							% not trivial / error yet

original_str = str;
%str

A = {};

if (~isempty(strfind(str,'Computing the image of F... 0 cells')) || ...
	~isempty(strfind(str,'homology of (X,A) is trivial')))			% nothin'
  stop = true;							% trivial
  return;
end
if (strfind(str,'Oh, my goodness! This map is apparently not invertible.'))	% glug...
  disp('error: map not invertible');
  stop = true;							% error
  return;
end

%str



str = regexprep(str,'.*The composition of F and the inverse of the map induced by the inclusion:\n','');
str = regexprep(str,'Total[ ]*time[ ]*used.*','');

dims = regexp(str,'Dim[ ]*([0-9]+):','tokens');
dims = cellfun(@(x) str2num(x{:}), dims)+1; % add 1 to get matlab inds
for i = 1:length(dims) % use inds to figure out the level for each map
  inds = strfind(str,':'); % scope of each dimension (recompute each time)
  inds(end+1) = length(str);
  mid = strrep(str(inds(i):inds(i+1)-1),'F',sprintf('F{%d}', dims(i)));
  str = [str(1:inds(i)-1) mid str(inds(i+1):end)];
end

% transform it into a matlab expression
str = regexprep(str,'Dim[ ]*[0-9]+:([ \t]+0\n)*',''); % ignore if just 'dim X:   0'
str = regexprep(str,'(x','{');			% cell index
str = regexprep(str,')','}');			%
str = regexprep(str,'x','1 ');			% make [value gen#] pairs
str = regexprep(str,' \+ +','; ');		% new row
str = regexprep(str,' - +','; -');	    %
str = regexprep(str,'= ','= [');			% begin matrix
str = regexprep(str,'\n','];\n');		% end matrix

%str

F = {};

try
  eval(str);
catch
  disp('***')
  disp('* ERROR in parsing from homcubes')
  disp('* Original homcubes output:')
  disp('***')
  disp(original_str)
end

for d=dims
  n = length(F{d});
  A{d} = sparse(n,n);
  for i = 1 : n
	if (F{d}{i} ~= 0)
	  v = F{d}{i};
	  A{d}(abs(v(:,2)),i) = v(:,1)';
	end
  end
end
