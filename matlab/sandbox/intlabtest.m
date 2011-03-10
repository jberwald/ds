params = [1.4 0.3];

fvec = @(v) [1 - params(1) * v(1) * v(1) + v(2), params(2) * v(1)];
fmat = @(V) [1 - params(1) * V(:,1) .* V(:,1) + V(:,2), params(2) * V(:,1)];

map = get_map('henon',10);
boxes = map.tree.boxes(-1);
n = size(boxes,2);
d = map.tree.dim;

I = [intval(zeros(n,d))];
  
for j = 1:d
  % Gets the box in terms of its intervals:
  I(:,j) = infsup((boxes(j,:)-boxes(j+d,:)), (boxes(j,:)+boxes(j+d,:)))';
end

tic
t = cputime;
Vec = [intval(zeros(n,d))];
for i = 1:n
  % Gets the box in terms of its intervals:
  Vec(i,:) = fvec(I(i,:));
end
cputime - t
toc

tic
t = cputime;
Mat = fmat(I);
cputime - t
toc

all(all(Mat==Vec))