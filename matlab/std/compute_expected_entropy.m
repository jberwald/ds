% function [e M] = compute_expected_entropy(orbit_num, orbit_length)
%   Computes the entropy of a system with one fixed point and 'orbit_num'
%   homoclinic connections each of length 'orbit_length'


function [e M] = compute_expected_entropy(orbit_num, orbit_length)
  
  N = orbit_length;
  K = orbit_num;
  
  M = zeros(K*N+1,K*N+1);
  M(1,1) = 1; % fp
  for i = 0 : (K-1)
	M(2 + i*N,1) = 1; % point i
	for j= 1 : (N-1)
	  M(2+i*N+j,1+i*N+j) = 1; % transitions 1 through N-1
	end
	M(1,1+(i+1)*N) = 1; % last transition goes to fixed point
  end

  e = log_max_eig(M)
