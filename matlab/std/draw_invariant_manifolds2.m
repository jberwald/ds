
function [x1 y1 x2 y2] = draw_invariant_manifolds2(epsilon, depth, plotp)

if nargin==2, plotp=0; end

format long

%==========================================================================
%Progaram Controlls:
%==========================================================================
   
%Parameterization of the Stable and Unstable manifolds:
    numManifoldPoints = 10000 + 1000 * depth; %2000 * depth
    order = 100 + 2*depth;
    endPoint = 10.0;
    step = (endPoint - 0)/numManifoldPoints;
    t = 0;
    parmIterates = 1;    
    

%==========================================================================
%Computations:
%==========================================================================
    
%Stable and Unstable manifold parameterization computation:
    lambda = 1 + epsilon/2 + sqrt(epsilon*(4+epsilon))/2;
alpha = 1;
lambda_bar = 1 + epsilon/2 - sqrt(epsilon*(4+epsilon))/2;
alpha_bar = alpha;

a1 = alpha;
b1 = a1*(1/2 + sqrt(epsilon*(4+epsilon))/(2*epsilon));

a_bar1 = alpha_bar;
b_bar1 = a_bar1*(1/2 - sqrt(epsilon*(4+epsilon))/(2*epsilon));

alpha0 = 1;
beta0 = 0;
alpha1 = 0;
beta1 = b1;


A(2) = a1;
B(2) = b1;
Alpha(1) = 1;
Beta(1) = 0;
Alpha(2) = 0;
Beta(2) = b1;

A_bar(2) = a_bar1;
B_bar(2) = b_bar1;
Alpha_bar(1) = 1;
Beta_bar(1) = 0;
Alpha_bar(2) = 0;
Beta_bar(2) = b_bar1;

%Compute the coefficents from the recursion formula:
for n = 1:(order-1)
   coef_a = -(epsilon/(n+1))*((1-lambda^(n+1))/((1-lambda^(n+1))*(1+epsilon-lambda^(n+1)) - epsilon));
   coef_b = (epsilon/(n+1))*((lambda^(n+1))/((1-lambda^(n+1))*(1+epsilon-lambda^(n+1)) - epsilon));
   
   coef_aBar = -(epsilon/(n+1))*((1-lambda_bar^(n+1))/((1-lambda_bar^(n+1))*(1+epsilon-lambda_bar^(n+1)) - epsilon));
   coef_bBar = (epsilon/(n+1))*((lambda_bar^(n+1))/((1-lambda_bar^(n+1))*(1+epsilon-lambda_bar^(n+1)) - epsilon));
   
   thisTerm = 0;
   thisTermBar = 0;
   for k = 0:(n-1)
       thisTerm = thisTerm + (k+1)*Alpha(n-k+1)*B(k+2);
       thisTermBar = thisTermBar + (k+1)*Alpha_bar(n-k+1)*B_bar(k+2);
   end
   A(n+2) = coef_a*thisTerm;
   B(n+2) = coef_b*thisTerm;

   A_bar(n+2) = coef_aBar*thisTermBar;
   B_bar(n+2) = coef_bBar*thisTermBar;
   
   thisAlphaTerm = 0;
   thisBetaTerm = 0;
   
   thisAlphaTermBar= 0;
   thisBetaTermBar = 0;
   
   for k = 0:n
       thisAlphaTerm = thisAlphaTerm + (k+1)*Beta(n-k+1)*B(k+2);
       thisBetaTerm = thisBetaTerm + (k+1)*Alpha(n-k+1)*B(k+2);
   
       thisAlphaTermBar = thisAlphaTermBar + (k+1)*Beta_bar(n-k+1)*B_bar(k+2);
       thisBetaTermBar = thisBetaTermBar + (k+1)*Alpha_bar(n-k+1)*B_bar(k+2);
   end
   Alpha(n+2) = (-1/(n+1))*thisAlphaTerm;
   Beta(n+2) = (1/(n+1))*thisBetaTerm;

   Alpha_bar(n+2) = (-1/(n+1))*thisAlphaTermBar;
   Beta_bar(n+2) = (1/(n+1))*thisBetaTermBar;
end


%Using the coefficents of the parameterization, compute the 
%stable and unstable manifolds:
t = 0;
t_minus = 0;

