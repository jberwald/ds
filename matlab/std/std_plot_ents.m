function std_plot_ents(epsilons, ents, syms, deps)
% function std_plot_ents(epsilons, ents, syms, deps)
  stairs(epsilons,ents,'k');
  endpts = epsilons([1 end]);
  set(gca,'xlim',endpts);
  hold on % a minute :D
  %  emin = min(ents(ents>0));
  %  stairs(epsilons,0.0+0.1*scrunch(syms),'r');
  %  stairs(epsilons,0.1+0.1*scrunch(deps),'g');
  plot(endpts,[0.2 0.2],'r')
end

function w = scrunch(v)
  nz = find(v>0);
  minval = min(v(nz));
  maxval = max(v);
  v(nz) = v(nz) - minval;
  w = v/(maxval-minval);
end
