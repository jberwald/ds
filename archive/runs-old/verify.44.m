load /home/rfrongillo/scripts/topdata/verify-1.44-.44.mat
tic
SM = reduce_index_map_pruning(M,G,0.44);
toc
save /home/rfrongillo/scripts/topdata/verify-1.44-.44-SM.mat SM
