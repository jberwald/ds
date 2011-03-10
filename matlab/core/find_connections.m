
function C = find_connections(A,B,P,skinny)
% function C = find_connections(A,B,P [,skinny])
% find connecting orbits from boxes in A to boxes in B
% calls find_skinny_connections if skinny==1
  
  if nargin >= 4 && skinny
    C = find_skinny_connections(A,B,P);
    return
  end
  
  C = [];
  for i = 1 : length(A);
	for k = 1 : length(B);
	  if (A(i) ~= B(k))
		conn = dijkstra(P, A(i), B(k), 0); % 2/3/2010 last arg is debug
		conn = conn(2 : length(conn)-1); % don't include endpoints
		C = union(C,conn);
	  end        
	end    
  end
end
