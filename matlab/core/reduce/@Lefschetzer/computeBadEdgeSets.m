%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% lef = computeBadEdgeSets(lef,K)
%
% K - a.k.a. 'max_iter'; the number of iterations through the loop before
% giving up.
%
% Checks all paths of length up to K in a clever way, keeping track of sets
% of edges that lead to unverifiable cycles (= 0 Lefschetz computations)
%
% NOTE: all edges stored as integer id
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function lef = computeBadEdgeSets(lef,K)

  %%% INIT phase - initialize the matrix collection
  k = 0;								% path length 0
  M = 1;								% identity
  E = [];								% no edge
  for s = lef.polygen
	lef.matcol = addMatrix(lef.matcol,s,s,E,M,k);
  end

  %%% POLY phase - handle just regions with multiple generators
  for k = 0:K
%	fprintf('k = %d\n',k)
	for s = lef.polygen
	  for t = lef.polygen
%		disp([s t])
		for EandM = findEMpairs(lef.matcol,s,t,k)
		  E = EandM{1};				% numeric ids
%		  num2edge(E,lef.n)
		  M = EandM{2};
		  goodedges = goodEdges(lef,E,t);
%		  disp('good edges:')
%		  disp(num2edge(goodedges,lef.n))
		  for edge = goodedges

			[q u] = num2edge(edge,lef.n);
			if q~=t
			  'error! q~=t in computeBadEdges'
			end
			
			E2 = union(E, edge);
			M2 = lef.M(lef.G{u},lef.G{t}) * M;

			% case 1: cycle with 0 trace
			if (~any(any(M2)) || (s==u && trace(M2)==0))
%			  disp('bad edge set:')
%			  disp(num2edge(E2,lef.n))
			  lef.bad_edge_sets{end+1} = E2;  % cut the cycle later
			  lef.matcol = removeBad(lef.matcol,E2);
			  continue              % don't add it to matcol
			end

			if (~reductionExists(lef.matcol,s,u,E2,M2,k+1))
			  lef.matcol = addMatrix(lef.matcol,s,u,E2,M2,k+1);
			end
			% else case 2: don't add it, since this path is redundant
			
		  end
		end
	  end
	end

	[lef.matcol changed] = matrixAdded(lef.matcol);
	if (~changed)
%	  'no change: breaking'
	  break
	end
  end

  % add edge sets that have not been reduced after the K+1st iteration 
  B_r = remainingEdges(lef.matcol,K+1);
  lef.bad_edge_sets(end+1:end+length(B_r)) = B_r;

  %%% MONO phase - check connections between single and mult. gen. regions
  for u = lef.polygen
 	for v = lef.polygen
 	  into_u = intersect(mapimage(lef.SM',u),lef.monogen);
 	  outof_v = intersect(mapimage(lef.SM,v),lef.monogen);
	  for i = into_u
		for j = outof_v
		end_edges = edge2num([i u; v j],lef.n);
		  for EandM = getEMpairs(lef.matcol,u,v)
			E = EandM{1};
			M = EandM{2};
			if lef.M(lef.G{j},lef.G{v}) * M * lef.M(lef.G{u},lef.G{i}) == 0
			  lef.bad_edge_sets{end+1} = union(end_edges, E);
%			  disp('bad edge set (mono phase):')
%			  disp(num2edge(lef.bad_edge_sets{end},lef.n))
			end
		  end
		end		
	  end
	end
  end

  convert = @(E) num2edge(E,lef.n)';
  lef.bad_edge_sets = cellfun(convert, lef.bad_edge_sets, 'uniformoutput', 0);
