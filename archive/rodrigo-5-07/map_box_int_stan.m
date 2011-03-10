function [center radius] = map_box_int(box,interval_map)
% function [center radius] = map_box_int(box,interval_map)

  d = (size(box,1)-2)/2;
%  v = [intval(0)];
%   
%   for j = 1:d
% 	% Gets the box in terms of its intervals:
% 	v(j) = infsup((box(j)-box(d+j)), (box(j)+box(d+j)))
%   end
  
  x_minus = box(1) - box(3);
  x_plus = box(1) + box(3);
  
  y_minus = box(2) - box(4);
  y_plus = box(2) + box(4);
  
  x = infsup(x_minus, x_plus);
  y = infsup(y_minus, y_plus);
  
  I = interval_map(x,y);     			% image of the box under the map
  
  parts = length(I(:,1));
  
%   center = zeros(parts,1);
%   radius = zeros(parts,1);
  
center = [];
radius = [];

  if parts == 1
      
         I_end = zeros(d,2);
    for k = 1:length(I)
        I_end(k,1) = inf(I(k));
        I_end(k,2) = sup(I(k));
    end

    center_x = (I_end(1,2) + I_end(1,1))/2;
    center_y = (I_end(2,2) + I_end(2,1))/2;
    
    radius_x = abs(I_end(1,2) - I_end(1,1))/2;
    radius_y = abs(I_end(2,2) - I_end(2,1))/2;
    
    center{1} = [center_x; center_y];                % center and radius of the image box.
    radius{1} = [radius_x; radius_y];
      
  else
  
    for z = 1 : parts
  
        I_end = zeros(d,2);
        for k = 1: length(I(z,:)) %d                            % Need to fix this part: when the image wraps!!!
            I_end(k,1) = inf(I(z,k));
            I_end(k,2) = sup(I(z,k));
        end

        center_x = (I_end(1,2) + I_end(1,1))/2;
        center_y = (I_end(2,2) + I_end(2,1))/2;
    
        radius_x = abs(I_end(1,2) - I_end(1,1))/2;
        radius_y = abs(I_end(2,2) - I_end(2,1))/2;
    
        center{z} = [center_x; center_y];                % center and radius of the image box.
        radius{z} = [radius_x; radius_y];        
        
    end
    

  end
