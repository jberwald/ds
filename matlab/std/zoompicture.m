eps = 0.56;
depth = 15;
fname = strrep(sprintf('std_%1.3f_d%i',eps,depth),'.','p');
map = get_map_special('std',[fname '_map']);
load(['output/' fname])

hold on
standard_map(eps,80,2000,0.7*[1 1 1]);
draw_invariant_manifolds(eps,0);
showset(map,results.X,'c');
showset(map,results.A,'k');

zoomx = [0.4840 0.5150];
zoomy = [0.22121 0.22974];

saveas(gcf,'../std/ims/zoompicture.fig')