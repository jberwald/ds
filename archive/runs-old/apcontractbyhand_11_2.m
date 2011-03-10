%
% This is the first depth where the structure of the DMS partition can be
% embedded.  It would still be interesting to see if we can get the same
% number (or fewer) of blocks for the first case; try brute-forcing it?
% Certainly we would want the trivial regions to be glued... maybe try
% {1,2,3},{4,5},{6,7,8},{9,10,11},{12,13},{14,15}.
%

load results_data/plateau_results_data/results_apboxprm_plat11_all
platnum = 11;
datanum = 65;
box = [2 2] + (7/8)*[2 2];
depth = 28;


D = results.data{datanum};
I = D{7};
SM = D{4};
R = D{1};
load plateaus/aprepdat.mat
[tree P Adj] = get_map_old('henon',depth,'params',reps(platnum,:),'box',box);

boxes = tree.boxes(-1);
showraf(boxes(:,I)','y','y');

%I_R = graph_mis(SM);
%SM = SM(I_R,I_R); % don't know why this wasn't already done... get rid of
%                % transient symbols
%
%showsymbols(boxes,R(I_R),1:length(I_R),'k','none');

C = {};
C{1} = [1:6 10:17 67:73 78 79 83:85 97:102];
C{2} = [74:77 81 82 86:96 103:16];
C{3} = [7:9 30 33:35];
C{4} = [18:29 31 32 36 37 39:41];
C{5} = [42:54 56:66];
C{6} = [107:146 154:158 162:180 182:189 195:199];
C{7} = [147 149 151 153 160 181 192 193 200];
C{8} = [148 150 152 159 161 190 191 194];
C{9} = [316 318 323 353 355 356 379 380 382 383];
C{10} = [317 319 324 357 358 360 381 384 385];
% C{11}
C{12} = [205 206 211 212 216 221:226];
C{13} = [201:204 207:210 214 215 28:220 227:230];
C{14} = [231 233 235 310 294:298 306 309 471:475 480:483 485 486 488 489];
C{15} = [232 234 236 307 308 311:315 476:479 484 487 490 491];
C{16} = [200 361:363 365:373];
C{17} = [237:241 265];

C{11} = setdiff(1:length(R), cat(2,C{:}));

[T comps shifteqs] = find_contraction(SM,C);

% what components did we get?
for i=1:length(C)
  fprintf('%i: %i\n',i,any(arrayfun(@(j) length(comps{j})==length(C{i}) && ...
 									all(comps{j}==C{i}), 1:length(comps))))
end

% figure;
% showregions(boxes,R(I_R),comps);
% % showsymbols(boxes,R(I_R),1:length(I_R),'k','y');
