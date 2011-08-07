
%res = [2 6 2 2 3 ...
%       5 3 2 2 -1 ...
%       -1 8 8 8 8];

% res = [-1 -1  4 -1  2 ...
%        -1 -1  3  3 -1 ...
%        -1 -1 -1 -1 -1];

apreps = [4.538452 4.540894 4.580000 4.632324 4.678772 4.783752 4.860000 ...
          4.967896 5.148315 5.400000 5.590000 5.650000 5.683960 5.685974 5.693420 5.849976];
res = repmat(-1,1,length(apreps));
res(11) = 8;

format long
data = {};
for i = 1:length(res)
  if res(i) < 0
    continue
  end
  
  fprintf('running plateau %i at depth 14 (28) with resolution %i...\n',i,res(i))
  
  box = 2.0 + (res(i)-1)*(0.25);
  str = sprintf(['data/henon_boxprm_28_%1.6f_%1.6f__%1.6f_%1.6f_-1.000000_-' ...
                 '1.000000'],box,box,apreps(i),apreps(i));
  disp(str)
  map = struct;
  load([str '.mat'])
  map.P = P;
  map.Adj = Adj;
  map.I = I;
  map.tree = Tree([str '.tree']);
  map.space = 'Rn';
  map.name = 'henon';
  map.prefix = str;
  
  d = compute_symbolics(map.I,map);
  save(sprintf('../plateaus/focm-data/ap%ir%i.mat',i,res(i)),'d');
  data{end+1} = d;
end
