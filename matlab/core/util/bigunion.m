function S = bigunion(C,rows)
% function S = bigunion(C [,'rows'])
% C = {S1,S2,S3,...,Sn}
% S = S1 U S2 U ... U Sn

  if nargin == 2
	S = cat(1,C{:});
	S = unique(S,'rows');
	return
  end

  if (size(C{1},1) > size(C{1},2))		% column vectors
	S = cat(1,C{:});
  else									% row vectors
	S = cat(2,C{:});
  end

  S = unique(S);
