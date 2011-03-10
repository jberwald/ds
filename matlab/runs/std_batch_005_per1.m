opts = struct;
width = 0.005;
for eps = 1.8 : width : (2.0 - width)
  std_run_int(eps,width,8,opts);
end
