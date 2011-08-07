load results_data/plateau_results_data/results_apboxprm_plat12_all.mat 
load aprepdat

i = 60;
plat = 12;
dlen = 8;
[depth box] = plats_num2depth(i,results.depths,dlen)

D = results.data{i}
R = D{1};
SM = D{4};
X = D{5};
A = D{6};
[tree P Adj] = get_map_old('henon',depth,'params',reps(plat,:),'box',box);
boxes = tree.boxes(-1);
showraf(boxes(:,X)','c','c'); showraf(boxes(:,A)','w','w');

SM = restrict_to_sccs(SM);
syms = graph_mis(SM);
showsymbols(boxes, R, syms, 'k', 'none');
