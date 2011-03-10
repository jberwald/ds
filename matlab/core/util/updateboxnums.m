function p = updateboxnums(n,S)
% function p = updateboxnums(n,S)
% n = number of old boxes, S = new box nums
% S should be sorted
  
  p = 1:n;

  if isempty(S), return, end
  
  if S(end) < n+length(S)
    S = [S n+length(S)+1];
  end
  
  for i = 1:length(S)-1
    firstval = min(n+1,S(i) + 1 - i);
    lastval = min(n,S(i+1) - 1 - i);
    %    fprintf('%i: [%i,%i]\n',i,firstval,lastval)
    p(firstval:lastval) = p(firstval:lastval) + i;
  end
  
  