function [depth box d] = plats_num2depth(num,depths,dlen)
% function [depth box d] plats_num2depth(num,depths,dlen)
% compute the depth and box corresponding to data matrix position 'num'
  depth = depths(ceil(num / dlen));
  d = mod(num-1,dlen)+1;
  box = (2 - d/dlen)*[1 1];
