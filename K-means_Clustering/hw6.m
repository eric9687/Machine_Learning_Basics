data= importdata('data.mat');
close all;
%%get optimal the number of k cluster
% result shows on first figure
sse_cpr=zeros(29,1);
sse_num=zeros(29,1);
for i=2:30
    [~,a,~,~]=kmeans_clustering(data,i,2);
    sse_cpr(i)=a;
    sse_num(i)=i;   
end
figure('Name','Elbow method to get optimal K');
plot(sse_num,sse_cpr)
axis([0 30 0 35000])
xticks([2 3 4 5 6 7 8 9 10 12 20 25 30])
xticklabels({'2','3','4','5','6','7','8','9','10','......','20','25','30'})
grid on;
xlabel('the number of K')
ylabel('sse')


%do k-means clustering method when knum =7 
% result shows on second figure
knum = 7;
kmeans_clustering(data,knum,1);


%Observe the influence of iniatial centroid on iteration times
% result shows on third figure
std_num=zeros(50,1);
iteration_result=zeros(50,1);  
for i= 1:50
knum = 7;
[~,~,a,b]=kmeans_clustering(data,knum,3);    
fprintf("Standard deviation of initial Centroid: %.3f \n",a)
fprintf("Iteration times : %d \n",b)  
std_num(i)=a;
iteration_result(i)=b;
end
figure('Name','the influence of iniatial centroid on iteration times');
plot(std_num,iteration_result,'*');
xlabel('standard deviation of initial centroid')
ylabel('Iteration times')



% Observe the influence of data size on the operating duration
% result shows on fourth figure
t = zeros(1,299);
x=10;
for n = 1:299
   new_data=data(1:x,:);
    tic;
    kmeans_clustering(new_data,7,4)
    t(n) = toc;
    x=x+10;
end
figure('Name','the influence of data size on the operating duration');
plot(t);
xlabel('data size')
ylabel('Operating duration')









