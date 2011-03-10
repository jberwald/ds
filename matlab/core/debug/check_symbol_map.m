%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% check_symbol_map
%
% function check_symbol_map(SM,M,G [, verbosity, trial_number])
%
% Does a randomized test of cycles in SM to make sure non of them have
% lefschetz number 0.
%
% SM - symbol map
% M - index map
% G - cell array of generators
% verbosity - nonzero for more output (default 0 -- only print errors)
% trial_number - how many cycles per vertex to test (default 80)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function check_symbol_map(SM,M,G, verbosity, trial_number)
  if nargin < 4
	verbosity = 0;
  end
  if nargin < 5
	trial_number = 80;
  end

  path_len = [2 size(SM,1)*2];

  if verbosity, disp('checking symbol map...'), end

  for v = 1 : size(SM,1)				% for each vertex v...
	if verbosity, fprintf(' checking vertex %d...',v), end
	if (isempty(mapimage(SM,v)))
	  if verbosity, fprintf(' no image\n'), end
	  continue
	end

	error = 0;

	for i = 1 : trial_number			   % number of trials
	  walk = random_walk(SM,v,path_len);   % walk randomly
	  back = dijkstra_raf(SM,walk(end),v); % come back

	  if isempty(back)					% not a loop: ignore
		continue
	  end

	  path = [walk back(2:end)];
	  if verbosity == 2, fprintf('path: '), end
	  if verbosity == 2, fprintf('%d ',path), end

	  if (lefschetz_path(path,M,G) == 0)
		fprintf('\nERROR, on path:')
		fprintf(' %i',path)
		error = 1;
	  else
		if verbosity == 2, fprintf(' good'), end
	  end
	  if verbosity == 2, fprintf('\n'), end
	end

	if (~error)
	  if verbosity, fprintf(' all %d cycles passed Lefschetz',trial_number), end
	end
	if verbosity, fprintf('\n'), end
  end

end













function check_symbol_map_old(SM,M,G)
  disp('cehcking symbol map...')

  for v = 1 : size(SM,1)				% for each vertex v...
	fprintf(' checking vertex %d...',v)
	if (isempty(mapimage(SM,v)))
	  fprintf(' no image\n')
	  continue
	end
	
	error = 0;

	for i = 1 : 20						% number of trials
	  walk = random_walk(SM,v,2,60);	% walk randomly
	  paths = find_all_paths(SM,walk(end),v); % come back

	  for p = paths
		if (lefschetz_path([walk p(2:end)],M,G) == 0)
		  fprintf(' error!')
		  error = 1;
		end
	  end
	end

	if (~error), fprintf(' good'), end
	fprintf('\n')
  end
end
