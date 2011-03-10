function [points I] = rodrigo_orbits_file(candidates, max_period, I, P, Adj)
% function [new_points I] = rodrigo_orbits(periods, I, P, Adj)
% inputs: periods - vector of periods to look for (i.e., [1 2 4])
%         I - the current accumulated isolated invariant set
%         P, Adj - the transition and adjacency matrix
% output: the newly found points and the accumulated invariant set

  points = [];

  candidates
  for p = 1 : max_period
	if (length(candidates{p}) == 0)
 	  continue;
 	end
	[points_p I] = add_orbits(candidates{p}, p, I, P, Adj);
	points = [points points_p];
	fprintf('S has %d boxes up to period %d\n',length(points),p)
  end	

end


function [points I] = add_orbits(orbits, period, I, P, Adj)
  points = [];
  while (length(orbits) > 0)
  	new_orbit = cycle(orbits(1), P, period);  % new periodic orbit
	if (isempty(new_orbit))
	  orbits = orbits(2:length(orbits)); % remove the point
%	  disp('empty orbit!');
	  continue;
	end
	new_inv = grow_iso_raf(new_orbit, P, Adj); % grow an isolated invariant set
	orbits = setdiff(orbits, new_inv); % remove the nhood from the rest
	  
	if (disjoint(new_inv, I))
	  points = [points new_inv]; % add the isolated inv. set
	  I = grow_iso_raf(points, P, Adj);
	end
  end
end  
