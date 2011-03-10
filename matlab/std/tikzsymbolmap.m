function lines = tikzsymbolgraph(A,top)
  imgtop = mapimage(A,top);
  lines = {};
  for i = imgtop
    lines{end+1} = [];
    v = i;
    while length(v) == 1 && v ~= top
      lines{end} = [lines{end} v];
      v = mapimage(A,v);
    end
  end
  

    