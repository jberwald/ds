%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% search_edges - 8/4/2008
%
%   Recursively finds the highest rigorous entropy bound possible for SM
%
% input: (SM, bad_edge_sets, edge_list, culled_edges, ...
%         best_edges, best_entropy, search_cutoff)
%
%   Note: all edges are stored as single integers
%
%   SM - symbol matrix according to the index map (so, not yet rigorous)
%   bad_edge_sets - sets of edges that need to be cut
%   edge_list - list of edges deleted from SM so far
%   culled_edges - edges already searched in this branch
%   best_edges - edges removed to get symbol matrix with entropy == best_entropy
%   best_entropy - highest proven entropy bound so far
%   search_cutoff - how many iterations left before giving up
%
% output: [best_edges best_entropy search_cutoff]
%   (the next iteration of these values)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [best_edges best_entropy search_cutoff] ...
 = search_edges(SM, bad_edge_sets, edge_list, culled_edges, ...
				best_edges, best_entropy, search_cutoff)

  if (search_cutoff > 0)
	search_cutoff = search_cutoff - 1;
  end

  % prune subtree if we're already worse than the max so far:
  if (log_max_eig(SM) < best_entropy  || search_cutoff == 0) % or search timed out
	return
  end

  if (isempty(bad_edge_sets))				% at a 'leaf'
%	fprintf('--> %d\n',log_max_eig(SM)); %%%
	best_edges = edge_list;
	best_entropy = log_max_eig(SM);
  else

	% list and sort all possible bad edges
%	culled_edges
	edges = setdiff(bad_edge_sets{1},culled_edges);

    for edge = edges
	  edge_list2 = [edge_list edge];	% new edge list
	  SM2 = kill_edge(SM, num2edge(edge,size(SM,1))); % kill the edge
	  sets2 = bad_edge_sets(cellfun(@(S) ~ismember(edge,S), ...
									bad_edge_sets)); % sets without the edge
	  [best_edges best_entropy search_cutoff] ...
		  = search_edges(SM2, sets2, edge_list2, culled_edges, ...
						 best_edges, best_entropy, search_cutoff);
	  culled_edges(end+1) = edge;		% add the new edge to culled edges
                                        % for this branch
	end
  end
end

