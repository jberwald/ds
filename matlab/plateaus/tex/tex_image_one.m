function tex_image_one(boxes,data,Syms,imstr)
% tex_image_one(tree,data,Syms,imstr)
% data: {R G M SM X A I}

  R = data{1};
  A = data{6};

  % index pair image
  showraf(boxes(:,A)', 'k', 'k');
  colvec = showregions(boxes,R,Syms);

  chars = num2cell(arrayfun(@(x) char('A'+x-1), 1:length(Syms)));
  legend('P_0', chars{:});

  
  thesisfig(sprintf('%s-ip', imstr))
  close

end
