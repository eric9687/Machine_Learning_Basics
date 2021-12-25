
function ans = exps(x,alpha) %% Exponential smoothing function 
for i = 1 : 1 : length(x)
    if i ==1
        ans(i)=(x(1)+x(2)+x(3))/3
    else
        ans(i)= alpha*x(i)+(1-alpha)*ans(i-1)
    end
end
