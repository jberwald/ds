
function [A notscc] = restrict_to_sccs(A)

  [comp_inds comps P] = components_raf(A);
  sccs = find(diag(P)); % loops of the contracted graph correspond to sccs
  sccs = cat(1,comps{sccs});

  notscc = setdiff(1:size(A,1), sccs);
  A(notscc,:) = 0;
  A(:,notscc) = 0;

end
