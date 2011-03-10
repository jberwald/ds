function ents = rand_maximal_test(map,maxper,trials)

C = list_pps(maxper,map.P,map.Adj);
C = C(2:end,1);

ents = {}
for t = 1:trials
  fprintf('** trial %i **\n',t)
  n = length(C);
  perm = randperm(n)
  iperm = inv_perm(perm,n);
  [M e Mmax emax] = maximal_orbit_set(map,C(perm));
  if emax > e
    fprintf('*** BEST IN RUN was %.6f :',emax)
    fprintf(' %i',iperm(Mmax))
    fprintf('\n')
  end
    
  ents{t,1} = e;
  ents{t,2} = iperm(M);                 % original numbers!
end

for t = 1:trials
  fprintf('%.6f :',ents{t,1})
  fprintf(' %i',sort(ents{t,2}))
  fprintf('\n')
end

%fprintf('max entropy: %.6f\n',max(cellfun(@max,ents(:,1))))

% map = get_map('henon',9);
% justorbits_batch(map,8,3);
% map = get_map('henon',10);
% justorbits_batch(map,12,3);
% map = get_map('henon',11);
% justorbits_batch(map,12,3);
