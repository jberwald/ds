function plot_1d_plats(printp)

load aprepdat		% plats; run generate_ap_plats if not there
load apapprox		% estimates; run dat20 if the file isn't there

if (nargin < 1)
  printp = 0;
end

%ents = [0.6374 0.6373 0.6392 0.6404, 0.6430, 0.6459, 0.6467, 0.6527, 0.6718, ...
%		0.6774, 0.6814, 0.6893, 0.6903, 0.6903, 0.6922, 0.6931];

ents = [0.6374 0.6373 0.6392 0.6404, 0.6430, 0.6459, 0.6467, 0.6527, 0.6718, ...
		0.6774, 0.6814, 0.6893, 0.6893, 0.6893, 0.6893, 0.6931];

y = zeros(1,2*length(ents)+2);
x = zeros(1,2*length(ents)+2);

y(2:2:2*length(ents)) = ents;
x([1 end]) = [approx(1,1) approx(end,1)];
x(2:2:2*length(ents)) = ap_plats(:,1)';
x(3:2:2*length(ents)+1) = ap_plats(:,2)';

est_col = 'b';
lb_col = [0 1 0];
lb_col2 = [0.8 1 0.8];

%% taking out the light green for now
% for i = 1 : length(ents)-1
%   rectangle('position', [ap_plats(i,2),0,ap_plats(i+1,1)-ap_plats(i,2),ents(i)],...
% 			'facecolor', lb_col2, 'linestyle', 'none')
% end

for i = 1 : length(ents)
  rectangle('position', [ap_plats(i,1),0,ap_plats(i,2)-ap_plats(i,1),ents(i)],...
			'facecolor', lb_col, 'edgecolor', lb_col)
end

hold on
endpt = 5.8;
approx(1,5) = log(2);
plot([endpt; approx(:,1)],[log(2); approx(:,5)],est_col)
%stairs(x,y);
set(gca,'ylim',[0.63 0.7])
set(gca,'xlim',[4.5 endpt])
set(gca,'layer','top')
daspect([10, 1, 1])

ylabel('entropy')
xlabel('a')

if printp
  opts = struct('FontMode','fixed','FontSize',12,'height',6, ...
				'LockAxes', 0);
  exportfig(gcf, 'plot_1d_plats.eps', opts, 'Color', 'rgb');
  %	print -depsc plot_goodplats_print.eps
end

