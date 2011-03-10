function C = homoclinic_points(epsilon,depth,opts)
% returns C = {s1, t1; s2, t2; ...} where each si should connect to ti

q = 2^(-depth);

disp('Computing intersection of stable and unstable manifolds...');

[x1 y1 x2 y2] = draw_invariant_manifolds2(epsilon,depth);

ints = {[0.5; y1] [.5; 1-y1] [x2; y2] [1-x2; 1-y2]};  % intersections
fpts = {[q;q] [1-q;q] [q;1-q] [1-q;1-q]};

C = {
	fpts{1} ints{1}; ints{1} fpts{2};
	fpts{1} ints{3}; ints{3} fpts{2};
	fpts{4} ints{2}; ints{2} fpts{3};
	fpts{4} ints{4}; ints{4} fpts{3};
	};

if isfield(opts,'per2')
  P2 = stdperiodtwo(epsilon);

  if isfield(opts,'p2_1')
	i = opts.p2_1
	j = opts.p2_2
	C(end+1,:) = { fpts{1} P2(:,i) };
	C(end+1,:) = { P2(:,j) fpts{1} };
  else
	C(end+1,:) = { fpts{1} P2(:,1) };
	C(end+1,:) = { P2(:,1) fpts{1} };
    C(end+1,:) = { ints{1} P2(:,1) };
    C(end+1,:) = { P2(:,1) ints{1} };
    C(end+1,:) = { ints{2} P2(:,1) };
    C(end+1,:) = { P2(:,1) ints{2} };
    C(end+1,:) = { ints{3} P2(:,1) };
    C(end+1,:) = { P2(:,1) ints{3} };
    C(end+1,:) = { ints{4} P2(:,1) };
    C(end+1,:) = { P2(:,1) ints{4} };

    C(end+1,:) = { fpts{1} P2(:,2) };
    C(end+1,:) = { P2(:,2) fpts{1} };
    C(end+1,:) = { ints{1} P2(:,2) };
    C(end+1,:) = { P2(:,2) ints{1} };
    C(end+1,:) = { ints{2} P2(:,2) };
    C(end+1,:) = { P2(:,2) ints{2} };
    C(end+1,:) = { ints{3} P2(:,2) };
    C(end+1,:) = { P2(:,2) ints{3} };
    C(end+1,:) = { ints{4} P2(:,2) };
    C(end+1,:) = { P2(:,2) ints{4} };
  end
end


