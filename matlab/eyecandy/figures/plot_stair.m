function plot_stair(X,V)
[length(X) length(V)]
if (length(V) < length(X))
    V = [V V(length(V)-1)];
end
stairs(X,V);
fixYLim(gca,min(V),max(V))
set(gcf,'Position',[150 140 300 290]);
set(gcf,'Color',[1 1 1]);
end

function fixYLim(h,ymin,ymax)
    tickvec = get(h,'YTick');
    tick = tickvec(2) - tickvec(1);
    ylim = get(h,'YLim');
    if (ylim(1)== ymin)
        ylim(1) = ylim(1)-tick;
    end
    if (ylim(2)== ymax)
        ylim(2) = ylim(2)+tick;
    end
    set(h,'YLim',ylim);
end
