function b = subset(A,B)
% function b = subset(A,B)
  b = all(ismember(A,B));
end
