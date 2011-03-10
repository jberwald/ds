map = get_map('henon',9);
maxper = 10;
trials = 2;

C = list_pps(maxper,map.P,map.Adj)
n = size(C,1);

E = {};

for t = 1:trials
  p = 1:n;
  for k = 1:maxper
    perk = find(cat(2,C{:,2})==k);      % per k orbits
    perm_k = randperm(length(perk));
    p(perk) = p(perk(perm_k));          % permute the period k orbits
  end
  p
  E{t,1} = p;
  E{t,2} = justorbits_batch(map,maxper,4,C);
end

for t = 1:trials
  [ent ind] = max(E{t,2});
  fprintf('ent = %.6f ',ent)
  fprintf('orbits: ')
  fprintf('%i ',E{t,1}(1:ind))
  fprintf('\n')
end