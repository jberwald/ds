function b = forward_rule(T,A,B)
  b = set_equal(mapimage(T,A),mapimage(T,B));       % same img
  b = b && disjoint(mapimage(T',A),mapimage(T',B)); % disjoint preimg
end
