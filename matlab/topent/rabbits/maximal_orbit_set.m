function [M ent Mmax entmax] = maximal_orbit_set(map,C,M,ent)
% function [M ent] = maximal_orbit_set(map,C [,M,ent])
% note: for now, this is henon-specific!!
% (the 1-region rule are what make this henon-specific)

opts = struct('justentropy',1);

n = length(C);

if nargin < 3
  [M ent Mmax entmax] = find_tipping_point(map,C);
  Mbar = length(M)+2 : n;
else
  entmax = ent;
  Mmax = M;
  Mbar = setdiff(1:n,M);
end

% okay, maximal with respect to k+1, but now try all the other elements:

for j = Mbar
  fprintf('j = %i\n',j)

  S = unique(cat(2,C{[M j]}));
  dat = compute_symbolics(S, map, opts);
  
  if (length(dat.R) > 1)
    M = [M j];
    ent = dat.hmax;
    if ent > entmax
      Mmax = M;
      entmax = ent;
    end
  end
end