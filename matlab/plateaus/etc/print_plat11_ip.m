load results_data/plateau_results_data/results_apboxprm_plat11_all.mat 
d = 65;

D = results.data{d}
R = D{1};
SM = D{4};
X = D{5};
A = D{6};
[tree P Adj] = get_map_old('henon',28,'params',reps(11,:),'box',[2 2]+7*[2 2]/8);
boxes = tree.boxes(-1);
showraf(boxes(:,X)','c','c'); showraf(boxes(:,A)','k','k');

SM = restrict_to_sccs(SM);
syms = graph_mis(SM);
showsymbols(boxes, R, syms, 'k', 'y');
