% map = get_map('henon',8);
% C = pp_map(map,15,13);
% map = get_map('henon',13);
% PP = candidates_to_pps(C,map.P,map.Adj);
% PPclean = clean_pps(PP,map);
% save henonp15d13 PPclean
% clear all


T = 10;
maxper = 12;

load henonp15d13
map = get_map('henon',13);
%C = get_orbits(map,maxper);
C = PPclean;
C = C(2:end,1);
n = length(C);

ents = {};
  % for t = n:-1:2
  % perm = t:-1:1;
for t = 1:T
  perm = randperm(n);

  fprintf('** Trial %i:',t)
  fprintf(' %i',perm)
  fprintf('\n')

  [M ent Mmax entmax] = find_tipping_point(map,C,perm);

  fprintf('** %d orbits:',entmax)
  fprintf(' %i',Mmax)
  fprintf('\n')

  ents{t,1} = entmax;
  ents{t,2} = Mmax;
end

%[Mmax entmax] = rand_surfing(map,period,T);

%save rabbits_tipping_test_d11.mat
clear map
save rabbits_tipping_test_d13_5.mat

% map = get_map('henon',9);
% justorbits_batch(map,8,3);
% map = get_map('henon',10);
% justorbits_batch(map,12,3);
% map = get_map('henon',11);
% justorbits_batch(map,12,3);
