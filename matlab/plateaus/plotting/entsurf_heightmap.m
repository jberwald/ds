function entsurf_heightmap(filename, b, plats, ents)
% outputs the entropy height map, where plats(i) has entropy ents(i)

if nargin < 2
  load good_plats
  load repdat
  load results_goodplat_boxprm_d26_all_E.mat
  plats = R_plat(good_plats);
  ents = max(E')
  tree = Tree('plateaus/zinarai.tree');
  b = tree.boxes(-1);
end

fid = fopen(filename,'w');

d = (size(b,1)-2)/2; %d==2

diam = 2*min(b(d+1:2*d,:)');				% find the min radii * 2
for i=1:d
  b(i,:) = (b(i,:) - b(i+d,:)) / diam(i);% normalize pos to integers
  b(i+d,:) = b(i+d,:)*2 / diam(i);		% normalize diam to integers
  b(i,:) = b(i,:) - min(b(i,:)) + 1;	% set range to Z_+
end

ht = round(b)';
ht(:,[5 6]) = 0;  % kill flags

for p = 1 : size(plats)
  ents(p)
  ht(plats{p},5) = ents(p);
  ht(plats{p},6) = p;
end

for r = 1 : size(ht,1)
  fprintf(fid, '%d ', ht(r,1:4));
  fprintf(fid, '%3.4f ', ht(r,5));
  fprintf(fid, '%d ', ht(r,6));
  fprintf(fid, '\n');
end

fclose(fid);

% H = sparse(0);
% N = sparse(0);

% for p = 1 : size(plats)
%   for i = plats{p}
% 	x = ht(i,1) : (ht(i,1) + ht(i,1+d) - 1);
% 	y = ht(i,2) : (ht(i,2) + ht(i,2+d) - 1);
% 	H(x,y) = ents(p);
% 	N(x,y) = p;
%   end
% end

% for r = 1 : size(H,1)
%   fprintf(fid1, '%d ', full(H(r,:)));
%   fprintf(fid1, '\n');
%   fprintf(fid2, '%d ', full(N(r,:)));
%   fprintf(fid2, '\n');
% end

% fclose(fid1);
% fclose(fid2);

