
function [n iter] = number_of_iterations(epsilon)

% function [n iter] = number_of_iterations(epsilon)
%
% This FUNction spits back the number of iterations needed in the file
% draw_invariant_manifolds.m to be efficient.
%

if epsilon == .3
n = 215000;
iter = 22;
elseif epsilon == .35
n = 215000;
iter = 21;
elseif epsilon == .4
n = 200000;
iter = 19;
elseif epsilon == .45
n = 180000;
iter = 17;
elseif epsilon == .5
n = 170000;
iter = 16;
elseif epsilon == .55
n = 170000;
iter = 15;
elseif epsilon == .6
n = 180000;
iter = 15;
elseif epsilon == .65
n = 170000;
iter = 13;
elseif epsilon == .7
n = 170000;
iter = 13;
elseif epsilon == .75
n = 170000;
iter = 12;
elseif epsilon == .8
n = 170000;
iter = 12;
elseif epsilon == .85
n = 170000;
iter = 11;
elseif epsilon == .9
n = 170000;
iter = 10;
elseif epsilon == .95
n = 170000;
iter = 11;
elseif epsilon == 1.0
n = 170000;
iter = 9;
elseif epsilon == 1.05
n = 170000;
iter = 8;
elseif epsilon == 1.1
n = 120000;
iter = 8;
elseif epsilon == 1.15
n = 120000;
iter = 8;
elseif epsilon == 1.2
n = 120000;
iter = 8;
elseif epsilon == 1.25
n = 120000;
iter = 8;
elseif epsilon == 1.3
n = 120000;
iter = 7;
elseif epsilon == 1.35
n = 100000;
iter = 7;
elseif epsilon == 1.4
n = 90000;
iter = 7;
elseif epsilon == 1.45
n = 80000;
iter = 6;
elseif epsilon == 1.5
n = 85000;
iter = 6;
elseif epsilon == 1.55
n = 80000;
iter = 6;
elseif epsilon == 1.6
n = 80000;
iter = 6;
elseif epsilon == 1.65
n = 80000;
iter = 6;
elseif epsilon == 1.7
n = 85000;
iter = 6;
elseif epsilon == 1.75
n = 80000;
iter = 5;
elseif epsilon == 1.8
n = 80000;
iter = 5;
elseif epsilon == 1.85
n = 80000;
iter = 5;
elseif epsilon == 1.9
n = 85000;
iter = 5;
elseif epsilon == 1.95
n = 80000;
iter = 5;
elseif epsilon == 2
n = 80000;
iter = 7;
else
disp('Pick another epsilon, buddy.')
end
