function M = can_contract_matrix(A)

n = size(A,1);

for i=1:n
  for j=i+1:n
	M(i,j) = can_contract(A,i,j);
	if M(i,j)
	  disp([i j])
	end
  end
end
