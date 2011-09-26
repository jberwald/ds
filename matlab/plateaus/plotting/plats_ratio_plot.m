load ../plateaus/focm-data/ratiotest-depth9-applat14.mat 
E9=E;
load ../plateaus/focm-data/ratiotest-depth10-applat14.mat
E10=E;
plot(logr,E9,'b-',logr,E10,'g-') 
ylim([0.445 0.705])
xlim([logr(1)-0.2 logr(end)+0.2])

%plats_savefig('ratio-scale',0.5)