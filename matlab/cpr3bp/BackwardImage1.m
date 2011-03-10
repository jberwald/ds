
function [center radius] = BackwardImage1(xcenter, xradius, xdotcenter, xdotradius)
%
% The image is returned in matrix form with columns being the center radius center radius of the images
% R is the constant that dictates how small should the box be partitioned at the quarter Poincare section.
% R should be about 10e-7
%

     format long

     tstep = .0001;

     increase = 250;
     [garbage,s] = unix(sprintf('Backward1Raf %2.20f %2.20f %2.20f %2.20f %2.5f %2.2i', xcenter, xradius, xdotcenter, xdotradius, increase*tstep, 16));
     while(s(1) == 'f')
          increase = increase/2;
	  [garbage,s] = unix(sprintf('Backward1Raf %2.20f %2.20f %2.20f %2.20f %2.5f %2.2i', xcenter, xradius, xdotcenter, xdotradius, increase*tstep, 16));
     end
     a = eval(s);
     x = a{1};
     xdot = a{3};
     y = a{2};
     ydot = a{4};

center = [(x(1)+x(2))/2; (xdot(1)+xdot(2))/2];
radius = [abs(x(1)-x(2))/2; abs(xdot(1)-xdot(2))/2];
