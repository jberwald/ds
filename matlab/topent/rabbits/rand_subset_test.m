function ents = rand_subset_test(map,maxper,trials,skipk)

if nargin < 4
  skipk = 1;
end

C = list_pps(maxper,map.P,map.Adj)

ents = {}
for t = 1:trials
  fprintf('** trial %i **\n',t)
  n = size(C,1);
  perm = randperm(n)
  Ct = {};
  Ct(1,:) = {unique(cat(2,C{perm(1:skipk),:})) 1}; % it's a fp I swear :P
  Ct(2:(n+1-skipk),:) = C(perm((skipk+1):end),:);
  %  Ct = C(perm,:);
  [e lastk] = justorbits_batch(map,maxper,4,Ct);
  kmax = find(e,1,'last');        % last nonzero entropy
  if isempty(kmax)                      % if all 0 entropy
    kmax = lastk;                       % first k to fill everything up
  end
  ents{t,1} = e(1:kmax);
  ents{t,2} = perm(1:kmax);
end

for t = 1:trials
  fprintf('** trial %i **\n',t)
  fprintf('%.6f\n',ents{t,1})
end

%fprintf('max entropy: %.6f\n',max(cellfun(@max,ents(:,1))))

% map = get_map('henon',9);
% justorbits_batch(map,8,3);
% map = get_map('henon',10);
% justorbits_batch(map,12,3);
% map = get_map('henon',11);
% justorbits_batch(map,12,3);
