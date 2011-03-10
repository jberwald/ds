function A = contract_map(R,P)
% function A = contract_map(R,P)
% input: R = cell array of regions (vectors of box numbers)
%        P = transition matrix on boxes
% output: the transition matrix on regions
% NOTE: this can be used to contract any map, not just the gaio map on boxes

n = size(P,1);
k = length(R);
labels = repmat(k+1,[1 n]);		% k+1 for the complement

for i=1:k
  labels(R{i}) = i;			% each region gets a separate label
end

A = contract_vertices(P,labels,k+1);
A = A(1:k,1:k);
