
function [b b_f b_b] = can_contract(T,A,B)
  b_f = forward_rule(T,A,B);
  b_b = forward_rule(T',A,B);
  b = b_f || b_b;
end
