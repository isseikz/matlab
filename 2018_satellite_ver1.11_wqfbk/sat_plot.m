y1 = x_list(1:3,:);
y2 = x_list(4:7,:);
y3 = x_list(8:10,:);
scnsize = get(0,'ScreenSize');
% �O���t�̈ʒu����
pos1 = [0 0 scnsize(3)/3 scnsize(4)/2];
pos2 = [scnsize(3)/3 0 scnsize(3)/3 scnsize(4)/2];
pos3 = [scnsize(3)*2/3 0 scnsize(3)/3 scnsize(4)/2];
% �O���t1�@�p���x
fig1 = figure(1);
set(fig1,'OuterPosition',pos1)
plot(t_list,y1);
legend('��x','��y','��xz');
% �O���t2�@�N�H�[�^�j�I��
fig2 = figure(2);
set(fig2,'OuterPosition',pos2)
plot(t_list,y2);
legend('q1','q2','q3','q4');
% �O���t3�@�g���N
fig3 = figure(3);
set(fig3,'OuterPosition',pos3)
plot(t_list,y3);
legend('t1','t2','t3');