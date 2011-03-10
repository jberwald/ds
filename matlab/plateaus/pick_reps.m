function [reps R Adj] = pick_reps(tree,Adj)  
  boxes = tree.boxes(-1);
  d = tree.dim;  
  Adj = adj_multidepth(tree);
  R = get_regions(1:size(Adj,1), Adj);
  area = boxes(d+1,:).* boxes(d+2,:);	% area of each box
  
  [Y I] = sort(cellfun(@(r) sum(area(r)),R), 'descend');
  R = R(I);
  
  % could be generalized to > 2 dims, but currently isn't 
  rep_nums = cellfun(@(x) max_area(area,x), R);
  reps = intval(boxes(1:d,rep_nums))';
end

function x = max_area(A,S)
  [Y I] = max(A(S));
  I = S(I);
  x = I(1);								% can pick any one...
end
