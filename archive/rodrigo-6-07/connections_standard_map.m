
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
interval_map = @(x,y) standard_int_image_old(x,y);
epsilon = 1.5;

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

tree.count(-1);
 
first_box = tree.search([increment;increment], full_depth);
last_box = tree.search([1-increment;1-increment], full_depth);
period_two = period_2(epsilon);
p2 = tree.search(period_two);
p2 = p2'; %'
P(first_box,last_box)=1;
P(last_box,first_box)=1;
%period_three = find(diag(P^3));
b = tree.boxes(full_depth);
toc
%disp('Throwing bad boxes away...')
%p3 = keep_hyperbolic(3,period_three,epsilon,b,P);#path ~/public_html/dynamics/
TOTAL = [first_box last_box p2];
%toc

connection1 = dijkstra(P,p2(1),first_box);
connection2 = dijkstra(P,first_box,p2(1));
connection3 = dijkstra(P,p2(2),first_box);
connection4 = dijkstra(P,first_box,p2(2));

TOTAL = union(connection1, connection2);
TOTAL = union(TOTAL,connection3);
TOTAL = union(TOTAL,connection4);
TOTAL = union(TOTAL, p2);

%%%%%% THIS IS OPTIONAL, PERHAPS TRIGGER IT WITH A SWITCH?  %%%%%%%
%
% Here we can combine the approach of getting homoclinic orbits through
% intersections of the stable and unstable manifolds with the connecting
% approach to get a lot of cool dynamics.
%

disp('Figuring out homoclinic orbits...')

[centerx centery x2 y2 x_points y_points x_reverse y_reverse x_pointss y_points ...
 x_reverses y_reverses]=draw_invariant_manifolds(epsilon);

intersections1 = [0.5 centery; .5 1-centery]'; %'
intersections2 = [x2 y2; 1-x2 1-y2]'; %'
homoclinic1 = tree.search(intersections1);
homoclinic2 = tree.search(intersections2);

fixed_connection1 = dijkstra(P,first_box,homoclinic1(1));
fixed_connection2 = dijkstra(P',bottom_right_box,homoclinic1(1)); %'
fixed_connection3 = dijkstra(P,homoclinic1(2),top_left_box);
fixed_connection4 = dijkstra(P',homoclinic1(2),top_right_box); %'

fixed_connection5 = dijkstra(P,first_box,homoclinic2(1));
fixed_connection6 = dijkstra(P',bottom_right_box,homoclinic2(1)); %'
fixed_connection7 = dijkstra(P,homoclinic2(2),top_left_box);
fixed_connection8 = dijkstra(P',homoclinic2(2),top_right_box); %'

homoclinics = [];
homoclinics = union(homoclinics,fixed_connection1);
homoclinics = union(homoclinics,fixed_connection2);
homoclinics = union(homoclinics,fixed_connection3);
homoclinics = union(homoclinics,fixed_connection4);
homoclinics = union(homoclinics,fixed_connection5);
homoclinics = union(homoclinics,fixed_connection6);
homoclinics = union(homoclinics,fixed_connection7);
homoclinics = union(homoclinics,fixed_connection8);
toc

%%%%   Periods 3 now. p3 is for depth 18 only with e=2   %%%%

%disp('Doing the period three...');

%p3 = [5393 16155 16156 16159 16166 229788 229789 229810 81990 245965 245966 245967 32335 32336 32354];

%connection13 = dijkstra(P,first_box,p3(1)); 
%connection31 = dijkstra(P,p3(1),first_box);
%connection133 = dijkstra(P,first_box,p3(14));
%connection331 = dijkstra(P,p3(14),first_box);
%TOTAL = union(TOTAL,connection13);
%TOTAL = union(TOTAL,connection31);
%TOTAL = union(TOTAL,connection133);
%TOTAL = union(TOTAL,connection331);
%TOTAL = union(TOTAL,p3);           

%connection23 = dijkstra(P,p2(1),p3(1));      
%connection32 = dijkstra(P,p3(1),p2(1));
%connection233 = dijkstra(P,p2(1),p3(14));
%connection332 = dijkstra(P,p3(14),p2(1)); 
%connection223 = dijkstra(P,p2(2),p3(1)); 
%connection322 = dijkstra(P,p3(1),p2(2));
%connection2233 = dijkstra(P,p2(2),p3(14));
%connection3322 = dijkstra(P,p3(14),p2(2));
%TOTAL = union(TOTAL,connection23);        
%TOTAL = union(TOTAL,connection32);
%TOTAL = union(TOTAL,connection233);
%TOTAL = union(TOTAL,connection332);
%TOTAL = union(TOTAL,connection223);
%TOTAL = union(TOTAL,connection322);
%TOTAL = union(TOTAL,connection2233);
%TOTAL = union(TOTAL,connection3322);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Connecting stuff up...')
%conns = find_connections(TOTAL,TOTAL,P);
%TOTAL = union(conns,TOTAL);
TOTAL = union(TOTAL,homoclinics);

disp('Done.')
toc

disp(sprintf('The symbolic length of the homoclinic orbit is at most %i',length(TOTAL)))
disp('Growing isolating neighborhood...');
I = grow_iso_raf(TOTAL, P, ADJACENCY);
toc
disp('Growing index pair...');
[X, A] = build_ip_raf(I, P, ADJACENCY,tree);
disp('Done.');
toc

b = tree.boxes(full_depth);

show2(b(:,X)', 'y'); %'
show2(b(:,A)', 'r'); %'
show2(b(:,TOTAL)', 'k'); %'

M = index_map_standard(X,A,I,b,'1.5-IA-depth20',P,full_depth);

toc

disp('Done. How about a picture?');

% draw_stable_manifold(0.8,500000,.00000001,26);
