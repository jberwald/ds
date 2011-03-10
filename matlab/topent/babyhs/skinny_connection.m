function S = skinny_connection(A,B,P)

  n = size(P,1);
  s = n+1;								% new vertices
  t = n+2;
  P(s,s) = 0;
  P(t,t) = 0;
  P(A,s) = 1;                           % s -> A
  P(t,B) = 1;                           % B -> t
  P(A,A) = 0;                           % nontrivial connections
  P(B,B) = 0;

  S = dijkstra(P,s,t);		% shortest path from A to B
  S = S(2:end-1);
  
end
