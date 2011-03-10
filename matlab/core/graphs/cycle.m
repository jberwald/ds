function orbit = cycle(s, P, period)

%  Finds a periodic orbit of length "period" containing initial guess s.

n = size(P,1);
Im = find(P*flags(s,n));
i = 1;
orbit_length = 0;

if (period == 1),
    if ismember(s,Im), 
        orbit = s;
    else 
        orbit = [];
    end
    return;
end
    
while orbit_length~=period 
  if i > length(Im),
    orbit = [];
    break; 
  end
  
  orbit = dijkstra_raf(P, Im(i), s);
  orbit_length = size(orbit);
  i = i+1;
end

