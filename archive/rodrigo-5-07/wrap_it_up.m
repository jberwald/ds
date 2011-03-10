
% This function is to wrap a rectangle which GAIO uses to a torus so we can
% analyze the dynamics on a torus of the standard map.


m = Model('stan_map');
map_henon = Integrator('Map');
map_henon.model = m;
map_henon.tFinal = 1;
m.dim = 2;

c = [0.5,0.5];
r = [0.5,0.5];

tree = Tree(c(1:m.dim), r(1:m.dim));
tree.integrator = map_henon;
lip = Points('Lipschitz',m.dim);
tree.domain_points=lip;
tree.image_points=Points('Vertices',m.dim);

depth = 18;
to_be_subdivided = 4;

for i=1:depth
tree.set_flags('all',to_be_subdivided);
tree.subdivide(to_be_subdivided);
end

P = tree.matrix(lip);

toc

P = spones(P);
P = sparse(P);

% disp('Saving and clearing the transition matrix');
% save working_matrix.mat P
% clear P

tree.count(depth);

left_edges = zeros(2,depth);
right_edges = ones(2,depth);
upper_edges = ones(2,depth);
lower_edges = zeros(2,depth);

for i = 1 : 2^(depth/2)
    
    left_edges(2,i) = i*2^(-depth/2) - 2^(-depth/2 - 1);
    left_edges(1,i) = 2^(-(depth/2)-1);
    right_edges(2,i) = i*2^(-depth/2) - 2^(-depth/2 - 1);
    right_edges(1,i) = 1 - 2^(-(depth/2)-1);
    upper_edges(1,i) = right_edges(2,i) ;
    upper_edges(2,i) = 1 - 2^(-(depth/2)-1);
    lower_edges(1,i) = left_edges(2,i);
    lower_edges(2,i) = 2^(-(depth/2)-1);
    
end
    
left_edge = tree.search(left_edges,depth);
right_edge = tree.search(right_edges,depth);
upper_edge = tree.search(upper_edges, depth);
lower_edge = tree.search(lower_edges, depth);

disp('packing');

pack

toc
disp('adjacency matrix...');

ADJACENCY = adj_matrix(tree, depth);
ADJACENCY = spones(ADJACENCY);


for i = 1 : 2^(depth/2)
    
    ADJACENCY(upper_edge(i),lower_edge(i)) = 1;
    ADJACENCY(lower_edge(i),upper_edge(i)) = 1;
    ADJACENCY(right_edge(i),left_edge(i)) = 1;
    ADJACENCY(left_edge(i), right_edge(i)) = 1;
    
end

ADJACENCY(lower_edge(1),upper_edge(2^(depth/2))) = 1;
ADJACENCY(upper_edge(2^(depth/2)),lower_edge(1)) = 1;
ADJACENCY(left_edge(1),right_edge(2^(depth/2))) = 1;
ADJACENCY(right_edge(2^(depth/2)),left_edge(1)) = 1;

toc

% load working_matrix.mat
