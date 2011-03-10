E22 = zeros(1,15);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 9, 'box', [1.425 0.425]); save remove_22_9.mat; E22(9) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 10, 'box', [1.425 0.425]); save remove_22_10.mat; E22(10) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 11, 'box', [1.425 0.425]); save remove_22_11.mat; E22(11) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 12, 'box', [1.425 0.425]); save remove_22_12.mat; E22(12) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 13, 'box', [1.425 0.425]); save remove_22_13.mat; E22(13) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 14, 'box', [1.425 0.425]); save remove_22_14.mat; E22(14) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 15, 'box', [1.425 0.425]); save remove_22_15.mat; E22(15) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 8, 'box', [1.425 0.425]); save remove_22_8.mat; E22(8) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 7, 'box', [1.425 0.425]); save remove_22_7.mat; E22(7) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 6, 'box', [1.425 0.425]); save remove_22_6.mat; E22(6) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 5, 'box', [1.425 0.425]); save remove_22_5.mat; E22(5) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 4, 'box', [1.425 0.425]); save remove_22_4.mat; E22(4) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 3, 'box', [1.425 0.425]); save remove_22_3.mat; E22(3) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 2, 'box', [1.425 0.425]); save remove_22_2.mat; E22(2) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 22, 1, 'box', [1.425 0.425]); save remove_22_1.mat; E22(1) = log_max_eig(SM);
save remove_22_all.mat E22
