function thesisfig(file,varargin)

file = ['../thesis/' file '.eps'];
opts = struct('FontMode','fixed','FontSize',6,'height',6,'Color','rgb');
exportfig(gcf,file,opts,varargin{:});
eps2pdf(file);
