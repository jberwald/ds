function P = map2tm(mapfile,X,xfile,Y,yfile)

xstrs = getset(xfile);
ystrs = getset(yfile);


fid = fopen(mapfile,'r');
cols = cell(0);
ind = 1;

tic
while 1
  lin = fgetl(fid);
  if (lin == -1)
	break
  end
  pos = strfind(lin,')');
  if (pos >= 0)
	indstr = sprintf('%d',X(ind)); % assume the domain is X, in order
	poslbrace = strfind(lin,'{');
	posrbrace = strfind(lin,'}');
	imgstr = lin((poslbrace+1):(posrbrace-1));

	for b = 1:length(Y)
	  imgstr = strrep(imgstr,ystrs{b},sprintf('%d',Y(b)));
	end

	cols{ind} = [ 'P([' imgstr '],' indstr ') = 1; ' ];
	ind = ind+1;
  end
end
toc

n = max(Y);

P = sparse(n,n)

for c = 1:length(cols)
  cols{c}
  eval(cols{c});
end
toc

fclose(fid)

end



function boxstrs = getset(file)

fid = fopen(file,'r');
boxstrs = cell(0);
ind = 1;

while 1
  lin = fgetl(fid);
  if (lin == -1)
	break
  end
  pos = strfind(lin,')');
  if (pos >= 0)
	boxstrs{ind} = lin(1:pos);% extract the coordinates for box ind
	ind = ind+1;
  end
end

fclose(fid);

end
