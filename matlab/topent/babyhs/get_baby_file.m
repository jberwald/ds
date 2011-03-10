% function [v p] = get_baby_file(name,periods,var)

function [v p] = get_baby_file(name,period,var)
  max_search_period = 12;
  search_list = [period:max_search_period (period-1):-1:1];
  p = 0;								% just instantiate the variable p
  for p = search_list;
	name_p = sprintf(name,p);
	[s r] = unix(['ls ' name_p]);
	if (s == 0)							% found the file
	  s = load(name_p,var);
	  eval(['v = s.' var ';']);
	  return
	end
  end
  p = -1;
  v = [];
end
