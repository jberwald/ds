function PP = candidates_to_pps(C,map)
% function PP = candidates_to_pps(C,map)
% inputs: C = periodic candidates, C{k} is the cands for per k
%         map - the map object
% output: PP - cell array of periodic orbits
  
  max_period = length(C);
  
  PP = {};

  for p = 1 : max_period
	if (length(C{p}) == 0)
 	  continue;
 	end
	PP_p = add_orbits(C{p}, p, map);
	PP = vertcat(PP,PP_p); % append C_p
  end	

  if (~isempty(PP))
	[uPP inds] = cell_unique(PP(:,1));
	PP = PP(inds,:);
  end
end


function C = add_orbits(orbits, period, map)

  C = {};

  while (length(orbits) > 0)

  	new_orbit = cycle(orbits(1), map.P, period);  % new periodic orbit

	if (isempty(new_orbit))
	  orbits = orbits(2:end); 			% remove the point
	  continue;
	end

    dat = compute_symbolics(new_orbit,map,struct('quiet',1));
    n = num_regions(dat.I,map.Adj);
    goodorbit = @(x) ~isempty(x) && all(diag(x^n));
    if isfield(dat,'SM') && any(cellfun(goodorbit,dat.SM))   % some homol level is good
      fprintf('period %i orbit found (%i boxes)\n',n,length(dat.I));
      C = vertcat(C,{dat.I n});
    else
      if isfield(dat,'SM'), dat.SM{:}, end
      fprintf('invalid period %i orbit\n',n);
    end
    orbits = setdiff(orbits, dat.X); % remove the nhood from the rest
  end
end  
