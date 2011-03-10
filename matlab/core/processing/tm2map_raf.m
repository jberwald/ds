function tm2map_raf_tmp(boxes, X, Y, P, filename)
%  tm2map writes map given by the transition matrix P, domain X and range Y,
%  to file to be read by 'homcubes'


  fid = fopen(filename,'w');% file identifier
  dim = (size(boxes,1)-2)/2;% space dimension
  radius = boxes(dim+1:2*dim,1)';% box radius

  % rescaling to integer lattice
  for i=1:dim
    boxes(i,:) = boxes(i,:)/radius(i)/2;
    boxes(i+dim,:) = boxes(i+dim,:)/radius(i)/2;
  end

  % for domain boxes in X, image is restricted to Y
  for i=1:size(boxes(:,X),2),

    center = boxes(1:dim,X(i))';
	printbox(fid,center,dim);    
	
    Im = find(P(:,X(i)));     			% compute image of box i
    Im = intersect(Im,Y); 				% restricted to Y 

	fprintf(fid, ' -> {');
    if (~isempty(Im))  
      for k=1:length(Im),
        center = boxes(1:dim,Im(k))';
		printbox(fid,center,dim);
	  end
	else
      fprintf('WARNING: box no %d has empty image. \n', X(i));
    end
    fprintf(fid, '}\n');             
  end

  fclose(fid);
end

function printbox(fid,center,dim)
  lower_left = round(center-0.5);
  fprintf(fid, '(');
  %  for j=1:dim-1, fprintf(fid, '%d,', lower_left(j)); end
  fprintf(fid, '%d,', lower_left(1:dim-1));
  fprintf(fid, '%d) ', lower_left(dim));
end

function s = printboxstr(center,dim)
  lower_left = round(center-0.5);
  s = '(';
  for j=1:dim-1, s = [s sprintf('%d,', lower_left(j))]; end
  s = [s sprintf('%d) ', lower_left(dim))];
end
