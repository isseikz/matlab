clear;

global myInput myInputModels t_ success

myInputModels = -5e-4 + (5e-4+5e-4)*rand(10,302);

% % 配列の作成
% for myIndex=1:10
%     clearvars  -except myInputModels success myIndex
%     myInput = myInputModels(myIndex,:);
%     HRmain;
%     if success == 1,
%         myInputModels(myIndex,302)   = t_
%     else
%         myInputModels(myIndex,302)   = 300 + transpose(pos - posT) * (pos - posT)
%     end
% end
% csvwrite('./firstInput.csv',myInputModels);

myInputModels = csvread('./firstInput.csv');
disp(myInputModels);

nonevolution = 0;
while nonevolution < 10        
    myInputModelsNew = zeros(10,302);
    
    % 評価関数の小さい順にで並べ替え
    cost = myInputModels(:,302);
    [B, I] = sort(cost);
    for i = 1:10
        myInputModelsNew(i,:) = myInputModels(I(i),:);
    end
    myInputModels(:,:) = myInputModelsNew(:,:);
    
    % 記録更新しなかった連続回数を数える
    if I(1) == 1,
        nonevolution = nonevolution + 1;
    else
        nonevolution = 0;
    end

    % 選別
    for i=1:5
        myInputModelsNew(i*2-1,:) = myInputModels(i,:);
        myInputModelsNew(i*2,:) = myInputModels(i,:);
    end
    myInputModels(:,:) = myInputModelsNew(:,:);

%     % 交叉
%     for i=5:10
%         myInputModelsNew(i,1:75) = myInputModels(i,227:301);
%         myInputModelsNew(i,76:301) = myInputModels(i,1:226);
%     end
%     for i=2:4
%         myInputModelsNew(i,70:135) = myInputModels(i,135:200);
%         myInputModelsNew(i,135:200) = myInputModels(i,70:135);
%     end
%     myInputModels(:,:) = myInputModelsNew(:,:);
    
%     % 交叉
%     for i=1:4
%         postInput(:) = myInputModelsNew(i*2,1:75);
%         myInputModelsNew(i*2,1:75) = myInputModelsNew(i*2+1,1:75);
%         myInputModelsNew(i*2+1,1:75) = postInput(:);
%     end
%     myInputModelsNew(10,1:75) = myInputModelsNew(1,1:75);
%     myInputModels(:,:) = myInputModelsNew(:,:);

    % 交叉
    for i=1:4
        postInput(1:5) = myInputModelsNew(i*2,1:5);
        myInputModelsNew(i*2,1:5) = myInputModelsNew(i*2+1,1:5);
        myInputModelsNew(i*2+1,1:5) = postInput(1:5);
    end
    for i=1:4
        postInput(1:6) = myInputModelsNew(i*2,295:300);
        myInputModelsNew(i*2,295:300) = myInputModelsNew(i*2+1,295:300);
        myInputModelsNew(i*2+1,295:300) = postInput(1:6);
    end
    for i=1:4
        postInput(1:95) = myInputModelsNew(i*2,6:100);
        myInputModelsNew(i*2,6:100) = myInputModelsNew(i*2+1,6:100);
        myInputModelsNew(i*2+1,6:100) = postInput(1:95);
    end
    myInputModelsNew(10,1:75) = myInputModelsNew(1,1:75);
    myInputModels(:,:) = myInputModelsNew(:,:);

    % 突然変異
    for i = 2:10
        for j=1
            rng('shuffle','twister')
            index = 1+ fix(20*rand(1));
            newInput = -5e-4 + (5e-4+5e-4)*rand(1);
            myInputModels(i,index) = newInput;
        end
    end
    for i = 2:10
        for j=1
            rng('shuffle','twister')
            index = 280+ fix(20*rand(1));
            newInput = -5e-4 + (5e-4+5e-4)*rand(1);
            myInputModels(i,index) = newInput;
        end
    end
    for i = 2:10
        for j=13
            rng('shuffle','twister')
            index = 20+ fix(260*rand(1));
            newInput = -5e-4 + (5e-4+5e-4)*rand(1);
            myInputModels(i,index) = newInput;
        end
    end

    % 試行
    for myIndex = 1:10
        clearvars  -except myInputModels nonevolution myIndex success
        myInput = myInputModels(myIndex,:);
        HRmain;
        if success == 1,
            myInputModels(myIndex,302)   = t_;
        else
%             myInputModels(myIndex,302)   = 300 + transpose((pos - posT)/0.5) * ((pos - posT)/0.5) + (omg)^2 + mod(the,(2*pi))^2;
            myInputModels(myIndex,302)   = 300 + transpose((pos - posT)/0.5) * ((pos - posT)/0.5);
        end
        disp(transpose(myInputModels(:,302)))
    end
end

csvwrite('./finalInputModels2.csv',myInputModels);