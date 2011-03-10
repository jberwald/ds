function tex_plateaus(plats,E,contractions,file,repfile)
% tex_plateaus(plats,E,contractions,file)
% data: {R G M SM X A I}

  if (nargin == 4)
	load plateaus/repdat.mat
  else
	load(repfile)
  end


  K = 1000000;							% inverse of resolution for "max"
  [Y Inds] = max(floor(K*E'));

  fid = fopen(file,'w');

  for i = 1 : length(plats)

	if (Y(i) == 0)
	  continue;
	end

	params = reps(plats(i),:);
	ind = Inds(i);

	% symbol matrix
	T = contractions{i,1};

	% tex it all


	fprintf(fid,'\\platfig{%i}{\n',i);	

%	if (mod(i,5) > 0)
%	  fprintf(fid,'\\vspace{-10pt}\n');
%	end

	if (size(T,1) <= 10)
	  tex_symbol_matrix(T,fid,1);
	end

	fprintf(fid,'}{%3.4f}{%3.4f}{%3.4f}{%i}', ...
			inf(params(1)),inf(params(2)), max(E(i,:)), (size(T,1) > 4));

%	if (mod(i,5) == 0)
%	  fprintf(fid,'\\clearpage\n');
%	end
  end 

  fclose(fid);

end









% function tex_plateaus(plats,E,contractions,file,imstr)
% % tex_plateau(plat_num,data)
% % data: {R G M SM X A I}

%   load plateaus/repdat.mat

%   K = 1000000;							% inverse of resolution for "max"
%   [Y Inds] = max(floor(K*E'));

%   fid = fopen(file,'w');

%   for i = 1 : length(plats)

% 	p = plats(i);
% 	params = reps(p,:);
% 	ind = Inds(p);

% 	% symbol matrix
% 	T = contractions{p,1};

% 	% tex it all
% 	fprintf(fid,'\\begin{figure}[!ht]\n');
% 	fprintf(fid,'\\centering\n');
% 	fprintf(fid,'\\includegraphics[width = 0.4\\textwidth]');
% 	fprintf(fid,'{%s%i-ip.pdf}\n', imstr, p);

% 	fprintf(fid,'\\begin{displaymath}\n');
% 	fprintf(fid,'\\kbordermatrix{\n');
% 	fprintf(fid,'    & ');

% 	s = printsyms(1:length(T));
% 	fprintf(fid,[s '\\ \n']);	% need an extra set of \\ b/c of escape funkiness

% 	for row = 1:length(T)
% 	  fprintf(fid,['  ' ('A' + row - 1) ' & ']);
% 	  s = latex(full(T(row,:)),'nomath','%i');
% 	  if (row < length(T))
% 		fprintf(fid,'%s \\\\\n',s); 	% kill return at end of s
% 	  else
% 		fprintf(fid,'%s\n',s);
% 	  end
% 	end
% 	fprintf(fid,'}\\\\\n');
% 	fprintf(fid,'a = %3.4f,\\; b = %3.4f\\\\\n', ...
% 			inf(params(1)),inf(params(2)));
% 	fprintf(fid,'h(f) = %3.4f\n', max(E(i,:)));
% 	fprintf(fid,'\\end{displaymath}\n');

% 	fprintf(fid,'\\includegraphics[width = 0.3\\textwidth]');
% 	fprintf(fid,'{%s%i-ent.pdf}\n', imstr, p);

% 	fprintf(fid,'\\end{figure}');
%   end 

%   fclose(fid);

% end
