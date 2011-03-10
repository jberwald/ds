function path = random_walk(A,v,length_range)
  shortest = length_range(1);
  longest = length_range(2);
  path_len = randint(longest-shortest+1) - 1 + shortest;

  path = [v];
  for i = 2 : path_len
	img = mapimage(A,path(i-1));
	path(i) = img(randint(length(img))); % random image
  end
end
