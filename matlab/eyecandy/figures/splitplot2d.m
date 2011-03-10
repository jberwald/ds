function splitplot2d(gridsize, callback, margin, spacing)
% function splitplot2d(gridsize, callback, margin, spacing)
% example usage:
%   splitplot2d([2 2],@(x) plot(1:56,E(2*(x-1)+y,:)), 0.05, 0.06)
%   splitplot2d([2 2],@(x) plot(1:56,E(2*(x-1)+y,:)), [0.05 0.03], [0.04 0.06])
  
  plotsize = (1-2*margin - (gridsize-1) .* spacing) ./ gridsize;
  
  for x = 1 : gridsize(1)
	for y = 1 : gridsize(2)
	  gridpos = [x y];
	  plotpos = (gridpos - 1) .* (spacing + plotsize) + margin;
	  axes('position',[plotpos plotsize]);
	  callback(gridpos,gridsize);
	end
  end
  
