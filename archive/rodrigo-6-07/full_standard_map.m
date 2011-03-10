
% function full_standard_map
%
% Adapted from get_close_to_the_manifolds.m
%
% March 20, 2007
%
% Here is the problem with this script. When the boxes are very small, when
% we have computed a neighborhood of the unstable manifold at the initial 
% depth, we leave crucial boxes out. This can be fixed by drawing the 
% manifold with more points. This in turn can slow things significantly to 
% get the desired results. Another way of fixing this which seems better is
% to approach the unstable manifold at the initial depth and throw boxes 
% away. Then, run Dijkstras algorithm and keep the boxes which constitute the
% homoclinic orbit as well as a one-box neighborhood of them and throw the
% rest of the boxes away. THEN we subdivide to the full depth and run 
% Dijkstras algorithm one more time to get the desired homoclinic orbit.
% Then we do the rest and grow index pair, et cetera. This script takes
% 3.2 hours to run using interval arithmetic before it craps out. The
% suggested new approach will be implemented in homoclinic_standard_map.m

tic

dim = 2;
c = [0.5,0.5];
r = [0.5,0.5];

tree = Tree(c(1:dim), r(1:dim));
interval_map = @(x,y) standard_int_image(x,y);

initial_depth = 18;     % This initial depth is as far as we go before 
full_depth = 28;        % we clean up a little.
to_be_subdivided = 4;

for i=1:initial_depth
  tree.set_flags('all',to_be_subdivided);
  tree.subdivide(to_be_subdivided);
end
 
disp('Computing the point of intersection of the stable and unstable manifolds...');
[centerx centery x_points y_points x_reverse y_reverse] = draw_stable_manifold(0.8,250000,.00000001,27);

%% Now we keep a phat neighborhood of the unstable manifold only.
%% We clean up a little before going to the full depth.

new_total = [];
tree.count(-1);

disp('Computing a neighborhood of the unstable manifold...');
for i = 1 : (length(x_points) - 2)
  points_to_check = [x_points(i) y_points(i); x_reverse(i) y_reverse(i)]'; % '
  boxes_to_add = tree.search(points_to_check, initial_depth);
  for j = 1 : length(boxes_to_add)
     if (boxes_to_add(j) ~= -1)
       new_total = [new_total boxes_to_add];
     end
  end
end
disp('Done.');
toc
%% Now we clean up a little and keep only th boxes associated to the
%% good intersections of the stable and unstable manifolds.

hit = 1;
to_be_subdivided = 8;

n = tree.count(-1);
unset = ones(1, n);

inv_bits = repmat('0',[1 n]);
inv_bits(new_total) = '1';
tree.set_flags(inv_bits, hit);
tree.remove(hit);

b = tree.boxes(-1);
show2(b','y');  % '

%% Now that we threw boxes away we subdivide further.

for i=(initial_depth+1) : full_depth
  tree.set_flags('all',to_be_subdivided);
  tree.subdivide(to_be_subdivided);
end

disp('Computing the adjacency matrix and identifying the edges')
wrap_it_up_better
disp('Done.');
toc
disp(sprintf('We are working with a total of %i boxes', length(ADJACENCY(1,:))))
disp('Computing transition matrix...');

P = rigorous_matrix_stan(tree, full_depth, interval_map); 
toc
P = spones(P);
P = sparse(P);
toc
intersections = [0.5 centery; .5 1-centery]';  % '

tree.count(-1);
homoclinic = tree.search(intersections)

fixed_connection1 = dijkstra(P,homoclinic(1),1)
fixed_connection2 = dijkstra(P,1,homoclinic(2))
fixed_connection3 = dijkstra(P,homoclinic(2),1)
fixed_connection4 = dijkstra(P,1,homoclinic(1))

TOTAL = union(fixed_connection1, fixed_connection2)
TOTAL = union(TOTAL, fixed_connection3)
TOTAL = union(TOTAL, fixed_connection4)

%% INDEX PAIRS, MAYBE?

disp(sprintf('The symbolic length of the homoclinic orbit is at most %i',length(TOTAL)))
disp('Growing isolating neighborhood...');
I = grow_iso_raf(TOTAL, P, ADJACENCY);
disp('Growing index pair...');
[X, A] = build_ip_raf(I, P, ADJACENCY);
disp('Done.');

b = tree.boxes(full_depth);

show2(b(:,TOTAL)', 'k');
show2(b(:,X)', 'y');
show2(b(:,A)', 'r');

M = index_map(X,A,I,b,'0.8-IA',P);

toc

disp('Done. How about a picture?');  %'

% draw_stable_manifold(0.8,500000,.00000001,26);
