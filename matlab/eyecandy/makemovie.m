function makemovie(filename,values,painter,state)
  aviobj=avifile([filename '.avi']); %creates AVI file, filename.avi 
  hf= figure('visible','off'); %turns visibility of figure off 

  for v = values
	state = painter(v,state);
	aviobj=addframe(aviobj,hf); %adds frames to the AVI file 
  end  
  
  aviobj=close(aviobj); %closes the AVI file  
  close(hf); %closes the handle to invisible figure 
