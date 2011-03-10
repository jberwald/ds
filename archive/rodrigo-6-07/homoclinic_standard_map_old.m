
% function homoclinic_standard_map_old
%
% Adapted from full_standard_map.m where the suggested improvements are made.
%
% This is now retired since we will try another approach.
%


tic

dim = 2;
c = [0.5,0.5];
r = [0.5,0.5];

tree = Tree(c(1:dim), r(1:dim));
interval_map = @(x,y) standard_int_image_old(x,y);

initial_depth = 12;     % This initial depth is as far as we go before 
full_depth = 18;        % we clean up a little.
to_be_subdivided = 4;

increment = 2^(-(initial_depth+2)/2);

for i=1:initial_depth
  tree.set_flags('all',to_be_subdivided);
  tree.subdivide(to_be_subdivided);
end

disp('Computing the point of intersection of the stable and unstable manifolds...');
[centerx centery x2 y2 x_points y_points x_reverse y_reverse x_pointss y_pointss x_reverses y_reverses] = draw_invariant_manifolds(2.0);

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

new_total = get_nbhd(tree, new_total, initial_depth);
new_total = get_nbhd(tree, new_total, initial_depth);

%% Now we clean up a little and keep only the boxes associated to the
%% good intersections of the stable and unstable manifolds.

hit = 1;
to_be_subdivided = 8;

n = tree.count(-1);
unset = ones(1, n);

inv_bits = repmat('0',[1 n]);
inv_bits(new_total) = '1';
tree.set_flags(inv_bits, hit);
tree.remove(hit);
tree.unset_flags('all',hit); % Does this fix the problem from below?

b = tree.boxes(-1);
show2(b','y');  % '

%% Here we perform Dijkstras algorithm for the first time to keep a 
%% neighborhood of the homoclinic orbit.

disp('Calculating first transition matrix...');

% m = Model('stan_map_0.75');
% map_henon = Integrator('Map');
% map_henon.model = m;
% map_henon.tFinal = 1;
% m.dim = 2;

% tree.integrator = map_henon;
% lip = Points('Lipschitz',m.dim);
% tree.domain_points=lip;
% tree.image_points=Points('Vertices',m.dim);

% P = tree.matrix(lip);
% toc
% disp('Cleaning up some more, focusing on the homoclinic orbit...');

intersections1 = [0.5 centery; .5 1-centery]';  % '
homoclinic1 = tree.search(intersections1);
intersections2 = [x2 y2; 1-x2 1-y2]';  % '
homoclinic2 = tree.search(intersections2);

% first_box = tree.search([increment;increment], initial_depth);
% bottom_right_box = tree.search([1-increment;increment],initial_depth);
% top_left_box = tree.search([increment;1-increment],initial_depth);
% top_right_box = tree.search([1-increment;1-increment],initial_depth);

% origin = [first_box bottom_right_box top_left_box top_right_box];

% fixed_connection1 = dijkstra(P',first_box,homoclinic(1)); % '
% fixed_connection2 = dijkstra(P,homoclinic(1),bottom_right_box); 
% fixed_connection3 = dijkstra(P,homoclinic(2),top_left_box);
% fixed_connection4 = dijkstra(P',homoclinic(2),top_right_box); % '

% TOTAL = union(fixed_connection1, fixed_connection2);
% TOTAL = union(TOTAL, fixed_connection3);
% TOTAL = union(TOTAL, fixed_connection4);

% TOTAL = get_nbhd(tree, TOTAL, initial_depth);
% TOTAL = union(TOTAL,origin);

b = tree.boxes(-1);
% show2(b(:,TOTAL)','g');  % '
                    
    %%  DEBUGGING IS BEING DONE IN THIS SECTION
% n = tree.count(-1);
% unset = ones(1, n);
% inv_bits = repmat('0',[1 n]);
% inv_bits(TOTAL) = '1';  
% tree.set_flags(inv_bits, hit);
% tree.remove(hit);

b = tree.boxes(-1);

figure
show2(b','r');  % '

disp('Done.');

%% Now that we threw boxes away we subdivide further.

for i=(initial_depth+1) : full_depth
  tree.set_flags('all',to_be_subdivided);
  tree.subdivide(to_be_subdivided);
end

NUMBER = tree.count(-1);

disp(sprintf('We are working with a total of %i boxes.', NUMBER));
disp('Computing transition matrix...');
P = rigorous_matrix_stan(tree, full_depth, interval_map); 
toc
P = spones(P);
P = sparse(P);
toc

toc
disp('Computing the adjacency matrix and identifying the edges')
wrap_it_up_better
disp('Done.');
toc

increment = 2^(-(full_depth+2)/2);

tree.count(-1);
homoclinic1 = tree.search(intersections1);
homoclinic2 = tree.search(intersections2);
first_box = tree.search([increment;increment], full_depth);
bottom_right_box = tree.search([1-increment;increment],full_depth);
top_left_box = tree.search([increment;1-increment],full_depth);
top_right_box = tree.search([1-increment;1-increment],full_depth);

fixed_connection1 = dijkstra(P,first_box,homoclinic1(1)); 
fixed_connection2 = dijkstra(P',bottom_right_box,homoclinic1(1)); %'
fixed_connection3 = dijkstra(P,homoclinic1(2),top_left_box);
fixed_connection4 = dijkstra(P',homoclinic1(2),top_right_box); % '

TOTAL = [];
TOTAL = union(fixed_connection1, fixed_connection2);
TOTAL = union(TOTAL, fixed_connection3);
TOTAL = union(TOTAL, fixed_connection4);

fixed_connection1 = dijkstra(P,first_box,homoclinic2(1)); 
fixed_connection2 = dijkstra(P',bottom_right_box,homoclinic2(1)); %'
fixed_connection3 = dijkstra(P,homoclinic2(2),top_left_box);
fixed_connection4 = dijkstra(P',homoclinic2(2),top_right_box); % '

TOTAL = union(TOTAL, fixed_connection1);
TOTAL = union(TOTAL, fixed_connection2);
TOTAL = union(TOTAL, fixed_connection3);
TOTAL = union(TOTAL, fixed_connection4);

disp(sprintf('The symbolic length of the homoclinic orbit is at most %i',length(TOTAL)))
disp('Growing isolating neighborhood...');
I = grow_iso_rod(TOTAL, P, ADJACENCY);
disp('Growing index pair...');
[X, A] = build_ip_raf(I, P, ADJACENCY);
disp('Done.');

b = tree.boxes(full_depth);

show2(b(:,TOTAL)', 'k'); %'
show2(b(:,X)', 'y'); %'
show2(b(:,A)', 'r'); %'

M = index_map_standard(X,A,I,b,'02.0-IA',P,full_depth);

toc

disp('Done. How about a picture?'); 

% draw_stable_manifold(0.8,500000,.00000001,26);
