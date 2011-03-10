A = PP{1,1};
B = PP{3,1};
AB = union(A,B);

AR = get_regions(A,map.Adj)
BR = get_regions(B,map.Adj) 

CAB = {};               
CBA = {};                     
for i = 1:length(AR)
  for j = 1:length(BR)
    CAB{i,j} = skinny_connection(AR{i},BR{j},map.P);
    CBA{j,i} = skinny_connection(BR{j},AR{i},map.P);
  end
end
CAB
CBA

S = union(AB,unique(cat(2,CAB{:},CBA{:})));
dat = compute_symbolics(S,map);

% cab = 0;
% for i = 1:length(AR)
%   S = union(AB,unique(cat(2,CAB{i,:})));
%   dat = compute_symbolics(S,map);
%   if length(graph_mis(dat.M{2})) > length(AR)+length(BR)
%     disp('found connection')
%     cab = i;
%   end
% end

% cba = [];
% for i = 1:length(AR)
%   for j = 1:length(BR)
%     S = union(AB,CBA{j,i});
%     dat = compute_symbolics(S,map);
%     if length(graph_mis(dat.M{2})) > length(AR)+length(BR)
%       disp('found connection')
%       cba = [i j];
%     end
%   end
% end

    
