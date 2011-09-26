function plats_areatrees(params,depths,steps)
% function plats_areatrees(params,depths,steps)
% make the trees / maps for a continuous box area scale!
%
% plats_areatrees([1.4 0.3],8:10,20)
  
  for s=1:steps
    [depth box d] = plats_num2depth(s,depths,steps);
    map = get_map('henon2',depths(1),'params',params,'box',box);
    map = refine_map(map,depths(end));
  end
end
