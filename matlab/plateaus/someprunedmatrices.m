% plateau 11 / I_p / ap plateau 10
M = prunedmatrix({'001x100'});
log_max_eig(M)
% plateau 12 / I_q
M = prunedmatrix({'1x100'});
log_max_eig(M)
% plateau 5 / I_r
M = prunedmatrix({'10x10'});
log_max_eig(M)
% plateau 7 / I_s
M = prunedmatrix({'0x10'});
log_max_eig(M)
% ap plateau 12 / shudo # 1
M = prunedmatrix({'0001x1000'});
log_max_eig(M)
% ap plateau 11 / shudo # 2
M = prunedmatrix({'0001x1001','001x1000'});
log_max_eig(M)
% ap plateau 10 / shudo # 3
M = prunedmatrix({'001x100'});
log_max_eig(M)
% ap plateau 7 / shudo # 4
M = prunedmatrix({'001x10101','0001x101001','10101x100','100101x1000','001x1011','001x100','1101x100'});
log_max_eig(M)
% ap plateau 3 / shudo # 5
M = prunedmatrix({'001x11100','001x101','00111x100','01x100'});
log_max_eig(M)

