
% This function is to wrap a rectangle which GAIO uses to a torus so we can
% analyze the dynamics on a torus of the standard map.

side = 2^(-full_depth/2);
small_increment = 2^(-(full_depth+2)/2);
hor_y = small_increment;
ver_x = small_increment;
tree.count(-1);

ADJACENCY = adj_matrix(tree, full_depth);
ADJACENCY = spones(ADJACENCY);

disp('Adjacency matrix done, fixing it...');

for i = 1 : 2^(full_depth/2)

     hor_x = i*side - small_increment;
     ver_y = i*side - small_increment;
     horizontal_box = tree.search([hor_x;hor_y], full_depth);
     vertical_box = tree.search([ver_x;ver_y], full_depth);
     hor_adj_box1 = [(i*side-3*small_increment);1-small_increment];
     hor_adj_box2 = [(i*side-small_increment);1-small_increment];
     hor_adj_box3 = [(i*side+small_increment);1-small_increment];
     ver_adj_box1 = [(i*side-3*small_increment);1-small_increment];
     ver_adj_box2 = [(i*side-small_increment);1-small_increment];
     ver_adj_box3 = [(i*side+small_increment);1-small_increment];
     hor_adj_box_num1 = tree.search(hor_adj_box1, full_depth);
     hor_adj_box_num2 = tree.search(hor_adj_box2, full_depth);
     hor_adj_box_num3 = tree.search(hor_adj_box3, full_depth);
     ver_adj_box_num1 = tree.search(ver_adj_box1, full_depth);
     ver_adj_box_num2 = tree.search(ver_adj_box2, full_depth);
     ver_adj_box_num3 = tree.search(ver_adj_box3, full_depth);
     
     if (horizontal_box ~= -1)

          if (hor_adj_box_num1 ~= -1)
               ADJACENCY(horizontal_box, hor_adj_box_num1) = 1;
               ADJACENCY(hor_adj_box_num1, horizontal_box) = 1;
          end
          if (hor_adj_box_num2 ~= -1)
               ADJACENCY(horizontal_box, hor_adj_box_num2) = 1;
               ADJACENCY(hor_adj_box_num2, horizontal_box) = 1;
          end
          if (hor_adj_box_num3 ~= -1)
               ADJACENCY(horizontal_box, hor_adj_box_num3) = 1;
               ADJACENCY(hor_adj_box_num3, horizontal_box) = 1;
          end
     end
     if (vertical_box ~= -1)

          if (ver_adj_box_num1 ~= -1)
               ADJACENCY(vertical_box, ver_adj_box_num1) = 1;
               ADJACENCY(ver_adj_box_num1, vertical_box) = 1;
          end
          if (ver_adj_box_num2 ~= -1)
               ADJACENCY(vertical_box, ver_adj_box_num2) = 1;
               ADJACENCY(ver_adj_box_num2, vertical_box) = 1;
          end
          if (ver_adj_box_num3 ~= -1)
               ADJACENCY(vertical_box, ver_adj_box_num3) = 1;
               ADJACENCY(ver_adj_box_num3, vertical_box) = 1;
          end
     end
end

bottom_left_box = tree.search([small_increment;small_increment],full_depth);
bottom_right_box = tree.search([1-small_increment;small_increment],full_depth);
top_left_box = tree.search([small_increment;1-small_increment],full_depth);
top_right_box = tree.search([1-small_increment;1-small_increment],full_depth);

disp('Dealing with the corners')

ADJACENCY(bottom_left_box, bottom_right_box) = 1;    %%%%%%%%%%%%%%%%%%%%A
ADJACENCY(bottom_right_box, bottom_left_box) = 1;    %
ADJACENCY(bottom_left_box, top_left_box) = 1;        %   
ADJACENCY(top_left_box, bottom_left_box) = 1;        %   THIS BLOCK IS
ADJACENCY(bottom_left_box, top_right_box) = 1;       %
ADJACENCY(top_right_box, bottom_left_box) = 1;       %   TO IDENTIFY THE
ADJACENCY(bottom_right_box, top_left_box) = 1;       %
ADJACENCY(top_left_box, bottom_right_box) = 1;       %    BOXES AT THE
ADJACENCY(bottom_right_box, top_right_box) = 1;      %
ADJACENCY(top_right_box, bottom_right_box) = 1;      %      CORNERS.
ADJACENCY(top_left_box, top_right_box) = 1;          %
ADJACENCY(top_right_box, top_left_box) = 1;          %%%%%%%%%%%%%%%%%%%%

%%% NOW WE HAVE TO DEAL WITH A FEW LAST DETAILS FROM THE CORNERS...

bottom_left_details = [(small_increment + side) (1-small_increment); (1-small_increment) (small_increment + side)]';  %  '
bottom_left_details_numbers = tree.search(bottom_left_details, full_depth);
ADJACENCY(bottom_left_box,bottom_left_details_numbers) = 1;
ADJACENCY(bottom_left_details_numbers,bottom_left_box) = 1;

bottom_right_details = [(1 - small_increment - side) (1-small_increment); small_increment (small_increment + side)]';  %  '
bottom_right_details_numbers = tree.search(bottom_right_details, full_depth);
ADJACENCY(bottom_right_box,bottom_right_details_numbers) = 1;
ADJACENCY(bottom_right_details_numbers,bottom_right_box) = 1;

top_left_details = [(small_increment + side) (1-small_increment); (1-small_increment) (1 - small_increment - side)]';  %  '
top_left_details_numbers = tree.search(top_left_details, full_depth);
ADJACENCY(top_left_box,top_left_details_numbers) = 1;
ADJACENCY(top_left_details_numbers,top_left_box) = 1;

top_right_details = [(1 - small_increment - side) (small_increment); (small_increment) (1 - small_increment - side)]';  %  '
top_right_details_numbers = tree.search(top_right_details, full_depth);
ADJACENCY(top_right_box,top_right_details_numbers) = 1;
ADJACENCY(top_right_details_numbers,top_right_box) = 1;
