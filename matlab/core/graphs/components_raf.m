
function [ind2comp comp2ind P] = components_raf(G)
% function [ind2comp comp2ind P] = components_raf(G)
% input: graph (sparse matrix) G
% output: ind2comp - an array mapping vertices to component numbers
%         comp2ind - a cell array mapping component numbers to the vertices
%            in that component
%         P - new contracted graph, with a vertex (and loop) for each scc

if ~issparse(G)
  if all(size(G)==[1 1])
    ind2comp = 1;
    comp2ind = 1;
    P = sparse(1);
    return
  end
end


[ind2comp comp_sizes] = components(G);	% uses matlab_bgl's components function
cn = length(comp_sizes);
n = size(G,1);

% compute comp2ind array
comp2ind = cell(cn,1);
indices = zeros(cn,1);

for i=1:cn
  comp2ind{i} = zeros(comp_sizes(i),1);
end

for i=1:n
  c = ind2comp(i);
  indices(c) = indices(c)+1;
  comp2ind{c}(indices(c)) = i;
end


P = contract_vertices(G,ind2comp,cn); 	% contract the sccs to vertices

% % find the scc's
% loops = spdiags(G,0);			% main diagonal of G
% big_components = comp_sizes(ind2comp) - ones(n,1); % non-loop scc's (strongly-connected components)
% nsccs = ~(loops | big_components);	% all non-scc's (original indices)
% nsccs_contracted = ind2comp(find(ind2comp .* nsccs)); % new indices for non-scc's
% nsccs_bitvec = zeros(cn,1);
% nsccs_bitvec(nsccs_contracted) = 1;
% sccs_bitvec = ~nsccs_bitvec;
% sccs = sccs_bitvec;
