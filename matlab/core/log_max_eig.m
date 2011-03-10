function a = log_max_eig(M)
% function a = log_max_eig(M)
% returns log(||v||), where v is the leading eigenvalue of M (or 0 if M=0)
% acutally, returns max(0,log(||v||)), since we use this for entropy, which
% is always >= 0

  if (isempty(M) || ~any(any(M)))
	a = 0;
	return;
  end

  if (size(M,1) == 1)
	eigval = abs(M(1,1));
  elseif (size(M,1) <= 400)
	eigval = max(abs(eig(full(M)))); % largest magnitude eigenvalue
  else
	opts = struct;
	opts.disp = 0;
	eigval = eigs(M,1,'LM',opts); % largest magnitude eigenvalue
  end

  if (eigval == 0)
	a = 0;
  else
	a = log(eigval);
  end
  
%  [V D] = eig(full(M));
%  i 

