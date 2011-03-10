
function v = standard_int_image(x,y)

% This computes the interval image of the standard map
% S(x,y) = (x + y + (e/2*pi)*sin(2*pi*x), y + (e/2*pi)*sin(2*pi*x)) 
% where x and y are intervals and 0 < e < 2 or so.

e = 1.0;

X = x + y + (e/(2*pi))*sin(2*pi*x);
Y = y + (e/(2*pi))*sin(2*pi*x);

if ((sup(X) < 0) || (inf(X) >  1))
    X = infsup_rodrigo(mod(inf(X),1), mod(sup(X),1));
  if X == -1
    X = x + y + (e/(2*pi))*sin(2*pi*x);
    X = [infsup(0, mod(sup(X),1)); infsup(mod(inf(X),1), 1)];
  end
end

if ((sup(Y) < 0) || (inf(Y) > 1))
  Y = infsup_rodrigo(mod(inf(Y),1), mod(sup(Y),1));
  if Y == -1
    Y = y + (e/(2*pi))*sin(2*pi*x);
    Y = [infsup(0, mod(sup(Y),1)); infsup(mod(inf(Y),1), 1)];
  end
end

if ((inf(Y) < 0) || (sup(Y) > 1))
  Y = [infsup(0, mod(sup(Y),1)); infsup(mod(inf(Y),1), 1)];
end

for i = 1 : length(X)
  if ((inf(X(i)) < 0) || (sup(X(i)) > 1))
    X = [infsup(0, mod(sup(X(i)),1)); infsup(mod(inf(X(i)),1), 1)];
  end
end

LX = length(X);
LY = length(Y);

if LX == 1

  if LY == 1
    v = [X Y];
    return
  end

  if LY == 2
    v = [X Y(1); X Y(2)];
    return
  end

else

  if LY == 1
    v = [X(1) Y; X(2) Y];
    return
  end

  if LY == 2
    v = [X(1) Y(1); X(1) Y(2); X(2) Y(1); X(2) Y(2)];
    return
  end
end

%    PROBLEM:
%
% >> D = standard_int_image(infsup(.48425,.5), infsup(.51575,.530625))
% intval D = 
%    0.1___    0.5___
%    1.____    0.5___
% >> inf(D)
% ans =
%         0    0.5158
%         0    0.5158
% >> sup(D)
% ans =
%    0.0432    0.5432
%    1.0000    0.5432
