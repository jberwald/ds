function [center radius] = intval2box(I)

  I_end = [inf(I)' sup(I)'];
  center = sum(I_end,2)/2;                % center and radius of the image box.
  radius = abs(diff(I_end,1,2))/2;
