% Grow-out tutorial
% 2/25/2010
%
% You will need a map, defined as in the tutorial.txt file, but with a
% map.inverse field also, which is just like map.map only it defines the
% inverse of the map

% options to give to our functions if we want to be fancy, which we don't
opts = struct;

% the final depth to grow out
depth = 8;

% the map to start with (typically at a low depth, here 6)
map = get_map('std',6,'params',2);

% get the skeleton that we want to find at a high depth
% this the part which uses a priori info abouth the map
% this homoclinic_points function is specific to th standard map
% C should be a cell array of the form {s_1, t_1; s_2, t_2; ...},
% where we want to find connections from s_i to t_i for each i
disp('[F]inding the connection points...')
C = homoclinic_points(map.params, depth, opts);

% given the desired connections C and the final depth, use algorithm 2 from
% our paper to find the connections at that depth
disp('[I]nserting connections...')
map = insert_connections(map, C, depth, opts);

% now for the good stuff; using just the skeleton, grow it out to a full
% fledged honest-to-goodness index pair.  this could take a while...
disp('[G]rowing invariant set...')
map = grow_ip_insert(map,opts);

% index pair in hand, on to the symbolics!
disp('[C]omputing symbolics...')
dat = compute_symbolics(map.I,map);

% save this run for later
save_run(map,dat,'grow_out_tutorial');

% to prove how badass we are, clear all data and reload the run
clear all
[map dat] = get_run('std','grow_out_tutorial');

% show off that purrrty index pair
showip(map,dat)