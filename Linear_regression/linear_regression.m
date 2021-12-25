% Linear Regression function
function linear_regression(data,alpha)
data = data'; %making tranposition matrix
[c,d] = size(data);
length = d;

%average of data x,y
xavg = mean(data(2,:)); 
yavg = mean(data(1,:));

% linear regression parameter
lxx=(data(2,:)-xavg)*(data(2,:)-xavg)';
lxy=(data(2,:)-xavg)*(data(1,:)-yavg)';
lyy=(data(1,:)-yavg)*(data(1,:)-yavg)';
b=lxy/lxx;
a=yavg-b*xavg;

if b>0
    sprintf('linear_regression_equation: y = %f + %f*x',a,b)
else
    sprintf('linear_regression_equation: y = %f%f*x',a,b)
end

%Testing Linearity
ESS = b*lxy; % ESS
RSS = lyy -ESS; % RSS
F = (length-2)*ESS/RSS; % F equation
Fa = finv(1-alpha , 1 , length-2); 
sprintf('F=%f,Fa=%f',F,Fa)
if F > Fa
S_delta = sqrt( RSS/( length-2 ) );
Z_half_a = norminv(1-alpha/2,0,1); %standard normal distribution"1-alpha/2"
sprintf('It is linear£¬Confidence interval:(y0 -%f , y0 + %f)',Z_half_a*S_delta,Z_half_a*S_delta)%linearity & Confidence interval
%Figure
plot(data(2,:),data(1,:),'o'); %origin data
hold on; 
h1=refline(b,a); %Red line - Linear Regression
set(h1,'color','r');
h2=refline(b,a-Z_half_a*S_delta); %Green line - Confidence Interval
h3=refline(b,a+Z_half_a*S_delta);
set(h2,'color','g','LineStyle','--');
set(h3,'color','g','LineStyle','--');

xlabel('x');
ylabel('y');
title('Contents of Ingredient and Linear Regression');
legend('data','inear Regression','Confidence interval','Confidence interval','Location','NorthEast');
else
sprintf('It is not linear')
end
end




