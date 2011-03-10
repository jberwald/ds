function std_int_plot

width2 = 0.002;
xn = 0.858;
x0 = 0.814;
[v2 xs2] = getdata(x0,xn,width2);

width1 = 0.005;
xn = 0.960;
x0 = 0.855;
[v1 xs1] = getdata(x0,xn,width1);

stairs([x0+width1 xs1 xs2(3:end)],[v1 v2(3:end) 0])

hold on
plot(gca,0.7,0.216,'*')
plot(gca,0.8,0.21765,'*')
set(gca, 'xlim', [.69, .97])

end

function [v xs] = getdata(x0,xn,width)
  xs = xn:-width:x0;
  v = [];
  for x = xs
	mapstr = sprintf('std_0p%d',round(x*1000))
	load([mapstr '.mat']);
	v(end+1) = log_max_eig(results.SM{2});
  end
end
