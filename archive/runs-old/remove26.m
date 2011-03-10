E26 = zeros(1,15);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 26, 10, 'box', [1.425 0.425]); save remove_26_10.mat; E26(10) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 26, 11, 'box', [1.425 0.425]); save remove_26_11.mat; E26(11) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 26, 12, 'box', [1.425 0.425]); save remove_26_12.mat; E26(12) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 26, 13, 'box', [1.425 0.425]); save remove_26_13.mat; E26(13) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 26, 14, 'box', [1.425 0.425]); save remove_26_14.mat; E26(14) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 26, 9, 'box', [1.425 0.425]); save remove_26_9.mat; E26(9) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 26, 8, 'box', [1.425 0.425]); save remove_26_8.mat; E26(8) = log_max_eig(SM);
save remove_26_all.mat E26
