E24 = zeros(1,15);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 9, 'box', [1.425 0.425]); save remove_24_9.mat; E24(9) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 10, 'box', [1.425 0.425]); save remove_24_10.mat; E24(10) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 11, 'box', [1.425 0.425]); save remove_24_11.mat; E24(11) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 12, 'box', [1.425 0.425]); save remove_24_12.mat; E24(12) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 13, 'box', [1.425 0.425]); save remove_24_13.mat; E24(13) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 14, 'box', [1.425 0.425]); save remove_24_14.mat; E24(14) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 15, 'box', [1.425 0.425]); save remove_24_15.mat; E24(15) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 8, 'box', [1.425 0.425]); save remove_24_8.mat; E24(8) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 7, 'box', [1.425 0.425]); save remove_24_7.mat; E24(7) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 6, 'box', [1.425 0.425]); save remove_24_6.mat; E24(6) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 5, 'box', [1.425 0.425]); save remove_24_5.mat; E24(5) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 4, 'box', [1.425 0.425]); save remove_24_4.mat; E24(4) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 3, 'box', [1.425 0.425]); save remove_24_3.mat; E24(3) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 2, 'box', [1.425 0.425]); save remove_24_2.mat; E24(2) = log_max_eig(SM);
[R G M SM X A I tree P Adj Z] = remove_driver('henon', 24, 1, 'box', [1.425 0.425]); save remove_24_1.mat; E24(1) = log_max_eig(SM);
save remove_24_all.mat E24
