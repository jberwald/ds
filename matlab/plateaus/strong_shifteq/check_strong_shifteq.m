function check_strong_shifteq(SH,A,B)

  pass = 1;

  if (all(all(A == SH{1,1}*SH{1,2})))
	disp('A = R_1 S_1')
  else
	disp('A != R_1 S_1 !!!')
	pass = 0;
  end

  for k = 1 : size(SH,1)-1
	
	if (all(all(SH{k,2}*SH{k,1} == SH{k+1,1}*SH{k+1,2})))
	  fprintf('S_%i R_%i = R_%i S_%i\n',k,k,k+1,k+1)
	else
	  fprintf('S_%i R_%i != R_%i S_%i !!!\n',k,k,k+1,k+1)
	  pass = 0;
	end

  end

  k = size(SH,1);
  if (all(all(SH{end,2}*SH{end,1} == B)))
	fprintf('S_%i R_%i = B\n',k,k)
  else
	fprintf('S_%i R_%i != B !!!\n',k,k)
	pass = 0;
  end

  if (pass)
	disp(['All tests passed, so this is a strong shift equivalence between A' ...
		  ' and B.  By Williams in his "classification of subshifts of finite' ...
		  ' type", the subshift for A is conjugate to the subshift for B'])
  end

end
