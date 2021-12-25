plot(data,'y')
hold on
ma= MAF(data,5) %% the results when N=5
plot(ma,'g')
mb= MAF(data,30)%% the results when N=30
plot(mb,'r')
xlabel('time £º 30s')
xlim([-200,3000])
ylabel('Traffic £º vehicles / hour')
title('Highway Traffic Flow (Moving average filtered)')
grid
legend('Original data','N=5','N=30');
hold off