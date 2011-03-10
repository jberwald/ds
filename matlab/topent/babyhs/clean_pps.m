function PP = clean_pps(PP, map)
% function PP = clean_pps(PP, map)
% inputs: map - map object
%         PP - cell array of periodic orbits
% output: PP - PP with phantom orbits removed

  opts = struct;
  opts.quiet = 1;
  
  k = 1;
  while k <= size(PP,1)
    dat = compute_symbolics(PP{k,1},map,opts);
    goodorbit = @(x) ~isempty(x) && all(diag(x^PP{k,2}));
    if isfield(dat,'SM') && any(cellfun(goodorbit,dat.SM))   % some homol level is good
      fprintf('orbit %i: good\n',k);
      k = k+1;
    else
      fprintf('orbit %i: bad\n',k);
      PP(k,:) = [];
    end
  end  
