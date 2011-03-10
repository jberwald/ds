% [C inds] = cell_unique(C)  % inds are the indices of the elements kept
% this routine is not that fast...
function [C inds] = cell_unique(C)

  i = 1;
  inds = 1:length(C);

  while i <= length(C)
%	a = cell2mat(cellfun(@(x) set_equal(C{i},x), C(i:end),
  %	'uniformoutput',0));
	a = arrayfun(@(x) set_equal(C{i},C{x}), i+1:length(C), 'uniformoutput',0);
	sa = find(cell2mat(a)) + i;			% shift by i
	C(sa) = [];							% kill redundancies

	sb = find(~cell2mat(a)) + i;			% shift by i
	inds = inds([1:i sb]);
	i = i+1;
  end

