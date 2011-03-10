map = get_map('kopel',8);
v = [0.1 0.9];
hold on
for i=1:100
  v = map.map(v);
end

for i=1:5000
  v = map.map(v);
  plot(v(1),v(2),'b')
end