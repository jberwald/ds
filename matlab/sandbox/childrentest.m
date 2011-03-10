n = 300;
P = sparse(rand(n,n)>0.8);
S = 1:log(n);
T = find_children(P,S);
To = find_children_old(P,S);

T = T(1:length(To));

v = find(xor(T,To));

if ~isempty(v)
  if subset(v,S)
    disp('nonempty discrepancy, but all within S')
  else
    disp('wtf is going on')
  end
else
  disp('v is empty, w00t')
end

I = graph_mis(P);
Io = graph_mis_old(P);

if all(I==Io)
  disp('invariant sets are equal')
else
  disp('invariant sets not equal wtf?')
end