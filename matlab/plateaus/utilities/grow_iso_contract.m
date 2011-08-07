function I = grow_iso_contract(S, P, Adj, boxes)
% Grows an isolating neighborhood containing S.
% P = transition matrix
% Adj = adjacency matrix

%%%
%%% M = showtext(boxes,'+');
%%%

  % set up extra vertex v
%  tic
  n = size(P,1);
  v = n+1;
  P(v,v) = 1;
  Adj(v,v) = 1;
  P = (P~=0);
  Adj = (Adj~=0);
%  toc

  % initialize I (total inv set) and Ihat (current "shell")
%  tic
  I = inv_set(P,S);
  Ihat = I;
%  toc

  while (~isempty(Ihat))						% Ihat gave nothing new
	disp('step')
	% since v = total inv set so far and Ihat = next shell, oI is the one-box
    % nbhd of everything... this is why we contract Ihat to v in Adj
%	tic
	oI = onebox(union(Ihat,v),Adj);		% one-box nbhd of everything
%	toc
%	tic
	P = contract(P,Ihat,v);					% contract Ihat to v
	Adj = contract(Adj,Ihat,v);				% keep the topology the same too
%	toc
%	tic
	Ihat = setdiff(inv_set(P,oI),v);
	I = union(I,Ihat);
%	toc
  end

end

function A = contract(A,S,k)
%  t=cputime;
  imgs = img(A,S);
  preimgs = img(A',S);
%  fprintf('contract: %3.4f\n',cputime-t);
  A(imgs,k) = 1;
  A(k,preimgs) = 1;
  A(:,S) = 0;
  A(S,:) = 0;
%  fprintf('        : %3.4f\n',cputime-t);
end

function I = inv_set(A,S)
  I = S(graph_mis(sparse(A(S,S))));	% maximal invariant set in S
end

function i = img(A,S)
  i = find(any(A(:,S), 2));
end
