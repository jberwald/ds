
params = infsup(1.600,1.605)
opts = struct('per2',1);
depth = 10

for v = [1 1 2 2; 1 2 1 2]
  opts.p2_1 = v(1);
  opts.p2_2 = v(2);
%  opts.imgname = sprintf('output/p2-%i-%i',v(1),v(2));
  opts
  mapname = sprintf('p2_1p6_%i_%i',v(1),v(2));
  
  map = get_map('std',6,'params',params);
  map = homoclinic_insertion_skinny(map, depth, opts)
end

