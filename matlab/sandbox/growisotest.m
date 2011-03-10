map = get_map('henon',13);

S = [];
for i=1:1000
  S = [S randint(length(map.I))];
end

t = cputime;
S1 = grow_iso_raf(S,map.P,map.Adj);
fprintf('time for grow_iso_raf: %.2f\n',cputime-t);

t = cputime;
S2 = grow_iso_contract(S,map.P,map.Adj);
fprintf('time for grow_iso_contract: %.2f\n',cputime-t);


if all(S1 == S2)
  disp('and they are equal!')
else
  disp('shit I screwed something up...')
end