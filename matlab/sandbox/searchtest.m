map = get_map('henon',10);
n = map.tree.count(-1);
b = map.tree.boxes(-1);
pts = rand(2,1000);
v = map.tree.insert(pts,map.tree.depth);

%ctrs2 = rand(2,100);
%rad2 = [0.1 0.1];
%for c = 1:size(ctrs2,2)
  % make the grid
  % insert and record which are new
  % (search to find the new numbers-- maybe later all in one go)


pts = pts(:,find(v));



fprintf('inserted %i new points\n',size(pts,2))

map.tree.count(-1);
S = map.tree.search(pts);

disp('searching the old way...')
tic
newnums_search = search_boxes(map.tree,b);
toc
disp('computing the new way...')
tic
S = sort(S)';
newnums_compute = updateboxnums(n,S);
toc

if all(newnums_search == newnums_compute)
  disp('and they are equal!')
else
  disp('shit I screwed something up...')
end