
function W = periodic_orbits(n,epsilon)

%
% function W = periodic_orbits(n,epsilon)
%
% This function returns periodic points of period n for the standard
% map. It is based on appendix A of Greene's 1979 paper. %'
%

r = fzero(@(r) sin(2*pi*iterate_SM(n,r,epsilon)),.25);

W = zeros(2,2*n);

W(1,1) = 0;
W(2,1) = r;
W(1,n+1) = 0;
W(2,n+1) = 1-r;

for i = 1 : (n-1)

     [x1 y1] = SM_iteration(W(1,i),W(2,i),epsilon);
     W(1,i+1) = mod(x1,1);
     W(2,i+1) = mod(y1,1);
     [x2 y2] = SM_iteration(W(1,n+i),W(2,n+i),epsilon);
     W(1,n+1+i) = mod(x2,1);
     W(2,n+1+i) = mod(y2,1);

end


function theta = iterate_SM(n,r,epsilon)

  theta = 0;

  for i = 1 : n
    [theta r] = SM_iteration(theta,r,epsilon);
  end

end

end
