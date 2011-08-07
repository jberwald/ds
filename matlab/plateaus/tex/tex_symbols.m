
function s = tex_symbols(G)
% function s = tex_symbols(G)
% G -- array of numbers or cell array of numbers
% outputs (or returns) one row of symbols:
%
% >> tex_symbols(1:2:7)
% A & C & E & G     \\
%
% >> tex_symbols({1:3 1:2 1:4})
% A & A & A & B & B & C & C & C & C     \\
%
  
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
