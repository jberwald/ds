map = get_map('henon',12);
for k = [1 2 4 6 7 8 9]
  fprintf(' * period %d * \n',k)
  sets = justorbits(map, k);
  dat = compute_symbolics(sets{1}, map);
end