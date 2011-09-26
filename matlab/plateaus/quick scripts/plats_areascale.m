function [E D] = plats_areascale(params,depths,steps)
% function [E D] = plats_areascale(params,depths,steps)
% assumes trees are already made with plats_areatrees
%
% [E D] = plats_areascale([1.4 0.3],8:10,20);
  
  E = zeros(1,length(depths)*steps);
  D = {};
  for s=1:steps*length(depths)
    [depth box d] = plats_num2depth(s,depths,steps);
    map = get_map('henon2',depth,'params',params,'box',box);
    D{s} = compute_symbolics(map.I,map);
    E(s) = D{s}.hmax;
  end
end
