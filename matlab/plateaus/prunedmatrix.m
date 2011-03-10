function M = prunedmatrix(forbidden_strings)

k = max(cellfun(@length,forbidden_strings))-1;
M = sparse(2^k,2^k);

for i=1:2^k
  j = mod(2*i-1,2^k);
  M(i,j) = 1;
  M(i,j+1) = 1;
end

i = 1;
while i <= length(forbidden_strings)

  s = forbidden_strings{i};

  if (length(s) <= k)
	forbidden_strings(end+1:end+2) = {['0' s],['1' s]};
	forbidden_strings(i) = [];
	continue
  end

  ind = strfind(s,'x');
  if (~isempty(ind))
	s(ind(1)) = '1';
	forbidden_strings{end+1} = s;
	s(ind(1)) = '0';
	forbidden_strings{end+1} = s;
	forbidden_strings(i) = [];
	continue
  end

  disp(s)
  M = cut_string(M,s);
  i = i+1;

end
  
end

function M = cut_string(M,str)
  s1 = bin2dec(str(1:end-1))+1;
  s2 = bin2dec(str(2:end))+1;
  M(s1,s2) = 0;
end
