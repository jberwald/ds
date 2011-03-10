% wrap around [0,w]
% important assumption: the width of any image is less than w!
function v = wrap_interval(u,w)
  
  a = mod(inf(u),w);
  b = mod(sup(u),w);

  if (b < a)
	v = [infsup(a,w) infsup(0,b)];
  else
	v = infsup(a,b);
  end

end

