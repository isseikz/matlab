clear;

global myInput myInputModels t_ success tTouch


rng('shuffle','twister')
myInputModels = -1e-5 + (1e-5+1e-5)*rand(10,301);

% �z��̍쐬
for myIndex=1:10
    clearvars  -except myInputModels success myIndex
    myInput = myInputModels(myIndex,:);
    HRmain;
    if success == 1 && t_ < 300
        myInputModels(myIndex,301)   = t_;
    elseif success == 1
        myInputModels(myIndex,301)   = 300 + (posT(1)-pos(1))^2;
    else
        myInputModels(myIndex,301)   = 300 + (posT(1)-pos(1))^2 + omg^2;
    end
end

% myIndex=0;
% while myIndex <= 10
%     clearvars  -except myInputModels success myIndex
%     rng('shuffle','twister');
%     myInput = -1e-5 + (1e-5+1e-5)*rand(1,300);
%     HRmain;
%     if success == 1 && t_ < 300
%         myIndex = myIndex + 1;
%         myInputModels(myIndex,1:300) = myInput(1:300);
%         myInputModels(myIndex,301)   = t_;    
%     end
%     disp(myInput);
%     disp(myIndex);
% end

csvwrite('./firstInput.csv',myInputModels);

myInputModels = csvread('./firstInput.csv');
disp(myInputModels);

nonevolution = 0;
while nonevolution < 10        
    myInputModelsNew = zeros(10,301);
    
    % �]���֐��̏��������ɂŕ��בւ�
    cost = myInputModels(:,301);
    [B, I] = sort(cost);
    for i = 1:10
        myInputModelsNew(i,:) = myInputModels(I(i),:);
    end
    myInputModels(:,:) = myInputModelsNew(:,:);
    
    % �L�^�X�V���Ȃ������A���񐔂𐔂���
    if I(1) == 1,
        nonevolution = nonevolution + 1;
    else
        nonevolution = 0;
    end

    % �I��
    for i=1:5
        myInputModelsNew(i*2-1,:) = myInputModels(i,:);
        myInputModelsNew(i*2,:) = myInputModels(i,:);
    end
    myInputModels(:,:) = myInputModelsNew(:,:);

    % ����
    for i=1:4
        postInput(1:20) = myInputModelsNew(i*2,1:20);
        myInputModelsNew(i*2,1:20) = myInputModelsNew(i*2+1,1:20);
        myInputModelsNew(i*2+1,1:20) = postInput(1:20);
    end
    myInputModelsNew(10,1:20) = myInputModelsNew(1,1:20);
    myInputModels(:,:) = myInputModelsNew(:,:);

    % �ˑR�ψ�
    for i = 2:10
        for j=3
            rng('shuffle','twister')
            index = 1+ fix(60*rand(1));
            newInput = -1e-5 + (1e-5+1e-5)*rand(1);
            myInputModels(i,index) = newInput;
        end
    end

    % ���s
    for myIndex = 1:10
        clearvars  -except myInputModels nonevolution myIndex success
        myInput = myInputModels(myIndex,:);
        HRmain;
        close;
        if success == 1 && t_ < 300
            myInputModels(myIndex,301)   = t_;
        elseif success == 1
            myInputModels(myIndex,301)   = 300 + (posT(1)-pos(1))^2;
        else
            myInputModels(myIndex,301)   = 300 + (posT(1)-pos(1))^2 + omg^2;
        end
        disp(transpose(myInputModels(:,301)))
    end
end

csvwrite('./finalInputGA3.csv',myInputModels);