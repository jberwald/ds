load results_data/plateau_results_data/results_apboxprm_plat10_all
D = results.data{40};
A = D{6};
I = D{7};
S = D{4};
R = D{1};
load plateaus/aprepdat.mat
[tree P Adj] = get_map_old('henon',20,'params',reps(10,:),'box',[2 2]);
boxes = tree.boxes(-1);
%showraf(boxes(:,I)','b','b');

I_R = graph_mis(S);
S = S(I_R,I_R); % don't know why this wasn't already done... get rid of
                % transient symbols

%showsymbols(boxes,R(I_R),1:length(I_R),'k','y');

% old numbers:
% comps = {1:6, 7:10, 11:13, 14, [30 35 44], [22:24 26 27 29:31 35 36 38 43], ...
%		 [25 39 40 45 46], 15:21}

comps = {1:6, 7:10, 11:13, 14, [29 31 37], [28 30 32 36 26 27 33 22 23 24], ...
		 [25 34 35 38 39], 15:21};

[T comps2 shifteqs] = find_contraction(S,comps);

figure;
showregions(boxes,R(I_R),comps2);
pause
opts = struct('FontMode','fixed','Color','cmyk','height',6);
exportfig(gcf,'dmsplot.eps',opts)

%showraf(boxes(:,A)','k','k');
% showsymbols(boxes,R(I_R),1:length(I_R),'k','y');
