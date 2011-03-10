opts = struct;
width = 0.005;
depth = 10;
for eps = (1.4-width) : -width : 1.2
  std_run_int(eps,width,depth,opts);
end
