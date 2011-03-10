hold on

load output/std_0p822_d12_001.mat
map = get_map_special('std','std_0p822_d12_001_map');
showset(map,1:size(map.P,1),'g')
showset(map,dat.X,'b')

% load output/std_0p821_d12_001.mat
% map = get_map_special('std','std_0p821_d12_001_map');
% showset(map,dat.X,'k')