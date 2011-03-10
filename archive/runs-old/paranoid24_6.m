[R G M SM X A] = puff_driver_paranoid('henon', 24, 6, 'box', [1.425 0.425]);
load ../paranoid/topdata/henon_box_24_1.425000_0.425000_puff_6_MG.mat
SM = contract_map(G,M); p = find(cellfun(@(x) length(x)>1, G)), log_max_eig(SM(p,p))
