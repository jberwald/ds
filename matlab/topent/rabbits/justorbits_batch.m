function [ents lastk] = justorbits_batch(map,periods,variant,C)
if nargin < 3
  variant = 0;
end

if variant < 2
  C = {};                                 % will be ignored if not variant 2
end
if variant == 2 || variant == 3
  C = list_pps(periods,map.P,map.Adj)   % periods should just be an int
  periods = 1:size(C,1);
end
if variant == 4
  periods = 1:size(C,1);
end
  
ents = zeros(1,length(periods));
regs = ones(1,length(periods));
gotinteresting = 0;                     % semi-kludge; pattern in region #'s
lastk = length(periods);
for k = 1:length(periods)
  %  fprintf(' * period %d * \n',periods(k))
  sets = justorbits(map, periods(k), variant, C);
  for s = 1:length(sets)
    %    fprintf(' * set %d * \n',s)
    dat = compute_symbolics(sets{s}, map);%, 'quiet');
    
    if dat.hmax >= ents(k)
      ents(k) = dat.hmax;
      regs(k) = length(dat.R);
    end
  end

  if ents(k) > 0 || (k > 1 && regs(k) > regs(k-1))  % pos ent or more regions
    gotinteresting = 1;
  elseif gotinteresting && ... % was interesting
        ents(k) == 0 && ... % no entropy
        (regs(k) == 1 || ... % one reg
        regs(k) < regs(k-1)) % fewer regions than last time
    lastk = k;
    break
  end
end

if variant == 2 || variant == 3
  perstr = 'step';
else
  perstr = 'per';
end

for k = 1:length(periods)
  fprintf('%s %2i: %3i regions, entropy = %.6f\n',perstr,periods(k),regs(k),ents(k))
end
  