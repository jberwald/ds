
function s = printsyms(G)
  if (isa(G,'double'))
	chars = char('A' + G - 1);
  else
	chars = arrayfun(@(x) char('A'+repmat(x,size(G{x}))-1), 1:length(G), ...
					 'uniformoutput',0);
	chars = cat(2,chars{:});
  end
  s = latex(chars,'nomath','%c');
  s = sprintf('%s \\\\',s);
  if (nargout == 0)
	disp(s);
  end
end
