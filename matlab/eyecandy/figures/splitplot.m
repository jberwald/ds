function splitplot(numplots, callback, margin, spacing)
% function splitplot(numplots, callback, margin, spacing)
% example usage:
%   splitplot(4,@(x) plot(1:56,Ebug(x,:),1:56,Egood(x,:)), 0.05, 0.06)
  
  left_margin = margin;
  width = 1 - 2*margin;
  bottom_margin = margin;
  height = (1-2*margin - (numplots-1)*spacing)/numplots;
  
  for i = 1 : numplots
	ycoord = (i-1)*(spacing+height) + bottom_margin;
	axes('position',[left_margin ycoord width height]);
	callback(i);
  end
  
