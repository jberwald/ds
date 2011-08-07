function tex_symbol_matrix(T,fid,bold)
% function tex_symbol_matrix(T,fid,bold)
% T -- matrix
% fid -- file id
% bold -- true iff 1's should be bold and 0's should be gray

  fprintf(fid,'\\kbordermatrix{\n');
  fprintf(fid,'    & ');
  
  s = tex_symbols(1:length(T));
  fprintf(fid,[s '\\ \n']);	% need an extra set of \\ b/c of escape funkiness
  
  for row = 1:length(T)
	fprintf(fid,['  ' ('A' + row - 1) ' & ']);
	s = latex(full(T(row,:)),'nomath','%i');

	if (nargin > 2)
	  s = strrep(s,'1','{\mathbf{1}}');
	  s = strrep(s,'0','{\color{Gray} 0 }');
	end

	if (row < length(T))
	  fprintf(fid,'%s \\\\\n',s); 	% kill return at end of s
	else
	  fprintf(fid,'%s\n',s);
	end
  end
  fprintf(fid,'}\n');

end
