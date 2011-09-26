function [T syms SH] = contract_random(SM,trials)
% function [T syms SH] = contract_random(SM,trials)
% finds the smallest contraction after 'trials' runs

  n = length(SM);
  T = SM;
  syms = num2cell(1:n);
  SH = [];
  
  for k = 1 : trials
    v = randperm(n);
    [T_new syms_new SH_new] = find_contraction(SM(v,v));
    if (length(T_new) < length(T))
      T = T_new;
      syms = syms_new;
      SH = SH_new;
      fprintf('   got down to %i symbols\n',length(T));
    end
  end

  % remove transient symbols... add to find_contraction?
  I_T = graph_mis(T);
  T = T(I_T,I_T);
  syms = syms(I_T);
  fprintf('   contracted down to %i symbols\n',length(T));
  
end
