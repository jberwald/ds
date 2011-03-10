function [M ent Mmax entmax] = find_tipping_point(map,C,perm)
% function [M ent Mmax entmax] = find_tipping_point(map,C [,perm])
% note: for now, this is henon-specific!!
% (the 1-region rule are what make this henon-specific)

if nargin < 3
  n = length(C);
  perm = 1:n;
else
  n = length(perm);
  C = C(perm); % C_new(i) = C_old(perm(i))
end

opts = struct('justentropy',1);
entmax = 0;
kmax = 0;
ents = zeros(1,n);
regs = ones(1,n);

lo=1;
hi=n;
while (lo <= hi)
  k = fix((lo+hi)/2);
  fprintf('k = %i\n',k)
  %% this should be a subfunction but matlab-mode is crashing:
  
  S = unique(cat(2,C{1:k}));
  dat = compute_symbolics(S, map, opts);
  ents(k) = dat.hmax;
  regs(k) = length(dat.R);
  if ents(k) > entmax
    kmax = k;
    entmax = ents(k);
  end
  
  if (regs(k) == 1 || (k > kmax && ents(k) < entmax)) % one reg or ent went down
    hi = k - 1;
  else
    lo = k + 1;
  end
end

k = fix((lo+hi)/2);
ent = ents(k);

M = perm(1:k);
Mmax = perm(1:kmax);