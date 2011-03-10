function mapobj = init_BasicModel3s4

harem = 1.248

mapobj = struct;

mapobj.params = [harem]; %#ok<NBRAK> % parameters
mapobj.mapfunc = @(params) (@(x) the_map(params,x));
mapobj.boxfunc = @(params) get_box(params);
mapobj.space = 'Rn';

end


function [center radius] = get_box(params) %#ok<INUSD>

center = [2371 2371 7952 1868];
radius = [500 500 500 500];
end



function evaluated = the_map(params,x)

K = 10000; %the carrying capacity term

% % %----------
% % %Birthrates
% % %----------

b_t = 1.1; %third year female birthrate
b_a = 2.35; %adult female birthrate

harem = params(1); %this term determines the boundary for the piecewise function
%used for the birthrate. Essentially, we are supposing a a linear
%relationship between birthrate and the proportion of breeding
%males to breeding females from 0 <= proportion <= 1/harem such
%that at proportion = 0, birthrate = 0, and proportion = 1/harem,
%birthrate = b_t or b_a. Then, for proportion > 1/harem, birthrate
%is a constant - b_t or b_a.

p_f = 0.55; %percentage of the female population that breeds in any given year

% % % --------------
% % % Survival rates
% % % --------------

%This set of equations is for decoupled survival/harvesting
c_s = 0.80; %cubs (both genders)

%Landed Survival Rates
o_f = 0.85; %first year females
o_m = 0.85; %first year males

s_f = 0.995; %second year females
s_m = 0.999; %second year males

t_f = 0.995; %third year females
t_m = 0.999; %third year males

d_f = 0.998; %adult females (breeding and resting)

d_m = 0.999; %adult males

% % % %----------------
% % % %Harvesting rates
% % % %----------------

h_c = 0; %cubs (both genders)

h_of = 0.05; %first year females
h_om = 0.05; %first year males

h_sf = 0.22; %second year females
h_sm = 0.45; %second year males

h_tf = 0.05; %third year females
h_tm = 0.30; %third year males

h_df = 0.13; %adult females
h_dm = 0.19; %adult males

% h_c = 0; %cubs (both genders)
%
% h_of = 0; %first year females
% h_om = 0; %first year males
%
% h_sf = 0; %second year females
% h_sm = 0; %second year males
%
% h_tf = 0; %third year females
% h_tm = 0; %third year males
%
% h_df = 0; %adult females
% h_dm = 0; %adult males

% % % ----------------
% % % Maturation rates
% % % ----------------
%these v values represent the probability that a bear is in a given age
%category

% v_cm = 0.5185;  %cubs, male
% v_fm = 0.4096;  %first years, male
% v_sm = 0.0719;  %second years, male
% v_tm = 0.083;   %third years, male
% v_am = 0.9170;  %adults, male
% v_cf = 0.5185;  %cubs, female
% v_ff = 0.4096;  %first years, female
% v_sf = 0.0719;  %second years, female
% v_tf = 0.0909;  %third years, female
% v_af = 0.9091;  %adults, female

v_cm = 1/3;  %cubs, male
v_fm = 1/3;  %first years, male
v_sm = 1/3;  %second years, male
v_tm = 1/2;   %third years, male
v_am = 1/2;  %adults, male
v_cf = 1/3;  %cubs, female
v_ff = 1/3;  %first years, female
v_sf = 1/3;  %second years, female
v_tf = 1/2;  %third years, female
v_af = 1/2;  %adults, female

% % %-----------------------------
% % %Initializing Solution Vectors
% % %-----------------------------

S_f = x(1); %Subadults (male)

S_m = x(2); %Subadults (female)

A_f = x(3); %Adults (male)

A_m = x(4); %Adults (female)

Total = S_m+S_f+A_m+A_f; %Total Bears, the sum of all four sub-populations

%Examining the proportion of breeding males (in this case, A_m) to breeding
%females (in this case, A_f). This will be used in a birth term.
if A_f == 0
    ratio = 0;
else
    ratio = A_m/A_f;
end

if harem ~= 0
    max = 1/harem;
else
    max = 0;
end

%Creating the birthrate as a piecewise function of the proportion of
%breeding males to breeding females.
if  ratio <= max && ratio >= 0 && harem ~= 0
    br_t = b_t*harem*ratio;
    br_a = b_a*harem*ratio;
else
    br_t = b_t;
    br_a = b_a;
end

% % % % % % % % % % % % % % -----------------------------------------------
% % % % % % % % % % % % % % -----------------------------------------------
% % % % % % % % % % % % % % The Simulation
% % % % % % % % % % % % % % -----------------------------------------------
% % % % % % % % % % % % % % -----------------------------------------------



    %Ensuring that the harvest rates are never above 99%, for stability of
    %the code
    if h_c > .99
        h_c = 0.99;
    end

    if h_of > .99
        h_of = .99;
    end

    if h_om > .99
        h_om = .99;
    end

    if h_sf > .99
        h_sf = .99;
    end

    if h_sm > .99
        h_sm = .99;
    end

    if h_tf > .99
        h_tf = .99;
    end

    if h_tm > .99
        h_tm = .99;
    end

    if h_df > .99
        h_df = .99;
    end

    if h_dm > .99
        h_dm = .99;
    end

    %Ensuring that the harvest rate is never larger than the survival rate.
    if h_c > c_s
        h_c = c_s;
    end

    if h_of > o_f
        h_of = o_f;
    end

    if h_om > o_m
        h_om = o_m;
    end

    if h_sf > s_f
        h_sf = s_f;
    end

    if h_sm > s_m
        h_sm = s_m;
    end

    if h_tf > t_f
        h_tf = t_f;
    end

    if h_tm > t_m
        h_tm = t_m;
    end

    if h_df > d_f
        h_df = d_f;
    end

    if h_dm > d_m
        h_dm = d_m;
    end

    % % % % % % % % % % % % % % -----------------------------------------------
    % % % % % % % % % % % % % % -----------------------------------------------
    % % % % % % % % % % % % % % Equations
    % % % % % % % % % % % % % % -----------------------------------------------
    % % % % % % % % % % % % % % -----------------------------------------------
    %These equations correspond to Basic Model Version 1, found in Chapter 2,
    %Section 3 of the thesis. There is now a nonlinear carrying capacity
    %term included in the A_f and A_m equations.

    b_1 = 0.5*v_tf*br_t*p_f + 0.5*v_af*br_a*p_f;
    c_1 = (v_cf*(c_s - h_c) + v_ff*(o_f-h_of));
    d_1 = (v_cm*(c_s - h_c) + v_fm*(o_m-h_om));
    e_1 = v_sf*(s_f-h_sf);
    f_1 = (v_tf*(t_f - h_tf) + v_af*(d_f - h_df));
    g_1 = v_sm*(s_m-h_sm);
    j_1 = (v_tm*(t_m - h_tm) + v_am*(d_m - h_dm));
    
    %Subadult Females
    S_f2 = b_1*A_f + c_1*S_f;

    %Subadult Males
    S_m2 = b_1*A_f + d_1*S_m;

    %Adult Females
    A_f2 = e_1*S_f + f_1*A_f*exp(1-(A_f+A_m)/K);

    %Adult Males
    A_m2 = g_1*S_m + j_1*A_m*exp(1-(A_f+A_m)/K);

    Total2 = S_m2 + S_f2 + A_m2 + A_f2;

    p = intval(zeros(1,4));
    p(1) = S_f2;
    p(2) = S_m2;
    p(3) = A_f2;
    p(4) = A_m2;

    evaluated = p;

end


