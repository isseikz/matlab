sthe = sin(x(3));
cthe = cos(x(3));
sfai = sin(x(3)+x(5));
cfai = cos(x(3)+x(5));
k = linspace(0,2*pi,100);
tgpoint = [tgx tgy];
tgr = 0.5;
cpointx = x(1)+length/2*cthe;
cpointy = x(2)+length/2*sthe;
cpoint = [cpointx cpointy];
cr = length/2;
ccr = length/16;

fig1 = figure(1);
set(fig1,'OuterPosition',pos1)
clf(fig1);
ax1 = [x(1)-2*length x(1)+2*length x(2)-2*length x(2)+2*length];
rearcx = [x(1)-length/3*sthe x(1)+length/3*sthe];
rearlx = [rearcx(1)+length/12*cthe rearcx(1)-length/12*cthe];
rearrx = [rearcx(2)+length/12*cthe rearcx(2)-length/12*cthe];
rearcy = [x(2)+length/3*cthe x(2)-length/3*cthe];
rearly = [rearcy(1)+length/12*sthe rearcy(1)-length/12*sthe];
rearry = [rearcy(2)+length/12*sthe rearcy(2)-length/12*sthe];
frontcx = [x(1)+length*cthe-length/3*sfai x(1)+length*cthe+length/3*sfai];
frontlx = [frontcx(1)+length/12*cfai frontcx(1)-length/12*cfai];
frontrx = [frontcx(2)+length/12*cfai frontcx(2)-length/12*cfai];
frontcy = [x(2)+length*sthe+length/3*cfai x(2)+length*sthe-length/3*cfai];
frontly = [frontcy(1)+length/12*sfai frontcy(1)-length/12*sfai];
frontry = [frontcy(2)+length/12*sfai frontcy(2)-length/12*sfai];
carx = [rearcx(1)-length/4*cthe rearcx(2)-length/4*cthe rearcx(2)+5*length/4*cthe rearcx(1)+5*length/4*cthe];
cary = [rearcy(1)-length/4*sthe rearcy(2)-length/4*sthe rearcy(2)+5*length/4*sthe rearcy(1)+5*length/4*sthe];
carfx = [rearcx(2)+5*length/4*cthe rearcx(1)+5*length/4*cthe x(1)+11*length/8*cthe];
carfy = [rearcy(2)+5*length/4*sthe rearcy(1)+5*length/4*sthe x(2)+11*length/8*sthe];
plot([-100 100],[0 0],'-b'); hold on
plot([0 0],[-100 100],'-b');
patch(carx,cary,'w'); patch(carfx,carfy,'k');
patch(rearcx,rearcy,'k','LineWidth',3); patch(rearlx,rearly,'k','LineWidth',3); patch(rearrx,rearry,'k','LineWidth',3);
patch(frontcx,frontcy,'k','LineWidth',3); patch(frontlx,frontly,'k','LineWidth',3); patch(frontrx,frontry,'k','LineWidth',3);
patch(tgr*sin(k)+tgpoint(1),tgr*cos(k)+tgpoint(2),'y'); hold on
patch(ccr*sin(k)+cpoint(1),ccr*cos(k)+cpoint(2),'b');
vecc = [x(1)+3*length/2 x(2)+3*length/2];
if cpointx>=0
    vecang = atan((x(2)+length/2*sthe)/(x(1)+length/2*cthe));
else
    vecang = atan((x(2)+length/2*sthe)/(x(1)+length/2*cthe))+pi;
end
vecx1 = vecc(1); vecx2 = vecx1-3*cos(vecang)/4;
vecx3 = vecc(1)+cos(vecang+pi/6)/2; vecx4 = vecx3-3*cos(vecang)/4;
vecx5 = vecc(1)+cos(vecang-pi/6)/2; vecx6 = vecx5-3*cos(vecang)/4;
vecy1 = vecc(2); vecy2 = vecy1-3*sin(vecang)/4;
vecy3 = vecc(2)+sin(vecang+pi/6)/2; vecy4 = vecy3-3*sin(vecang)/4;
vecy5 = vecc(2)+sin(vecang-pi/6)/2; vecy6 = vecy5-3*sin(vecang)/4;
vecx = [vecx1 vecx3 vecx4 vecx2 vecx6 vecx5];
vecy = [vecy1 vecy3 vecy4 vecy2 vecy6 vecy5];
patch(vecx,vecy,'m');
grid on
xlabel('x [m]'); ylabel('y [m]');
axis([ax1(1) ax1(2) ax1(3) ax1(4)])
axis equal
axis manual;

fig2 = figure(2);
set(fig2,'OuterPosition',pos2)
clf(fig2);
ax2 = 100;
plot([-100 100],[0 0],'-b'); hold on
plot([0 0],[-100 100],'-b');
patch(cr*sin(k)+cpoint(1),cr*cos(k)+cpoint(2),'w');
patch(tgr*sin(k)+tgpoint(1),tgr*cos(k)+tgpoint(2),'y');
patch(ccr*sin(k)+cpoint(1),ccr*cos(k)+cpoint(2),'b');
grid on
xlabel('x [m]'); ylabel('y [m]');
axis([-ax2 ax2 -ax2 ax2])
axis equal
axis manual
