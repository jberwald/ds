function P = rigorous_matrix(tree,depth,interval_map)
%
% function P = rigorous_matrix(tree,depth,interval_map)
%

n = tree.count(depth);					% Number boxes
d = tree.dim;
boxes = tree.boxes(depth);
P = sparse(n,n);     					% Initialize transition matrix

for i = 1 : n

  [center radius] = map_box_int_stan(boxes(:,i),interval_map);
  
  images = length(center);
  
  if images == 1
      
    img = tree.search_box(center{1}, radius{1});
    P(img,i) = 1;
    
  
  else
      
    for j = 1 : length(center)
         
        img = tree.search_box(center{j}, radius{j});
        P(img,i) = 1;        
                                   
    end
      
  end
      
    
end
