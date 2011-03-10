
% function homoclinic_standard_map
%
% Adapted from full_standard_map.m where the suggested improvements are made.
%
% April 16, 2007
%
% The new approach is the following: Instead of using Dijkstras algorithm to
% compute the homoclinic points, we will calculate them explicitly from the
% first intersection of the invariant manifolds. That is, once we know where
% they first intersect, we iterate the map both forwards and backwards N 
% times, where N is about 10. That way we get the points we need, then we
% see which boxes they correspond to, and then we grow index pairs and all
% that.

tic

dim = 2;
c = [0.5,0.5];
r = [0.5,0.5];

tree = Tree(c(1:dim), r(1:dim));
interval_map = @(x,y) standard_int_image_old(x,y);

initial_depth = 16;     % This initial depth is as far as we go before 
full_depth = 26;        % we clean up a little.
to_be_subdivided = 4;

increment = 2^(-(initial_depth+2)/2);

for i=1:initial_depth
  tree.set_flags('all',to_be_subdivided);
  tree.subdivide(to_be_subdivided);
end

disp('Computing the point of intersection of the stable and unstable manifolds...');
[centerx centery x_points y_points x_reverse y_reverse] = draw_stable_manifold(0.75,250000,.00000001,29);

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
axis([0 1 0 1])

%% Here we perform Dijkstras algorithm for the first time to keep a 
%% neighborhood of the homoclinic orbit.

disp('Coputing the homoclinic orbit...');

intersections = [0.5 centery; .5 1-centery]';  % '

homos1 = zeros(2,20);
homos2 = zeros(2,20);
homos1(1,1) = .5;
homos1(2,1) = centery;
homos2(1,1) = .5;
homos2(2,1) = 1-centery;
homos1(1,11) = .5;
homos1(2,11) = centery;
homos2(1,11) = .5;
homos2(2,11) = 1-centery;

for i = 1 : ((length(homos1)/2) - 1)

  [homos1(1,i+1) homos1(2,i+1)] = SM_iteration(homos1(1,i),homos1(2,i),.8);
  [homos2(1,i+1) homos2(2,i+1)] = SM_iteration(homos2(1,i),homos2(2,i),.8);
  [homos1(1,i+1) homos1(2,i+1)] =  [mod(homos1(1,i+1),1) mod(homos1(2,i+1),1);
  [homos2(1,i+1) homos2(2,i+1)] =  [mod(homos2(1,i+1),1) mod(homos2(2,i+1),1);

end

for i = ((length(homos1)/2) + 1) : (length(homos1) - 1)  %% UNDER CONSTRUCTION

  [homos1(1,i+1) homos1(2,i+1)] = SM_inverse(homos1(1,i),homos1(2,i),.8);
  [homos2(1,i+1) homos2(2,i+1)] = SM_inverse(homos2(1,i),homos2(2,i),.8);
  [homos1(1,i+1) homos1(2,i+1)] = [mod(homos1(1,i+1),1) mod(homos1(2,i+1),1)];
  [homos2(1,i+1) homos2(2,i+1)] = [mod(homos1(1,i+1),1) mod(homos1(2,i+1),1)];

end

homo1_boxes = tree.search(homos1)
homo2_boxes = tree.search(homos2)
TOTAL = union(homo1_boxes,homo2_boxes);
TOTAL = [TOTAL 1];

TOTAL = get_nbhd(tree, TOTAL, initial_depth);

disp('Done.');
toc

b = tree.boxes(-1);
show2(b(:,TOTAL)','g');  % '
axis([0 1 0 1])    
                
    %%  DEBUGGING IS BEING DONE IN THIS SECTION
n = tree.count(-1);
unset = ones(1, n);
inv_bits = repmat('0',[1 n]);
inv_bits(TOTAL) = '1';  
tree.set_flags(inv_bits, hit);
tree.remove(hit);

b = tree.boxes(-1);
b(:,[1:10]);
figure
show2(b','r');  % '
axis([0 1 0 1])

disp('Done.');

%% Now that we threw boxes away we subdivide further.

for i=(initial_depth+1) : full_depth
  tree.set_flags('all',to_be_subdivided);
  tree.subdivide(to_be_subdivided);
end

toc
disp('Computing the adjacency matrix and identifying the edges')
wrap_it_up_better
disp('Done.');
toc
disp(sprintf('We are working with a total of %i boxes.', length(ADJACENCY(1,:))))
disp('Computing transition matrix...');

P = rigorous_matrix_stan(tree, full_depth, interval_map); 
toc
P = spones(P);
P = sparse(P);
toc

tree.count(-1);

homo1_boxes = tree.search(homo1);
homo2_boxes = tree.search(homo2);
TOTAL = union(homo1_boxes,homo2_boxes);
TOTAL = [TOTAL 1];

disp(sprintf('The symbolic length of the homoclinic orbit is at most %i',length(TOTAL)))
disp('Growing isolating neighborhood...');
I = grow_iso_raf(TOTAL, P, ADJACENCY);
disp('Growing index pair...');
[X, A] = build_ip_raf(I, P, ADJACENCY);
disp('Done.');

b = tree.boxes(full_depth);

show2(b(:,TOTAL)', 'k'); %'
show2(b(:,X)', 'y'); %'
show2(b(:,A)', 'r'); %'
axis([0 1 0 1])

M = index_map_standard(X,A,I,b,'0.75-IA',P,full_depth);

toc

disp('Done. How about a picture?'); 

% draw_stable_manifold(0.8,500000,.00000001,26);
