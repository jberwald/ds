map = get_map('std',8,'params',2);
PP = list_pps(4,map);
PPh = hyperbolic_orbits(map,PP);
S = cat(2,PPh{:,1});
dat = compute_symbolics(S,map);
save std_eps2_explore8 PP PPh S dat

% opts = struct;
% opts.actionoffset = -1;		% use action, default offset

% map = get_map('std',5,'params',1.8);
% depth = 9;
% disp('computing homoclinic insertion...')
% map = homoclinic_insertion_skinny(map, depth, opts)

% save_map_special(map,'stdtest');


% map = get_map_special('std','stdtest');
% map.inverse = map.invfunc(map.params);
% disp('growing invariant set...')
% tic
%   [map ImgCell_slow T_slow] = grow_ip_insert(map,opts);
% toc

% plotb(map.tree,'g')
% hold on

% %disp('computing symbolics...')
% %dat = compute_symbolics(map.I,map,{'noims'});

% map = get_map_special('std','stdtest');
% map.inverse = map.invfunc(map.params);
% disp('growing invariant set faster...')
% tic
%   [map ImgCell_fast T_fast] = grow_ip_insert_faster(map,opts);
% toc

% plotb(map.tree,'b')

% % figure
% % plot(1:size(T_fast,1),T_fast(:,4:5),'b')
% % hold on
% % plot(1:size(T_slow,1),T_slow(:,4:5),'r')
% % title('steps 4 and 5 per iteration')

% % figure
% % plot(1:size(T_slow,1),sum(T_slow,2),'r')
% % hold on
% % plot(1:size(T_fast,1),sum(T_fast,2),'b')
% % title('total time per iteration')
