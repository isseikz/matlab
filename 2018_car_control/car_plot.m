y1 = x_list(1:5,:);
y2 = x_list(6:7,:);
scnsize = get(0,'ScreenSize');
pos3 = [scnsize(3)/6 0 scnsize(3)/3 scnsize(4)/2];
pos4 = [scnsize(3)/2 0 scnsize(3)/3 scnsize(4)/2];
fig3 = figure(3);
set(fig3,'OuterPosition',pos3)
plot(t_list,y1);
legend('x','y','theta','v','phi',0);
fig4 = figure(4);
set(fig4,'OuterPosition',pos4)
plot(t_list,y2);
legend('accel','delta',0);