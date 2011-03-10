map = get_map('henon',13);
% for k = [1 2 4 6 7 8 9 10]
for k = [9 10]
  fprintf(' * period %d * \n',k)
  sets = justorbits(map, k);
  dat = compute_symbolics(sets{1}, map);
end