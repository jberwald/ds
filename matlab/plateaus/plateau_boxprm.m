function [E D] = plateau_boxprm(plats,depths,dlen,platfile)
% function [E D] = plateau_boxprm(plats,depths,dlen [, platfile])
% dlen = # of boxes between depths
% dvec = which box sizes (between 1 and dlen) to compute
% E - entropy matrix
% D - data matrix (R G M SM X A I Z)

  %  dvec = dlen:-1:1; % fixes the ordering problem
  %% BUG: doesn't really fix the problem because you say
  %%% "for d = dvec", so you just change the order in which you
  %%% compute them, not the order in which they are put in the
  %%% matrix.  Solution: "for d = 1:dlen" and replace "d" by
  %%% "dvec(d)" in some places, but keep "d" for the matrix.
  
  if (nargin < 4)
	platfile = 'plateaus/repdat.mat';
  end

  load(platfile)						% get 'reps'
  
  E = zeros(length(plats),length(depths)*dlen);
  D = cell(length(plats),length(depths)*dlen);

  for p = 1 : length(plats)

	for i = 1 : length(depths)*dlen

	  [depth box d] = plats_num2depth(i,depths,dlen)
	  [tree P Adj] = get_map_old('henon', depth, ...
							     'params', reps(plats(p),:), ...
							     'box', box);
	  [R G M SM X A I Z] = ...
		  compute_symbolics(1:tree.count(-1),tree,'henon',P,Adj,'noims');

	  D{p, i} = {R G M SM X A I Z};
	  E(p, i) = log_max_eig(SM);
		
	  fprintf('plateau %i, depth %i.%i (%i): entropy = %3.4f\n', ...
			  plats(p), depth, d, i, E(p,i));

	end

	close all

  end
  
  
  
