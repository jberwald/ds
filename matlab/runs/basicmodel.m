depth = 32;

map = get_map('BasicModel3s4',1);
map.tree.delete(0);
map.tree.insert(map.center',depth);
map.inverse = (@(x) []);

map = grow_ip_insert(map);
