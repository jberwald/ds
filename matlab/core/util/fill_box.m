
function M = fill_box(siz,offset)
% function M = fill_box(siz,offset)
% inputs are column vectors
% outputs a matrix whose columns are all vectors "between" offset and offset
% + siz

  if nargin < 2
    offset = zeros(size(siz));
  end
  
  siz = double(siz);
  ndx = 1:prod(siz);
  n = length(siz);
  k = [1;cumprod(siz(1:end-1))];
  M = repmat(offset-1,1,length(ndx));

  for i = n:-1:1,
	vi = rem(ndx-1, k(i)) + 1;
	vj = (ndx - vi)/k(i) + 1;
	M(i,:) = M(i,:) + vj; 
	ndx = vi;     
  end
