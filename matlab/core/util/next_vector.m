
function v = next_vector(v, sizes)
% runs though all vectors v with v(i) in [1,sizes(i)]
% v = current vector
% sizes = vector of max sizes for each entry of v

for i = 1 : length(v)
  v(i) = v(i) + 1;

  if (v(i) == sizes(i)+1)
	v(i) = 1;
  else
	break;
  end
end
