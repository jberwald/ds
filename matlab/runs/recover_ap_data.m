paramstr = '5.683960';
boxstr = '2.500000';
prefix = ['data/henon_boxprm_28_' boxstr '_' boxstr '__' paramstr '_' paramstr ...
          '_-1.000000_-1.000000'];
           
map = get_map('henon',1,'params',[eval(paramstr) -1]);
map.tree = Tree([prefix '.tree']);
load([prefix '.mat'])
map.P = P;
map.Adj = Adj;
map.I = I;

dat = compute_symbolics(map.I,map);