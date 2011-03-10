function [Mmax entmax] = rand_surfing_test(map,maxper,trials)

C = get_orbits(map.prefix,maxper,map.P,map.Adj);
C = C(2:end,1);

n = length(C);
perm = randperm(n);

opts = struct('justentropy',1,'quiet',1);
[M ent Mmax entmax] = find_tipping_point(map,C,perm);
M = [M perm(length(M)+2)];              % next set to try (len(M)+1 already tried)

[Mmax entmax] = surf_set(map,C,M,trials)
