load topdata/verify-1.43-.4375.mat
tic
[SM RM ProbR prob_paths] = reduce_index_map(M,G);
toc
save topdata/verify-1.43-.4375-results.mat
