function validate_index_map(R,G,M,P,boxes)
% function validate_index_map(R,G,M,P,boxes)
%
% Makes sure that for all generators alpha, beta such that alpha maps to beta,
% there exists a box in the region containing alpha which maps to a box in the
% region containing beta.  If this is not the case, the function will display
% any such violations to the screen.

region_num = length(R);
gen_num = size(M,1);

for r = 1 : region_num

  gens = mapimage(spones(M),G{r});
% gens = full(find(M(:,G{r}))');
% gens = full(find(M(G{r},:)));
  imgr_M = [];

  for g = gens
	for r2 = 1 : region_num
	  if (ismember(g,G{r2}))
		imgr_M = [imgr_M r2];
		break;
	  end
	end
  end

  imgr_M = unique(imgr_M);

  imgr_boxes = mapimage(P,R{r});
  imgr_P = [];

  for r2 = 1 : region_num
	if (~disjoint(R{r2}, imgr_boxes))
	  imgr_P = [imgr_P r2];
	end
  end

  imgr_P = unique(imgr_P);
  
  % if all is going smoothly, for every generator in region r that is mapped to
  % a region s, there is at least one box in r mapping to a box in s.
  if (subset(imgr_M,imgr_P))
%	fprintf(' okay\n');
%	dispimg(imgr_P,'P');
%	dispimg(imgr_M,'M');
  else
    fprintf('region %d:',r);
	fprintf(' ERROR\n');
	dispimg(imgr_P,'P');
	dispimg(imgr_M,'M');
  end
end

end

function dispimg(S,char)
  fprintf('    imgr_%s: ',char);
  fprintf(' %d',S);
  fprintf('\n');
end
