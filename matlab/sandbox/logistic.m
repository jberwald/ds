map = get_map('logistic',10,'params',3.3);
[i2c c2i P] = components_raf(map.P);
boxes = map.tree.boxes(-1);
x = boxes(1,:);
y = 1 - (i2c / length(i2c));
plot(x,y)


% y = zeros(1,length(x));
% for c = 1:length(c2i)
%   y(c2i{c}) = c / length(c2i);
% end

% plot(x,y)
% hold on
% plot((1:length(x))/length(x),x,'r*')