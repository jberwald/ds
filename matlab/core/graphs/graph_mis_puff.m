function [I,I_f] = graph_mis_puff(G,Adj)
% input: graph G, adjacency matrix Adj
% output: maximal invariant set I of G, and the eventual image I_f of I

G = spones(G);
if (isempty(G)), I=[]; return, end;

[comp_inds comps P] = components_raf(G);

% P = contract(G,comp_inds);		% new contracted poset, with a vertex (and loop) for each scc
% P = spdiags(sccs,0,P);			% loops only for scc's

sccs = diag(P); % loops of the contracted graph correspond to sccs
										
forward_children = logical(find_children(P,find(sccs)'));
backward_children = logical(find_children(P',find(sccs)'));

inv_comps = forward_children & backward_children;
I = cat(1,comps{inv_comps});		% concatenate the component lists
I_f = cat(1,comps{forward_children});

