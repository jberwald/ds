function plats_savefig(file,size)

if nargin < 2
  size = 1;
end

filepath = ['../plateaus/focm/figs/' file '.eps'];
opts = struct('FontMode','fixed','FontSize',6,'height',size*6,'Color','rgb');
exportfig(gcf,filepath,opts);
eps2pdf(filepath);
