function [A notinv] = restrict_to_inv(A)
  Inv_A = graph_mis(spones(A));
  notinv = setdiff(1:size(A,1), Inv_A);
  A(notinv,:) = 0;
  A(:,notinv) = 0;
end
