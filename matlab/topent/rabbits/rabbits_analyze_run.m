
for i = 1:length(ents)
  v = cellfun(@max,ents{i}(:,1));
  fprintf('mean: %.4f  std: %.4f  med: %.4f  min: %.4f  max: %.6f\n',mean(v),std(v),median(v),min(v),max(v));
end

%other stuff
disp('correlations of max entropy with properties of the orbit vector:')
for i = 1:length(ents)
  v = cellfun(@max,ents{i}(:,1));
  sums = corrcoef(cellfun(@sum,ents{i}(:,2)),v);
  means = corrcoef(cellfun(@mean,ents{i}(:,2)),v);
  meds = corrcoef(cellfun(@median,ents{i}(:,2)),v);
  maxs = corrcoef(cellfun(@max,ents{i}(:,2)),v);
  mins = corrcoef(cellfun(@min,ents{i}(:,2)),v);
  lens = corrcoef(cellfun(@length,ents{i}(:,2)),v);
  fprintf('sum: %.2f  mean: %.2f  med: %.2f  max: %.2f  min: %.2f  len: %.2f\n',...
          sums(2,1),means(2,1),meds(2,1),maxs(2,1),mins(2,1),lens(2,1));
end