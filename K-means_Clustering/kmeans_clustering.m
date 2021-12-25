function [label,sse,std_Init,iteration] = kmeans_clustering(data, k,setting)
%Input:
%      data: the x,y data
%      k: the number of clusters
%      setting: 1 - show the cluster result
%               2 - get sse for optimal the number of k cluster
%               3 - get standard deviation of initial Centroid & iteration
%                   times
%               4 - just for checking operatinf time

%set variables
x=data(:,1);
y=data(:,2);
label=0;
sse=0;
j = 1;
iteration=0;  %iteration times
centerX = zeros(1,k);
centerY = zeros(1,k);
InitialC_X = zeros(1,k);
InitialC_Y = zeros(1,k);
oldcenterX = zeros(1,k);
oldcenterY = zeros(1,k);
resX = zeros(k,length(x)); % data in each cluster
resY = zeros(k,length(x));
clunum = zeros(1,k); 

%choose the Initial centroid among data
for i = 1:k 
    centerX(i) = x(randperm(length(x),1));
    centerY(i) = y(randperm(length(x),1));
    %prevent initial centroids overlapped
    if (i > 1 && centerX(i) == centerX(i-1) && centerY(i) == centerY(i-1))
        i = i -1; 
    end
    InitialC_X(i)=centerX(i);
    InitialC_Y(i)=centerY(i);
end

%Update the new centroid until it doesnt move anymore
while 1
    clunum(:) = 0; 
    resX(:) = 0;
    resY(:) = 0;
    
    %set the cluster of each data by Euclid distance 
    for i = 1:length(x) 
        cluster = 1;
        for j = 2:k
            if (power(x(i)-centerX(cluster),2)+power(y(i)-centerY(cluster),2))... 
                > (power(x(i)-centerX(j),2) + power(y(i)-centerY(j),2))
                cluster = j;
            end
        end
        
        % the output [label] means the cluster of the N data (N=length(x)) 
        if i== length(x)
            label = cluster;
        end
        
        resX(cluster,clunum(cluster)+1) = x(i);
        resY(cluster,clunum(cluster)+1) = y(i);
        clunum(cluster) = clunum(cluster) + 1;
    end
    %change centroid
    oldcenterX = centerX;
    oldcenterY = centerY;

    for i = 1:k
        if clunum(i) == 0
            continue;
        end
        centerX(i) = sum(resX(i,:))/clunum(i);
        centerY(i) = sum(resY(i,:))/clunum(i);
    end

    %stop iteration when the centroids stop changing
    if mean([centerX == oldcenterX centerY == oldcenterY]) == 1
        break;
    end
    iteration=iteration+1;
end
    
    maxPos = max(clunum);
    resX = resX(:,1:maxPos);
    resY = resY(:,1:maxPos);

%show k-means clustering method when knum =7 
    if setting ==1
        figure('Name','k-means clustering result');
        for i = 1:k
        plot(resX(i,1:clunum(i)),resY(i,1:clunum(i)),'*')
        hold on;
        end
        plot(centerX,centerY,'Marker','square','Color','k','MarkerFaceColor','k','LineStyle','none')
        title(["iteration:",iteration,"times"]);
    end
    
    %%get optimal the number of k cluster    
    if setting ==2
    for i=1:k
        for j= 1:clunum(i)
        sse = sse + power(resX(i,j)-centerX(i),2)+power(resY(i,j)-centerY(i),2);
        end
    end
    end
    
    %get the standard deviation of initial Centroid
    std_Init= sqrt(power(std(InitialC_X),2)+power(std(InitialC_Y),2));
    
end


