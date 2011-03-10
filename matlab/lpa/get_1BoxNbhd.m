function N = get_1BoxNbhd(tree,S,depth)

% N = get_1BoxNbhd(tree,S,depth)
% Gets a one box neighborhood around S. The function does this by inserting
% boxes into the tree and then returning them(including the original S).

% This code runs correctly!!!

format long;

d = tree.dim;

b = tree.boxes(depth);
S = S(:);


% Gets the center and radius of the box used to insert the
% one box neighborhood
for bi = 1:size(S,1)
    c(:,bi) = b(1:d, S(bi));        % Box center
    r(:,bi) = 1.1*b(d+1:2*d,S(bi)); % Box radii
    f(:,bi) = b(2*d+1,S(bi));       % Gets the flag of the box
end

% Insert the one box nbhd of S into the tree
for k = 1:size(S,1)
    if f(:,k) ~= 99                         % Test if a one box neighborhood has already been inserted by this function.
        tree.insert_box(c(:,k),r(:,k),depth);
        tree.set_flags(c(:,k),99);          % Sets the flag of the box to 99 so the insertion
                                            % step will not be repeated
                                            % unnecessarily.
    end
end


b = tree.boxes(depth);
n = zeros(1,size(b,2));

% Find the boxes in the one box neighborhood of S.
for j = 1:size(S,1)
    I = tree.search_box(c(:,j),r(:,j),depth);
    n(I) = 1;
end

N = find(n);
