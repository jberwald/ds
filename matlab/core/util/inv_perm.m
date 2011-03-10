function q = inv_perm(p,n)
% inverts a permutation p over 1:n

k = length(p);
q = [p ones(1,n-k)];
q(q) = 1:max(k,n);
