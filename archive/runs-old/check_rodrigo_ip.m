
rodrigo_tree = Tree('topdata/verify/verify-no-R-1.45-.45_interval_24.tree');
load topdata/total_boxes.mat			% TOTAL
rodrigo_boxes = rodrigo_tree.boxes(-1);
size(rodrigo_boxes)
max(TOTAL)
TOTAL_box = rodrigo_boxes(:,TOTAL);
clear rodrigo_tree

[raf_tree P Adj I] = get_map('henon',24,{'box',[1.45,0.45]});
S = search_boxes(raf_tree,TOTAL_box);
[R G M SM X A I Z] = compute_symbolics(S,raf_tree,'henon',P,Adj,{});
