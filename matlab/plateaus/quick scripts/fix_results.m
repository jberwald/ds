function fix_results(filename)

% fixes a run of plateau boxprm if the ordering is something like
% 12.8,12.7,12.6,12.5,12.4,12.3,12.2,12.1,14.8,...
%
% saves the 'results' variable back to the file when done.

load(filename);

E = results.entropies;
D = results.data;

for i=1:length(E)/8
  E(i*8-7:i*8) = E(i*8:-1:i*8-7); % swap in chunks of 8
  D(i*8-7:i*8) = D(i*8:-1:i*8-7); % swap in chunks of 8
end

results.entropies = E;
results.data = D;

save(filename,'results');
