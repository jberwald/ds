function validate_mapfile(mapfile,X,xfile,Y,yfile)

mapfile
disp('validating map file...')
P = map2tm(mapfile,X,xfile,Y,yfile);
save('validate_mapfile_P.mat','P')
