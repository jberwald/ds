function [BB] = good_orbits(map,maxper,depth)
% function good_orbits(map,maxper,depth)
%
% Get good (hyperbolic, isolated) orbits up to maxper at depth
%
%
  
  
  [B C newmap] = pp_raf(map,maxper,depth);
  newmap.Adj = adj_matrix(newmap);

  % filter out the non-hyperbolic ones
  R = {};
  for i=1:length(C)
    R{i} = get_regions(C{i},newmap.Adj);
    R{i}(:,2) = {i};
  end
  PPh = hyperbolic_orbits(newmap,cat(1,R{:}));
  newmap.tree = crop_tree(newmap.tree,cat(2,PPh{:,1}));
  
  % grow the orbits out
  newmap = grow_ip_insert_faster(newmap);

  % now sort by region  
  dat = compute_symbolics(newmap.I,newmap);
  [i2c c2i] = components_raf(dat.SM{2}); % SHOULD GENERALIZE THIS
  BB = {};
  boxes = newmap.tree.boxes(-1);
  for k = 1:length(c2i)
    S = cat(2,dat.R{c2i{k}});           % box numbers
    BB{k,1} = boxes(:,S);               % boxes themselves
    BB{k,2} = length(c2i{k});           % period of orbit
  end
