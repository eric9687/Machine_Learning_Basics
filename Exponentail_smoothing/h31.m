plot(data,'y');
hold on
plot(exps(data,0.2),'r') %% "exps"is a function, Exponential smoothing.
plot(exps(data,0.05),'g')
xlabel('time £º 30s')
xlim([-200,3000])
ylabel('Traffic £º vehicles / hour')
title('Highway Traffic Flow (Exponential smoothing)')
grid
legend('Original data','N=0.2','N=0.05');
hold off
