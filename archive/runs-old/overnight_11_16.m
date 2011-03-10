load /home/rfrongillo/scripts/topdata/verify-1.425-.425.mat
tic
SM = reduce_index_map_pruning(M,G);
toc
save /home/rfrongillo/scripts/topdata/verify-1.425-.425-SM.mat SM
