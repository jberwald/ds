function [Mmax entmax] = rand_surfing_test(map,C,M,trials)

n = length(C);
opts = struct('justentropy',1,'quiet',1);
Mmax = M;
entmax = 0;

for t = 1:trials
  
  fprintf('%i ',M)
  fprintf(':  ')
  
  S = unique(cat(2,C{M}));
  dat = compute_symbolics(S, map, opts);
  
  fprintf('%.6f\n',dat.hmax)
  
  if (length(dat.R) > 1)
    s = setdiff(1:n,M);
    M = [M s(randint(length(s)))];
    ent = dat.hmax;
    if ent > entmax
      Mmax = M;
      entmax = ent;
    end
  else
    r = randint(length(M));
    M = M([1:(r-1) (r+1):length(M)]);
  end
end
