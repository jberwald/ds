function [E I] = plats_ratioscale(depth,params,area,logr,depth0)
  E = zeros(1,length(logr));
  I = zeros(1,length(logr));
  for s=1:length(logr)
    ratio = exp(logr(s)); % ratio = Y/X
    box = [sqrt(area/ratio) sqrt(area*ratio)]; % area = XY --> X = sqrt(area/ratio)
    if nargin > 4 % depth0
      map = get_map('henon2',depth0,'params',params,'box',box);  
      map = refine_map(map,depth);
    else
      map = get_map('henon2',depth,'params',params,'box',box);
    end
    
    d = compute_symbolics(map.I,map);
    E(s) = d.hmax;
    I(s) = length(map.I);
  end
end

% depth = 11;
% params = [ap_reps(15) -1];
% c = 1.1;
% K = 21;
% uniformly 0.6774! (bar one)

% depth = 10;
% params = [ap_reps(14) -1];
% c = 1.1;
% K = 21;
% (geological) plateau of sorts, peaking at 0.6774...

% depth = 9;
% params = [ap_reps(14) -1];
% area = 4;
% logr0 = -log(6); logrK = log(10); 
% K = 40;
% very interesting plot, spikey but still clear good patches