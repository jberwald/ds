function V = wrap_box(I,W)
% for now, assume 2-dimensional, but this can easily be updated

  x = wrap_interval(I(1),W(1));
  y = wrap_interval(I(2),W(2));

  V = glue_together(x,y);
