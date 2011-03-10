function prettypictures(map,dat)
% prettypictures(map,dat)
% show ip, symbol regions, homology
    
  showip(map,dat);
  showsymregions(map,dat);
  mosthomologicallyinterestingregion(map,dat);