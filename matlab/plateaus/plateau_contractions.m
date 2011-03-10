function C = plateau_contractions(D,E,trials)
% C = plateau_contractions(D,E,trials)
% data: {R G M SM X A I}

  K = 1000000;							% inverse of resolution for "max"

  num_plats = size(D,1);
  C = cell(num_plats,4);				% T, Syms, SH, ind

  [Y I] = max(floor(K*E'));

  for p = 1 : num_plats

	ind = I(p);
	data = D{p,ind};
	SM = data{4};
	n = size(SM,1);

	fprintf('plateau %i: %i symbols...\n',p,n);

	T = SM;
	Syms = num2cell(1:n);
	SH = [];

	for k = 1 : trials%n*trials
	  fprintf('attempt # %i\n',k);
	  v = randperm(n);
	  [T_new Syms_new SH_new] = find_contraction(SM(v,v));
	  if (size(T_new,1) < size(T,1))
		T = T_new;
		Syms = Syms_new;
		SH = SH_new;
		fprintf('   got down to %i symbols\n',length(Syms));
	  end
	end

	% remove transient symbols... add to find_contraction?
	I_T = graph_mis(T);
	C(p,:) = {T(I_T,I_T) Syms(I_T) SH ind};
	fprintf('   contracted down to %i symbols\n',length(C{p,2}));

  end
end
