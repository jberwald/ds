function showip(map,X,A)
% showip(map,X,A)
% showip(map,dat)
    
  boxes = map.tree.boxes(-1);

  if nargin == 2
    A = X.A;
    X = X.X;
  end

  figure
  set(gcf,'name','Index Pair');
  
  if (map.tree.dim == 2)
    if (map.tree.depth <= 14)
      show2(boxes(:,X)','c');
      show2(boxes(:,A)','b');
    else
      showraf(boxes(:,X)','c','c');
      showraf(boxes(:,A)','k','k');
    end  
  elseif (map.tree.dim == 3)
    if (map.tree.depth <= 18)
      show3(boxes(:,X)','c');
      show3(boxes(:,A)','b');
    else
      show3(boxes(:,X)','c',3,1:3,'c');
      show3(boxes(:,A)','k',3,1:3,'k');
    end  
  end