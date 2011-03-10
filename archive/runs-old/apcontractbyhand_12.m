%
% This is the first depth where the structure of the DMS partition can be
% embedded.  It would still be interesting to see if we can get the same
% number (or fewer) of blocks for the first case; try brute-forcing it?
% Certainly we would want the trivial regions to be glued... maybe try
% {1,2,3},{4,5},{6,7,8},{9,10,11},{12,13},{14,15}.
%

load results_data/plateau_results_data/results_apboxprm_plat12_all
platnum = 12;
datanum = 60;
[depth box] = plats_num2depth(datanum,results.depths,8);

D = results.data{datanum};
I = D{7};
SM = D{4};
R = D{1};

load plateaus/aprepdat.mat
[tree P Adj] = get_map_old('henon',depth,'params',reps(platnum,:),'box',box);
boxes = tree.boxes(-1);

%I_R = graph_mis(SM);
%SM = SM(I_R,I_R); % don't know why this wasn't already done... get rid of
%                % transient symbols
%showsymbols(boxes,R(I_R),1:length(I_R),'k','none');

C = {};
C{1} = [1:4 7:12 35:39 42 90:101];
C{2} = [40 41 43 44 102:106];
C{3} = [5 6 13:15];
C{4} = [110 111 113 115 117 120];
C{5} = [22:29 32:34 45:89 107:10 112 114 116 118 119];
C{6} = [16:21];
C{7} = [215 218 221 224 237 294];
C{8} = []; % see below
C{9} = [121:132 165:181];
C{10} = [181 185:189 192 249 252 253 282];

C{8} = setdiff(1:size(SM,1), cat(2,C{:}));

trials = 10;
DATA = {};

r = 6; % focus on this region
others = setdiff(1:length(C),r);
C = cat(2, C{r}, arrayfun(@(x) {x}, cat(2,C{others})))

for k = 1 : trials

  fprintf('attempt # %i\n',k);
  v = randperm(size(SM,1));
  iv = inv_perm(v,size(SM,1));
  SM_v = SM(iv,iv);
  C_v = cellfun(@(x) v(x),C,'uniformoutput',0);
  [T comps shifteqs] = find_contraction(SM_v,C_v);

  fprintf('   got down to %i symbols\n',length(comps));

  % what components did we get?
  for i=1:1 %1:length(C)
	fprintf('%i: %i\n',i,any(arrayfun(@(j) length(comps{j})==length(C{i}) && ...
									  all(comps{j}==C{i}), 1:length(comps))))
  end

  DATA(end+1) = {{v T comps shifteqs}};
end

% figure;
% showregions(boxes,R(I_R),comps);
% % showsymbols(boxes,R(I_R),1:length(I_R),'k','y');
