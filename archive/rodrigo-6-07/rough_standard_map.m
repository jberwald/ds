
function rough_standard_map(mapname)
%
% function rough_standard_map(mapname)

tic

wrap_it_up;

disp('Calculating the point of intersection of the manifolds and drawing a pretty picture');
[centerx centery x_points y_points x_reverse y_reverse] = draw_stable_manifold(1.2,1000000,.00000001,20);

intersections = [0.5 centery; .5 1-centery]';

tree.count(-1);

homoclinic = tree.search(intersections);
disp('Done.');

fixed_connection1 = dijkstra(P,homoclinic(1),1);     
fixed_connection2 = dijkstra(P,1,homoclinic(2));
fixed_connection3 = dijkstra(P,homoclinic(2),1);
fixed_connection4 = dijkstra(P,1,homoclinic(1));

TOTAL = union(fixed_connection1, fixed_connection2);                                      
TOTAL = union(TOTAL, fixed_connection3);
TOTAL = union(TOTAL, fixed_connection4);

disp(sprintf('The symbolic length of the homoclinic orbit is at most %i',length(TOTAL)))
disp('Growing isolating neighborhood...');
I = grow_iso_raf(TOTAL, P, ADJACENCY);
disp('Growing index pair...');
[X, A] = build_ip_raf(I, P, ADJACENCY);
disp('Done.');

b = tree.boxes(-1);

show2(b(:,X)', 'y');                                             
show2(b(:,A)', 'r');
axis([0 1 0 1])

toc

% M = index_map(X,A,I,b,mapname,P);

toc
