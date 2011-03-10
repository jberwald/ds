map = get_map('henon',10);
map = refine_map(map,11);
for k = [1 2 4 6 7 8 9]
  S = justorbits(map, k);
  dat = compute_symbolics(S, map);
end