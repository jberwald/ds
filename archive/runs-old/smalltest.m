box = [1.532917,0.471667];
if (unix('ls smalltest.mat') ~= 0)
  [R G M SM tree P Adj] = puff_driver('henon',16,2,'options','noims','box',box);
  s = 1:4;
  SM(s,:) = 0;
  SM(:,s) = 0;
  I = graph_mis(SM);
  S = cat(2,R{I});
  [R G M SM] = compute_symbolics(S,tree,'henon',0,P,Adj,'noims');
  save('smalltest.mat','R','G','M','SM','S','I')
else
  load('smalltest.mat')
  [tree P Adj] = set_up_map_box('henon',0,16,box);
end

genfile = 'topdata/tmp/tmp-Ga9202-henon-gen.dat';
mapfile = 'topdata/tmp/tmp-Ga9202-henon-map.dat';
