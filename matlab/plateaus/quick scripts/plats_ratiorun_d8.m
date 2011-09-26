load ../plateaus/focm-data/repdata

plat = 18;
depth = 8;
area = 4;
logr0 = -log(4); logrK = log(8); 
K = 60;

params = sup(reps(goodplats(plat),:))
logr = logr0 + (logrK-logr0)*(0:K)/K;

fname = sprintf('../plateaus/focm-data/scaletest-depth%i-goodplat%i.mat',depth,plat);
[E I] = plats_ratiotest(depth,params,area,logr);
save(fname,'E','I','K','area','depth','logr0')
