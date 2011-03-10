function colvec = showregions(b, R, S)
% function colvec = showregions(b, R, S)
% b = boxes, R = region cell array, S = components of region numbers
  
n = length(S);
colors = lines;
colvec = zeros(n,3);

for r = 1 : n

%  c = ceil(r * size(colors,1) / n);
%  showraf(b(:,cat(2,R{S{r}}))',min(1,1.5*colors(c,:)'),colors(c,:)'/1.5);
  showraf(b(:,cat(2,R{S{r}}))',colors(r,:)',colors(r,:)');
end
