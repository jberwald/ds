box = [1.3,0.4];
ents = box_test('henon',18,3,box,2.2*box,96);
save('box_ents1_12_16.mat','ents');
ents = box_test('henon',18,2,box,2.2*box,96);
save('box_ents2_12_16.mat','ents');

