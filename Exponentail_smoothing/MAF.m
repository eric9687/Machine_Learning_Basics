function y = MAF(x,n)
for j = 1 : n  %% avg from 1 to n
temp = mean(x(1:j))
end
for i = n+1 : length(x) %% the result, avg of the n numbers before one
    temp = [temp;mean(x((i-n):i))];
end
y=temp
end
