
function C = find_skinny_connections(A,B,P)
% function C = find_skinny_connections(A,B,P)
% find a single connecting orbit from A to B
%
% algorithm: add new verts s and t, set s -> A and B -> t, and look for an
% s,t path using dijkstra
  
  n = size(P,1);
  s = n+1;								% new vertices
  t = n+2;
  P(s,s) = 0;                           % add s to P
  P(t,t) = 0;                           % add t to P
  P(A,s) = 1;					        % connect s to A
  P(t,B) = 1;					        % connect B to t

  C = dijkstra_raf(P,s,t);		        % shortest path from A to B
  C = C(2:end-1);                       % remove endpoints...

end
