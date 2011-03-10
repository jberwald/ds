function I = grow_iso_raf(S, P, Adj)
% Grows an isolating neighborhood containing S.
% P = transition matrix
% Adj = adjacency matrix

  while 1								% loop forever
%	disp('step')
%	t = cputime;
    I = S(graph_mis(sparse(P(S,S))));	% maximal invariant set of S
    oI = onebox(I,Adj);    				% one-box neighborhood of I
%	cputime - t
    if (subset(oI, S))
      return;
    end
    S = oI;
  end
end
