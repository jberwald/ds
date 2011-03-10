
function p = keep_hyperbolic(n,boxes,epsilon,b,P)

%
% function p = keep_hyperbolic(n,boxes,epsilon)
%
% Given the set boxes which are candidates for period n orbits, we wish to
% keep only the ones which correspond to hyperbolic periodic orbits of the
% standard map and throw the elliptic ones away.

bad_apples = [];

for i = 1 : length(boxes)
  center = b(1,boxes(i));
  if check_hyperbolic(n,center,epsilon) == 0
    bad = boxes(i);
    bad = union(bad,find(P(:,boxes(i))));
    bad = union(bad,find(P(boxes(i),:)));
    bad_apples = union(bad_apples,bad);
  end
end

p = setdiff(boxes,bad_apples);
