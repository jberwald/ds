function B = slice_interval(v,k)
% function B = slice_interval(v,k)
%
% slices the interval v into k equal pieces. if v is a vector of intervals, it
% slices the corresponding box (of dimension length(v)) k times in each
% direction
  
  B = intval(zeros(k*length(v),length(v)));
  a = inf(v);
  b = sup(v);
  d = (b-a)/k;
  
  M = fill_box(repmat(k,length(v),1))';
  for i = 1:length(B)
    B(i,:) = infsup(a+M(i,:).*d,a+(M(i,:)+1).*d);
  end
  
  
