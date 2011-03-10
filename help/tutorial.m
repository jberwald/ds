% Part 2: Loading the Map

map = get_map('tutorialhenon',8) % get_map(mapname,depth)

% Part 3: Simple Computations

map = get_map('tutorialhenon',8)
S = find(diag(map.P^2));
dat = compute_symbolics(S,map)
showip(map,dat)
dat.SM{2}

% Part 4: The Quest for Entropy

map = get_map('tutorialhenon',8)
map = refine_map(map,9);
per2 = setdiff(find(diag(map.P^2)),find(diag(map.P))); % 2 but not 1
per4 = setdiff(find(diag(map.P^4)),per2);              % 4 but not 2
conns24 = find_connections(per2,per4,map.P);           % connections
S = union(union(per2,per4),conns24);                   % everything
dat = compute_symbolics(S,map)
prettypictures(map,dat)
dat.SM{2}
graph_mis(dat.SM{2})'
length(ans)

