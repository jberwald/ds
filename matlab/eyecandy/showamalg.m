function h=showamalg(SM, syms, T, col1, col2)
% function h=showamalg(SM, syms, T, col1, col2)
% plots the original symbol matrix SM (reordered in blocks by syms), with the
% new matrix T underlayed as a block
%
% showamalg(SM,syms,T,0.6*[1 1 1],'k');
%
% >> load /home/raf/Dropbox/projects/plateaus/focm-data/mackay_fig5_results_18.mat
% >> showamalg(sm,S(1:end-1),T,0.7*[1 1 1],'k');
% >> file = '/home/raf/Dropbox/projects/plateaus/focm/figs/dms-amalg.eps';        
% % add a y label of '  ' to fix border problem
% >> exportfig(gcf,file)                        
% >> eps2pdf(file)                              

[i j s] = find(T);
offset = [0 cumsum(cellfun(@length,syms))]';

% plot the new matrix
x = [offset(j+1) offset(j+1) offset(j) offset(j)];
y = [offset(i+1) offset(i) offset(i) offset(i+1)];
h = patch(x',y',col1,'EdgeColor','none');
hold on

% plot the old matrix
v = cat(2,syms{:});
[i j s] = find(SM(v,v));
c = 0.1;
x = [(j-1)+c (j-1)+c (j)-c (j)-c];
y = [(i-1)+c (i)-c (i)-c (i-1)+c];
h = patch(x',y',col2,'EdgeColor','none');

% plot the grid
x = [offset offset; repmat(0,length(offset),1) repmat(offset(end),length(offset),1)];
y = [repmat(0,length(offset),1) repmat(offset(end),length(offset),1); offset offset];
h = plot(x',y','k');
%h = plot(x',y','k--');

axis off
daspect([1 1 1]);                       % equal aspect ratio
set(gca,'ydir','reverse');              % origin at top left
set(gcf,'color','w');                   % white bg