function [C N] = find_connections_adj(A,B,N,P,Adj)
% maybe be a little smarter about how we pick the connections to try,
% since we want to connect there and back

  R_A = get_regions(A,Adj);
  R_B = get_regions(B,Adj);

  fprintf('\n (A has %d regions, B has %d regions)\n',length(R_A), length(R_B));

  C = [];

  for j = 1 : length(R_A)
	for k = 1 : length(R_B)

	  if (~disjoint(R_A{j}, R_B{k}))
		continue;
	  end

	  % connect any pt of R_A{j} to any pt of R_B{k}
	  conn = find_connections_old(R_A{j}, R_B{k}, N, P, Adj);
	  conn = setdiff(conn, R_A{j});
	  conn = setdiff(conn, R_B{k});
	  if (isempty(conn))
		continue;
	  end

	  new_nhood = grow_iso_raf(conn, P, Adj);
	  new_nhood = union(new_nhood, conn); % there might not even be an invariant set in conn.

	  if (disjoint(new_nhood, N))    	% completely disjoint from the rest
		if (~is_adjacent(new_nhood, N, Adj)) % not adjacent to the current nhoods
		  N = [N new_nhood];
		  C = [C conn];
		end
	  end

	end	
  end
end

