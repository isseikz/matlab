function [] = sat_evaluate
%UNTITLED この関数の概要をここに記述
%   詳細説明をここに記述
%sat_evaluate ver1.1 2017_0701

    global t x 
    global casenumber
    global flag target_1 target_2 target_3
    global rb pb yb 

    %許容誤差の設定
    evaluate_value=0.0003;

    x_c = quat_euler(x(4:7));
    
    switch flag
        
        case 1
           targ = quat_euler(target_1);
           
        case 2
           targ = quat_euler(target_2);
           
        case 3
           targ = quat_euler(target_3);
    end
    
    T = x_c - targ;
    r=T(1);
    p=T(2);
    y=T(3);
    
   if t==0.0
        rb = 0;
        pb = 0;
        yb = 0;
   end
   
   %最小時間 casenumber==1
   %最小エネルギー casenumber==2
    switch casenumber 
        case 1
            e=r^2+p^2+y^2;
            if e < evaluate_value
                flag = flag + 1;
            
            elseif e <10*evaluate_value 
                    D=-(r*rb-2*rb+p*pb-2*pb+y*yb-2*rb)^2/(r^2-r+rb-rb^2+p^2-p*pb-pb^2+y^2-y*yb-yb^2);
                    if D>0 && D<1 && (r^2-r+rb-rb^2+p^2-p*pb-pb^2+y^2-y*yb-yb^2)>0 && D+(rb^2+pb^2+yb^2)<evaluate_value
                             flag = flag + 1;
                    end
            end           
        case 2
            e=r^2+p^2+y^2;
            if e < evaluate_value
                    flag = flag + 1;
            end  
    end
    rb=r;
    pb=p;
    yb=y;
end
    
    function euler = quat_euler(q)

% q = [t(1)*sin(t(4)/2);
%     t(2)*sin(t(4)/2);
%     t(3)*sin(t(4)/2);
%     cos(t(4)/2)];

%クオータニオンから方向余弦行列
dcm = [1-2*(q(2)^2+q(3)^2)     2*(q(1)*q(2)+q(3)*q(4)) 2*(q(1)*q(3)-q(2)*q(4));
       2*(q(1)*q(2)-q(3)*q(4)) 1-2*(q(1)^2+q(3)^2)     2*(q(2)*q(3)+q(1)*q(4));
       2*(q(2)*q(4)+q(1)*q(3)) 2*(q(2)*q(3)-q(1)*q(4)) 1-2*(q(1)^2+q(2)^2)];
     

%方向余弦行列からオイラー角(Z-Y-X)
 euler = [atan2(dcm(2,3),dcm(3,3));
          atan2(-dcm(1,3),sqrt(dcm(2,3)^2+dcm(3,3)^2));
          atan2(dcm(1,2),dcm(1,1))];

    end
