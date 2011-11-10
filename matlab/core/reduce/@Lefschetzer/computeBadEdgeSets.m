%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% lef = computeBadEdgeSets(lef,K)
%
% Checks ALL paths of length up to K in an inductive way, keeping track of
% sets of edges that lead, or could lead, to unverifiable cycles (meaning 0
% trace).
%
% NOTE: all edges stored as a hash (integer id)
%
% Variables:
% lef - the Lefschetzer object
% K - a.k.a. 'max_iter'; the number of iterations through the loop before
% giving up.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function lef = computeBadEdgeSets(lef,K)

  %%% INIT phase - initialize the matrix collection
  % This is just the base case of our induction.
  k = 0;								% path length 0
  M = 1;								% identity
  E = [];								% no edge
  for s = lef.polygen
	lef.matcol = addMatrix(lef.matcol,s,s,E,M,k);
  end

  %%% POLY phase - just regions multiple generators
  % 
  for k = 0:K                           % k - length of the current path
	for s = lef.polygen                 % s - start node
	  for t = lef.polygen               % t - end node
        
        % loop over all s-t paths of length k
		for EandM = findEMpairs(lef.matcol,s,t,k)
		  E = EandM{1};				    % E - edge set of current path
		  M = EandM{2};                 % M - matrix product of current path

		  % goodedges - all non-redundant edges emerging from t
          goodedges = goodEdges(lef,E,t);
		  for edge = goodedges          % edge - out of t

			[q u] = num2edge(edge,lef.n); % u - endpoint of edge
			if q~=t                     % t had better be the the other end!
			  'error! q~=t in computeBadEdges'
			end
			
			E2 = union(E, edge);        % E2 - the new edge set
			M2 = lef.M(lef.G{u},lef.G{t}) * M; % M2 - the new matrix product

			% Now for the actual check -- could this product M2 lead to a
            % cycle with nonzero trace?  Two ways this could happen: (1) M2 is
            % the zero matrix, so the product along any path containing it
            % will be 0, or (2) the current path /is/ a cycle (i.e. s==u) and
            % the product M2 has trace 0.
            % 
            % If either (1) or (2) hold, we have to make sure this s-u path
            % does not appear in the final symbol matrix.  Hence, we add the
            % set of edges in the path to the 'bad edge sets', which we will
            % make sure we take care of later.
			if (~any(any(M2)) || (s==u && trace(M2)==0))
			  lef.bad_edge_sets{end+1} = E2;  % cut the cycle later
			  lef.matcol = removeBad(lef.matcol,E2); % optimization
			  continue                  % don't this path to matcol
			end

            % If we made it here, the path was not obviously a problem, but
            % we still need to explore "descendents" of this path.
            % Fortunately, we may be able to check these descendents
            % inductively, using the following rule:        
            % 
            % If an s-u path p results in a matrix product M, and smaller s-u
            % path q results in cM for some nonzero scalar c, and q uses only
            % edges from p, then we can ignore p "by induction".
            % 
            % reductionExists(...) performs exactly this inductive check.  If
            % it passes, we can ignore all descendents of this path, but if
            % it fails, we have to keep checking them.
			if (~reductionExists(lef.matcol,s,u,E2,M2,k+1))
			  lef.matcol = addMatrix(lef.matcol,s,u,E2,M2,k+1);
			end
			
		  end
		end
	  end
	end

    % If we didn't add any paths this round, then by induction we have
    % checked ALL paths.  w000t!!
	[lef.matcol changed] = matrixAdded(lef.matcol);
	if (~changed)
	  break
	end
  end

  % If we reached the cutoff K, but did not manage to reduce all remaining
  % paths to smaller ones, then we are unable to verify any cycles containing
  % these remaining paths.  Hence, we have no choice but to ensure that no
  % such path makes it to the final SM, meaning we have to add each of the
  % edge sets for these paths to bad_edge_sets.
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
