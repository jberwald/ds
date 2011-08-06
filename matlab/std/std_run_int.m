function std_run_int(eps,width,depth,opts)
  tstart=tic;
  params = infsup(eps,eps+width);
  fname = strrep(sprintf('std_%1.3f_d%i_%03.0f',eps,depth,1000*width),'.','p')
  map = get_map('std',6,'params',params);
  [map dat] = homoclinic_driver(map,depth,opts);
  save_map_special(map,sprintf('%s_map',fname));
  save(['output/' fname '.mat'],'dat')
  fprintf('total time -- ')
  toc(tstart)
end
