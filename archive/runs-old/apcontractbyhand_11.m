load results_data/plateau_results_data/results_apboxprm_plat11_all
platnum = 11;
datanum = 57;
box = [2 2] + (7/8)*[2 2];
depth = 26;


D = results.data{datanum};
I = D{7};
S = D{4};
R = D{1};
load plateaus/aprepdat.mat
[tree P Adj] = get_map_old('henon',depth,'params',reps(platnum,:),'box',box);

boxes = tree.boxes(-1);
showraf(boxes(:,I)','y','y');

I_R = graph_mis(S);
S = S(I_R,I_R); % don't know why this wasn't already done... get rid of
                % transient symbols

showsymbols(boxes,R(I_R),1:length(I_R),'k','none');

C = {};
C1 = [1:4 7:11 28:33 36 37 40 41 44:47];
C2 = [34 35 38 39 42 43 48 49];
C3 = [5 6 15 17];
C4 = [12 13 14 16 18 19];
C5 = [20:27];
C678 = [50:89];
C7 = [53 54 64 78 79 86];
C8 = [74 75 76 77 84 89]; %%% NOT SURE ABOUT 89!!
C9 = [109:112 153 148 149 166 162 163];  %%% DITTO FOR 163!!
C10 = [114 115 113 123 150 154 155 167 168 165 164];
%C{6} = setdiff(C678,union(C7,C8));
C12 = [93 94 97 98 100 101 102];
C13 = [90 91 92 95 96 99 103];
C14 = [104 107 139 140 142 146 197 199 201 203 211 215];
C15 = [105 106 108 141 143 147 198 200 202 212 214 216];
% C{11} = setdiff(1:size(I_R),cat(2,C{:}));

% {1,2,3},{4,5},{6,7,8},{9,10,11},{12,13},{14,15}.
C{1} = [C1 C2 C3];
C{2} = [C4 C5];
C{3} = C678;
% C{3} defined below
C{5} = [C12 C13];
C{6} = [C14 C15];
C{3} = setdiff(1:size(I_R),cat(2,C{:}));

% comps = {1:6, 7:10, 11:13, 14, [29 31 37], [28 30 32 36 26 27 33 22 23 24], ...
% 		 [25 34 35 38 39], 15:21}

[T comps shifteqs] = find_contraction(S,C);

% % what components did we get?
% for i=1:length(C)
%   fprintf('%i: %i\n',i,any(arrayfun(@(j) length(comps{j})==length(C{i}) && ...
% 									all(comps{j}==C{i}), 1:length(comps))))
% end


figure;
showregions(boxes,R(I_R),comps);
% showsymbols(boxes,R(I_R),1:length(I_R),'k','y');
