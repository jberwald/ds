load /home/rfrongillo/scripts/topdata/verify-1.43-.4375.mat
tic
SM = reduce_index_map_pruning(M,G);
toc
save /home/rfrongillo/scripts/topdata/verify-SM.mat SM
