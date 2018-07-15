
%オイラー角→クオータニオン変換(配列生成)
loop_n = round(t*100);

for loop_i = 1:loop_n
    euler(1,loop_i)   = atan2((2*(y2(4,loop_i)*y2(1,loop_i))+(y2(2,loop_i)*y2(3,loop_i))),(1-2*((y2(1,loop_i)*y2(1,loop_i))+(y2(2,loop_i)*y2(2,loop_i)))));
    euler(2,loop_i) = asin(2*((y2(4,loop_i)*y2(2,loop_i))-(y2(3,loop_i)*y2(1,loop_i))));
    euler(3,loop_i)   = atan2((2*(y2(4,loop_i)*y2(3,loop_i))+(y2(1,loop_i)*y2(2,loop_i))),(1-2*((y2(2,loop_i)*y2(2,loop_i))+(y2(3,loop_i)*y2(3,loop_i)))));
end

%衛星モデルの定義
Lx = 0.20;Ly = 0.20;Lz = 0.20;  %衛星サイズ

%%%%%%%%%%%%%%
% Motion data→回転に関する設定
t = t_list';       % Time data
r = [0*t, 0*t, 0*t];    % Position data
%A = [euler(1,1:2000),euler(2,1:2000),euler(3,1:2000)]'; % Orientation data (x-y-z Euler angle)
A=euler';

n_time = length(t);

ax1 = zeros(n_time+1,3);
ax2 = zeros(n_time+1,3);
ax3 = zeros(n_time+1,3);

% Compute propagation of vertices and patches
for i_time=1:n_time
    R = Euler2R(A(i_time,:));
    
    VertexData(:,:,i_time) = GeoVerMakeBlock(r(i_time,:),R,[Lx,Ly,Lz]);
    VertexData2(:,:,i_time) = GeoVerMakeBlock2(r(i_time,:),R,[Lx,Ly,Lz]);
        
    [X,Y,Z] = GeoPatMakeBlock(VertexData(:,:,i_time));
    [XX,YY,ZZ] = GeoPatMakeBlock2(VertexData2(:,:,i_time));
    PatchData_X(:,:,i_time) = X;    PatchData_XX(:,:,i_time) = XX;
    PatchData_Y(:,:,i_time) = Y;    PatchData_YY(:,:,i_time) = YY;
    PatchData_Z(:,:,i_time) = Z;    PatchData_ZZ(:,:,i_time) = ZZ;
    
    e1 = [0,0,0.3]; ax1(i_time,:) = e1*R';
    e2 = [0.3,0,0]; ax2(i_time,:) = e2*R';
    e3 = [0,0.3,0]; ax3(i_time,:) = e3*R';
end

%%%%%%%%%%%%%%%%%%%
%%% Draw initial figure
figure(4);clf

%sat drawing
h = patch(PatchData_X(:,:,1),PatchData_Y(:,:,1),PatchData_Z(:,:,1),'y');
hold on;
hh = patch(PatchData_XX(:,:,1),PatchData_YY(:,:,1),PatchData_ZZ(:,:,1),'r');
hold on;

set(h,'FaceLighting','phong','EdgeLighting','phong','EraseMode','normal');
set(hh,'FaceColor','red');

% space_axes settings
xlabel('x','FontSize',14);
ylabel('y','FontSize',14);
zlabel('z','FontSize',14);
set(gca,'FontSize',14);
axis vis3d equal;

xlim([-0.5,0.5]);
ylim([-0.5,0.5]);
zlim([-0.5,0.5]);

view([-37.5,30]);
camlight;
grid on;
axis on;

% annotation
dim = [0.1 0.75 0.2 0.15];
str = {['case:',num2str(casenumber)],['flag:',num2str(flag_list(i_time))],['time=',num2str(t_list(i_time))]};
an = annotation('textbox',dim,'String',str,'FitBoxToText','off','FontSize',14);

% fixed_axes
qx = quiver3(0,0,0,Lx*2.0,0,0,'k'); 
qy = quiver3(0,0,0,0,Ly*2.0,0,'k'); 
qz = quiver3(0,0,0,0,0,Lz*2.0,'k');
text(Lx*2.0,0,0,'Roll');             
text(0,Ly*2.0,0,'Pitch');
text(0,0,Lz*2.0,'Yaw');
set(qx,'LineStyle','--');
set(qy,'LineStyle','--');
set(qz,'LineStyle','--');

% body_axis
p1 = quiver3(0,0,0,ax1(1,1),ax1(1,2),ax1(1,3),'k','Linewidth',1.5);
hold on
p2 = quiver3(0,0,0,ax2(1,1),ax2(1,2),ax2(1,3),'k','Linewidth',1.5);
hold on
p3 = quiver3(0,0,0,ax3(1,1),ax3(1,2),ax3(1,3),'k','Linewidth',1.5);
hold on

% Animation Loop
for i_time=1:n_time
    set(h,'XData',PatchData_X(:,:,i_time));
    set(h,'YData',PatchData_Y(:,:,i_time));
    set(h,'ZData',PatchData_Z(:,:,i_time));
    set(hh,'XData',PatchData_XX(:,:,i_time));
    set(hh,'YData',PatchData_YY(:,:,i_time));
    set(hh,'ZData',PatchData_ZZ(:,:,i_time));
    
    str = {['case:',num2str(casenumber)],['flag=',num2str(flag_list(i_time))],['time=',num2str(t_list(i_time))]};
    set(an,'String',str);
    
    if rem(i_time,5)==1
       set(p1,'UData',ax1(i_time,1),'VData',ax1(i_time,2),'WData',ax1(i_time,3))
       set(p2,'UData',ax2(i_time,1),'VData',ax2(i_time,2),'WData',ax2(i_time,3))
       set(p3,'UData',ax3(i_time,1),'VData',ax3(i_time,2),'WData',ax3(i_time,3))
    else
    end    
    
    drawnow;
end
