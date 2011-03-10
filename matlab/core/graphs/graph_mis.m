function I=graph_mis(G)
% input: graph G, in sparse matrix form
% output: maximal invariant set I of G

G = spones(G);
if (isempty(G)), I=[]; return, end;

[comp_inds comps P] = components_raf(G);

% P = contract(G,comp_inds);		% new contracted poset, with a vertex (and loop) for each scc
% P = spdiags(sccs,0,P);			% loops only for scc's

sccs = diag(P); % loops of the contracted graph correspond to sccs
										
forward_children = find_children(P,find(sccs)');
backward_children = find_children(P',find(sccs)');

inv_comps = forward_children & backward_children;
I = cat(1,comps{inv_comps});		% concatenate the component lists

