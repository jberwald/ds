function v = edge2num(E,n)
% function v = edge2num(E,n)
% converts an edge [s t] to the number s + t*(n+1)

  v = E(:,1) + E(:,2) .* (n+1);
