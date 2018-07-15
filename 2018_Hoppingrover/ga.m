clear;

global myInput myInputModels t_ success

myInputModels = zeros(10,302);

% �z��̍쐬
index = 0;
while index < 10
    clearvars  -except myInputModels index success
    rng('shuffle','twister')
    myInput = -5e-4 + (5e-4+5e-4)*rand(1,301)
    HRmain;
    if success == 1,
        index = index +1;
        myInputModels(index,1:301) = myInput;
        myInputModels(index,302)   = t_;
    end
end
csvwrite('./modelInput.csv',myInputModels);


nonevolution = 0;

while nonevolution < 10
    myInputModelsNew = zeros(10,302);
    times = myInputModels(:,302);
    [B, I] = sort(times);
    
    % �L�^�X�V���Ȃ������A���񐔂𐔂���
    if I(1) == 1,
        nonevolution = nonevolution + 1;
    else
        nonevolution = 0;
    end

    % �I��
    for i=5:1
        myInputModelsNew(i*2-1,:) = myInputModels(I(i));
        myInputModelsNew(i*2,:) = myInputModels(I(i));
    end
    myInputModels(:,:) = myInputModelsNew(:,:);

    % ����
    for i=10:5
        myInputModelsNew(i,1:75) = myInputModels(i*2-1,227:301);
        myInputModelsNew(i,76:301) = myInputModels(i*2-1,1:226);
    end
    for i=4:2
        myInputModelsNew(i,1:75) = myInputModels(i*2-1,227:301);
        myInputModelsNew(i,76:301) = myInputModels(i*2-1,1:226);
    end
    myInputModels(:,:) = myInputModelsNew(:,:);

    % �ˑR�ψ�
    for i = 2:10
        for j=1:5
            rng('shuffle','twister')
            index = 1+ fix(301*rand(1));
            newInput = -5e-4 + (5e-4+5e-4)*rand(1);
            myInputModels(i,index) = newInput;
        end
    end

    % ���s
    for i = 1:10
        clearvars  -except myInputModels nonevolution
        HRmain;
        if(t_ < 300),
            myInputModels(index,1:301) = myInput;
            myInputModels(index,302)   = t_;
        end
    end
end

csvwrite('./finalInputModels.csv',myInputModels);