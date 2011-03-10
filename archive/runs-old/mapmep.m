function [R G M SM X A I Z] = mapmep()

load plateaus/aprepdat_b2.mat
load ../thesis/apboxprm_b2_d24.mat

box = [2 2]*(1+5/8);
[tree P Adj] = get_map_old('henon',12,'params',reps(1,:),'box',box);
boxes = tree.boxes(-1);

[R G M SM X A I Z] = compute_symbolics(1:265,tree,'henon',P,Adj);
idstr = Z{3};
FG = fullgens(tree,idstr,'henon');

FGB = {};
IMB = {};
IM = {};
for i=1:length(FG)
  FGB{i} = scale_boxes(boxes(:,FG{i}), 0.8)';
  IM{i} = mapimage(P,FG{i});
  IMB{i} = scale_boxes(boxes(:,IM{i}), 0.5)';
end

close
cols = {'m' 'r' 'b' 'g'};
for c = 1:length(cols)
  figure
  showraf(boxes',[0.9 0.9 0.9]',[0.9 0.9 0.9]');
  axis tight;
  title(sprintf('Image of generator %d',c))
  showraf(boxes(:,X)','c','c');
  showraf(boxes(:,A)','k','k');
  for i = 1:length(FGB)
	showraf(FGB{i},cols{i},cols{i});
  end
  showraf(IMB{c},'y','y');
  showraf(scale_boxes(IMB{c}',0.6)',cols{c},cols{c});
  filename = sprintf('../public_html/dynamics/mapmep-img%d.png',c);
  saveas(gcf,filename,'png');
end

system('chmod 755 ../public_html/dynamics/mapmep*.png');
