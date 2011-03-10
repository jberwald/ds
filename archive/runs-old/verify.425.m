load topdata/verify-1.4-.425.mat
tic
SM = reduce_index_map_pruning(M,G,0.422395);
toc
save topdata/verify-1.4-.425-SM.mat SM
