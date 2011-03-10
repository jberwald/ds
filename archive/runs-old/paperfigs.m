opts1 = struct('FontMode','scaled','Color','cmyk','height',6);
%opts = struct('FontMode','scaled','FontSize',10,'height',4);

% plot(9:15,[0 0 0.4226 0.3852 0.2975 0 0]);
% xlabel('preimage number')
% ylabel('entropy')
% exportfig(gcf,'entropy-vs-preimages-depth-24.eps',opts1)
% disp('figure saved'), pause
% close

% plot(7:12,[0 0.3007 0.3713 0.3565 0.3367 0.4320]);
% set(gca,'xtick',7:12);
% xlabel('depth')
% ylabel('entropy')
% exportfig(gcf,'entropy-vs-depth.eps',opts1)
% disp('figure saved'), pause
% close

% plot(1:8,[0.2011 0.2201 0.2201 0.2379 0.2379 0.3107 0.4320 0]);
% xlabel('maximum cycle length')
% ylabel('entropy')
% exportfig(gcf,'entropy-vs-cycle-length-depth-24.eps',opts1)
% disp('figure saved'), pause
% close



opts2 = struct('height',2)
load results_data/dft_results_data/henon_box_24_1.425000_0.425000_puff_7_all.mat

showraf(boxes(:,X)','b','b');
showraf(boxes(:,A)','c','c');
%exportfig(gcf,'henon-24-1_425-0_425-period-7-ip.eps',opts2)
% previewfig(gcf,opts2)
% disp('figure saved'), pause
% close

% % I_SM = graph_mis(SM);
% % SMfinal = SM(I_SM,I_SM);
% % spy(SMfinal);
% % xlabel('');
% % exportfig(gcf,'henon-24-1_425-0_425-period-7-sm-spy.eps',opts1)
% % disp('figure saved'), pause
% % close



% load results_data/remove_24_11.mat                         

% showraf(boxes(:,X)','b','b');
% showraf(boxes(:,A)','c','c');
% showraf([1.2717 -0.0207 .02 .001 0 0], 'r', 'r');
% exportfig(gcf,'henon-24-1_425-0_425-11-preimages-ip-gap.eps',opts2)
% disp('figure saved'), pause
% close
