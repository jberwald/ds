function [ents syms deps] = std_table_ents(plotp)

  if nargin == 0
    plotp = 0;
  end
  
  epsilons = [0.7:0.001:0.999 1.0:0.005:2.0];
  filename = '../std/paper/table.tex';
  fid = fopen(filename,'w');

  [ents syms deps] = std_get_ents(epsilons,8:13,plotp); 
  
  numtables = 9;
  numpages = 3;
  tablesize = ceil(length(epsilons) / numtables);
  precision = 6;                        % decimal places for entropy
  e = 1;                                % index into data

  for p = 1:numpages
    fprintf(fid,'{\\scriptsize\n');
    fprintf(fid,'\\begin{center}\n');
    
    for t = 1:(numtables/numpages)
      fprintf(fid,'\\begin{tabular}{cc|c}\n');
      fprintf(fid,['\\hspace{-2pt}$\\varepsilon$ interval & ' ...
                   '$h(f_\\varepsilon)\\geq$ & \\hspace{-2pt}sym\\hspace{-2pt} ' ...
                   '\\\\[1pt] \\hline \\\\[-6pt] \n']);

      for i = 1:tablesize
        if e >= length(epsilons)
          break
        end
        entstr = sprintf('%.30f', ents(e));
        fprintf(fid,'\\hspace{-4pt}[%1.3f, %1.3f]\\hspace{-2pt} & %s & %i \\\\ \n', ...
                epsilons(e), epsilons(e+1), entstr(1:precision+2), syms(e));
        e = e+1;
      end              
      fprintf(fid,'\\end{tabular}\n');

      if t < (numtables / numpages)
        fprintf(fid,'\\hspace{0.2 cm}\n');
      end
      
    end
    fprintf(fid,'\\end{center}\n');
    fprintf(fid,'}\n');
  end

  fclose(fid);

end
