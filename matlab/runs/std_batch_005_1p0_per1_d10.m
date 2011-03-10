opts = struct;
width = 0.005;
depth = 10;
for eps = 1.0 : width : (1.2 - width)
  std_run_int(eps,width,depth,opts);
end
