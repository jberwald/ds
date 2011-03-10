
function ALL_BOXES = expand_in_stable_direction(tree, homoclinic_boxes, x_stable1, y_stable1, x_stable2, y_stable2, ADJACENCY, depth)

% function ALL_BOXES = expand_in_stable_direction(tree, homoclinic_boxes, x_stable1, y_stable1, x_stable2, y_stable2, ADJACENCY, depth)
%
% This is a whacky function which may help out a lot. The purpose of it
% is to know which boxes to keep for a second trashing of boxes so that
% we only keep the boxes of the homoclinic orbit. The way we do this is
% to make sure we stay close to the stable manifold. Since we are already
% on the unstable one we need to know how much of the stable one we need
% to produce the right index pairs. This is very different close to the
% origin that at x = 0.5, when the manifolds cross not extremely 
% transversaly.

stable_boxes = [];
tree.count(depth);

for i = 1 : (length(x_stable1) - 2)
  points_to_check = [x_stable1(i) y_stable1(i); x_stable2(i) y_stable2(i)]'; % '
  boxes_to_add = tree.search(points_to_check, depth);
  for j = 1 : length(boxes_to_add)
     if (boxes_to_add(j) ~= -1)
       stable_boxes = [stable_boxes boxes_to_add]; 
     end
  end
end

stable_boxes = get_nbhd(tree, stable_boxes, depth);
homoclinic_boxes = get_nbhd(tree, homoclinic_boxes, depth);

ALL_BOXES = [];
boxes_to_add = homoclinic_boxes;
remaining_boxes = setdiff(stable_boxes,boxes_to_add);



for i = 1 : length(stable_boxes)

  boxes_to_add = get_nbhd(tree, boxes_to_add, depth);
  remaining_boxes = setdiff(boxes_to_add,stable_boxes);
  if (length(remaining_boxes) == 0)
    ALL_BOXES = intersection(boxes_to_add,stable_boxes);
    ALL_BOXES = get_nbhd(tree, ALL_BOXES, depth);
    break
  end
  ALL_BOXES = intersection(boxes_to_add,stable_boxes);
  boxes_to_add = ALL_BOXES;

end

ALL_BOXES = get_nbhd(tree, ALL_BOXES, depth);
