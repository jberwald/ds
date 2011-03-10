function img = mapimage(A,S)
% function mapimage(A,S)
% computes the image of S under map A (with (i,j) entry the mapping from j to i)

img = find( A * flags(S, size(A,1)) )';