for i = 1:numManifoldPoints
    t = t + step;
    t_minus = t_minus - step;
    x = 0;
    theta = 0;
    x_minus = 0;
    theta_minus = 0;
    
    x_bar = 0;
    theta_bar = 0;
    x_minus_bar = 0;
    theta_minus_bar = 0;
    
    for k = 1:(order+1)
      %unstable manifold
      x = x + A(k)*t^(k-1);
      theta = theta + B(k)*t^(k-1);
      x_minus = x_minus + A(k)*(t_minus)^(k-1);
      theta_minus = theta_minus + B(k)*(t_minus)^(k-1);
  
      %stable manifold
      x_bar = x_bar + A_bar(k)*t^(k-1);
      theta_bar = theta_bar + B_bar(k)*t^(k-1);
      x_minus_bar = x_minus_bar + A_bar(k)*(t_minus)^(k-1);
      theta_minus_bar = theta_minus_bar + B_bar(k)*(t_minus)^(k-1);
    end
    P_USM(1, 1) = x;
    P_USM(1, 2) = theta;
    P_minusUSM(1, 1) = x_minus + 2*pi;
    P_minusUSM(1, 2) = theta_minus + 2*pi;
    
    P_SM(1, 1) = x_bar;
    P_SM(1, 2) = theta_bar+2*pi;
    P_minusSM(1, 1) = x_minus_bar + 2*pi;
    P_minusSM(1, 2) = theta_minus_bar;
    
    for j = 2:parmIterates
        thisImage = standardMap1(x, theta, epsilon); 
        P_USM(j, 1) = thisImage(1);
        P_USM(j, 2) = thisImage(2);        
        x = thisImage(1);
        theta = thisImage(2);
    
        thisImage_minus = standardMap1(P_minusUSM(j-1,1), P_minusUSM(j-1,2), epsilon); 
        P_minusUSM(j, 1) = thisImage_minus(1);
        P_minusUSM(j, 2) = thisImage_minus(2);        
        x_minus = thisImage_minus(1);
        theta_minus = thisImage_minus(2);
        
        thisImage_bar = inverse_standardMap(x_bar, theta_bar, epsilon); 
        P_SM(j, 1) = thisImage_bar(1);
        P_SM(j, 2) = thisImage_bar(2);        
        x_bar = thisImage_bar(1);
        theta_bar = thisImage_bar(2);
    
        thisImage_minus_bar = inverse_standardMap(P_minusSM(j-1,1), P_minusSM(j-1,2), epsilon); 
        P_minusSM(j, 1) = thisImage_minus_bar(1);
        P_minusSM(j, 2) = thisImage_minus_bar(2);        
        x_minus_bar = thisImage_minus_bar(1);
        theta_minus_bar = thisImage_minus_bar(2);
    end
    P((1+(i-1)*parmIterates):(i*parmIterates),1) = P_USM(:,1);
    P((1+(i-1)*parmIterates):(i*parmIterates),2) = P_USM(:,2);
%    PM((1+(i-1)*parmIterates):(i*parmIterates),1) = P_minusUSM(:,1);
%    PM((1+(i-1)*parmIterates):(i*parmIterates),2) = P_minusUSM(:,2);

    PS((1+(i-1)*parmIterates):(i*parmIterates),1) = P_SM(:,1);
    PS((1+(i-1)*parmIterates):(i*parmIterates),2) = P_SM(:,2);
%    PSM((1+(i-1)*parmIterates):(i*parmIterates),1) = P_minusSM(:,1);
%    PSM((1+(i-1)*parmIterates):(i*parmIterates),2) = P_minusSM(:,2);

end

%==========================================================================
%Plotting:
%==========================================================================

if plotp
  figure 
  hold on
end

%Plot Global Dynamics Sample:
%plot(0,0, 'bo', 2*pi, 0, 'bo', 0, 2*pi, 'bo', 2*pi, 2*pi, 'bo');
%plot(phasePlot(:, 1), phasePlot(:, 2), 'k.')

%Plot Parameterization of Stable Manifold:
%plot(PS(:,1), PS(:,2), 'r.');
%plot(PSM(:,1), PSM(:,2), 'y.');

%Plot Parameterization of Unstable Manifold: 
%plot(P(:,1), P(:,2), 'g.');
%plot(PM(:,1), PM(:,2), 'b.');

i = 1;
crawl = 0;

while (crawl < pi)

     crawl = P(i+1,2);
     i = i+1;
end

middle_pointx = (P(i,1)+P(i-1,1))/2;
middle_pointy = (P(i,2)+P(i-1,2))/2;
y1 = middle_pointx/(2*pi);
x1 = .5;

[x2 y2] = other_homoclinic2(middle_pointy, middle_pointx, PS(:,2), PS(:,1), P(:,2), P(:,1), epsilon);

x2 = x2/(2*pi);
y2 = y2/(2*pi);

if plotp
  plot(P([1:i],1), P([1:i],2), 'm.');
end
%axis([-0.4 2*pi*1.1 -0.4 2*pi*1.1])
