
function hetero = henon3d_homoclinics(iter)

a = 0.44;
b =  0.21;
c = 0.35;
alpha = -0.25;
tau = -0.3;

p0 = [0.67201532544553, 0.67201532544553, 0.67201532544553]'; %'
p1 = [-0.37201532544553, -0.37201532544553, -0.37201532544553]'; %'

hetero = [];
intersection = {};

intersection{1} = [0.09328969638117; 1.38262210725499; -1.05758672817841];
intersection{2} = [1.48411783879203; -0.96648136242881; -0.11119773311362];
intersection{3} = [-0.80181693411610; -0.00500156011210; 1.23894147655738];
intersection{4} = [0.11392233001002; -0.76125575437453; 1.08244794544553];
intersection{5} = [0.93875066517793; 0.29087100401361; -0.79850180982201];
intersection{6} = [-0.85017247375410; 0.91798993912281; 0.36765082474070];

for i = 1 : 6

  hetero = [hetero intersection{i}];
  forward_image = h3d_image(intersection{i}, a, b, c, alpha, tau);
  backward_image = h3d_inverse(intersection{i}, a, b, c, alpha, tau);

  for j = 1 : iter

    hetero = [hetero forward_image backward_image];
    forward_image = h3d_image(forward_image, a, b, c, alpha, tau);
    backward_image = h3d_inverse(backward_image, a, b, c, alpha, tau);

  end

end

hetero = [hetero p0 p1];

end

function orbit = h3d_image(x, a, b, c, alpha, tau)
  image1 = alpha + tau*x(1) + x(3) + a*x(1)*x(1) + b*x(1)*x(2) + c*x(2)*x(2);
  image2 = x(1);
  image3 = x(2);
  orbit = [image1; image2; image3];
end

function orbit = h3d_inverse(x, a, b, c, alpha, tau)
  image1 = x(2);
  image2 = x(3);
  image3 = -alpha + x(1) - tau*x(2) - a*x(2)*x(2) - b*x(2)*x(3) - c*x(3)*x(3);
  orbit = [image1; image2; image3];
end
