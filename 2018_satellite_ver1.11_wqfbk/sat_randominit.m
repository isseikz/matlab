global flag target_1 target_2 target_3 flag_list

q=randn(3,4);
for i=1:3
    vec(i,:) = [q(i,1:3)/sqrt(q(i,1:3)*q(i,1:3)')];
    ang(i) = q(i,4)*pi;
end
target_1 = [vec(1,:)*sin(ang(1)/2.0) cos(ang(1)/2.0)];
target_2 = [vec(2,:)*sin(ang(2)/2.0) cos(ang(2)/2.0)];
target_3 = [vec(3,:)*sin(ang(3)/2.0) cos(ang(3)/2.0)];