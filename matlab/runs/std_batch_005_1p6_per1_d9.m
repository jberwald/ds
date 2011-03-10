opts = struct;
width = 0.005;
depth = 9;
for eps = 1.6 : width : (1.8 - width)
  std_run_int(eps,width,depth,opts);
end
