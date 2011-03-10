
% function connections_standard_map
%
% Adapted from homoclinic_standard_map.m
% homoclinic_standard_map is designed to obtain entropy
% values when the perturbation is smaller than the magical
% number of Greene. 
%
% This one is designed to get entropy values when the 
% perturbation is greater than the magical number. Here we
% connect the fixed point with the period2 orbit. Simple.

tic

dim = 2;
c = [0.5,0.5];
r = [0.5,0.5];

tree = Tree(c(1:dim), r(1:dim));
interval_map = @(x,y) standard_int_image(x,y);
epsilon = 1.2;

full_depth = 20;
to_be_subdivided = 4;

increment = 2^(-(full_depth+2)/2);

for i=1:full_depth
  tree.set_flags('all',to_be_subdivided);
  tree.subdivide(to_be_subdivided);
end

disp('Computing the adjacency matrix and identifying the edges')
wrap_it_up_better
disp('Done.');
toc

disp('Computing the transition matrix...')
P = rigorous_matrix_stan(tree, full_depth, interval_map); 
toc
P = spones(P);
P = sparse(P);
toc
disp('Done.')
 
first_box = tree.search([increment;increment], full_depth);
period_two = period_2(epsilon);
p2 = tree.search(period_two);

connection1 = dijkstra(P,p2(1),first_box);
connection2 = dijkstra(P,first_box,p2(1));

TOTAL = union(connection1, connection2);
TOTAL = union(TOTAL, p2);

% I = grow_iso_raf(TOTAL, P, ADJACENCY);

% hit = 1;
% to_be_subdivided = 8;

% n = tree.count(-1);
% unset = ones(1, n);

% inv_bits = repmat('0',[1 n]);
% inv_bits(TOTAL) = '1';
% tree.set_flags(inv_bits, hit);
% tree.remove(hit);

%% Now that we threw boxes away we subdivide further.

% for i=(full_depth+1) : (full_depth+2)
%  tree.set_flags('all',to_be_subdivided);
%  tree.subdivide(to_be_subdivided);
% end

% tree.boxes(-1);
% tree.count(-1);

% toc
% disp('Computing the adjacency matrix and identifying the edges')
% wrap_it_up_better
% disp('Done.');
% toc
% disp(sprintf('We are working with a total of %i boxes', length(ADJACENCY(1,:))))
% disp('Computing transition matrix...');

% P = rigorous_matrix_stan(tree, full_depth, interval_map); 
% toc
% P = spones(P);
% P = sparse(P);
% toc

% first_box = tree.search([increment;increment], full_depth);
% period_two = period_2(epsilon);
% p2 = tree.search(period_two);

% connection1 = dijkstra(P,p2(1),first_box);
% connection2 = dijkstra(P,first_box,p2(1));

% TOTAL = union(connection1, connection2);
% TOTAL = union(TOTAL, p2);

disp(sprintf('The symbolic length of the homoclinic orbit is at most %i',length(TOTAL)))
disp('Growing isolating neighborhood...');
I = grow_iso_raf(TOTAL, P, ADJACENCY);
toc
disp('Growing index pair...');
[X, A] = build_ip_raf(I, P, ADJACENCY);
disp('Done.');
toc

b = tree.boxes(full_depth);

show2(b(:,X)', 'y'); %'
show2(b(:,A)', 'r'); %'
show2(b(:,TOTAL)', 'k'); %'

% M = index_map_standard(X,A,I,b,'1.0-IA',P,full_depth);

toc

disp('Done. How about a picture?');

% draw_stable_manifold(0.8,500000,.00000001,26);
