
clear all
groupname = 'Gain';

subjnames = {'S17','S18','S19','S20','S21','S23','S24','S25','200.240','200.243','200.248','200.249','200.299','200.300'}; % ctrl: 'S22'
blocknames = {'B1','B2','B3','B4','B5'};

rotDir = [-1 1 1 -1 -1 1 1 1 1 -1 -1 -1 1 -1]; % rotation direction


for subj=1:length(subjnames)
    data{subj} = LoadAllSubData(groupname,[subjnames{subj}],blocknames);
end

%dlmread('C:/Users/DiedrichsenLab/Documents/Nicola/Adaptrecall/Experiment2/Data/Gain/S17/B1/tFile.tgt')

save RecallData
%% control
groupname = 'Control';

subjnames = {'S22','200.250','200.254','200.255','200.257','200.259','200.260','200.261','200.262','200.263','200.265','200.266','200.310','200.311'}; % ctrl: 'S22'
blocknames = {'B1','B2','B3','B4','B5'};
rotDir = [1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1]; % rotation direction

for subj=1:length(subjnames)
    dataCtrl{subj} = LoadAllSubData(groupname,[subjnames{subj}],blocknames);
end

save RecallControlData

%% gradual
groupname = 'Gradual';
subjnames = {'200.269','200.272','200.273','200.274','200.275','200.276','200.277','200.278','200.279','200.280','200.281','200.282','200.303','200.306'};

blocknames = {'B1','B23G','B4','B5'};
rotDir = [1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1]; % rotation direction

for subj=1:length(subjnames)
    dataGrad{subj} = LoadAllSubData(groupname,[subjnames{subj}],blocknames);
end

save RecallGradualData

%%
%{
f = 1;

s= [ 1 2 3 4 5];

for j = 1
    for t = 1:length(s)
        
        figure(3); hold on
        
        plot([f:f+length(data{j,t}.reachDir)-1],-(endposition_hand(j,1:length(data{j,t}.reachDir),t)),'.','color',.8*[0 0 1])
        
        f = f+length(data{j,t}.reachDir);
        
        
    end
end
xlabel('Trial')
ylabel('Endposition-X')

plot([0 604],[0 0],'k-');
plot([101 101],[-60 60],'k-');
plot([202 202],[-60 60],'k-');
plot([303 303],[-60 60],'k-');
plot([353 353],[-60 60],'k--');
plot([503 503],[-60 60],'k-');

axis([ 0 605 -0.15 0.15]);
f = 1;

s= [ 1 2 3 4 5];
for t = 1:length(s)
    for j = 1
        
        
        figure(1); hold on
        
        plot([f:f+length(data{j,t}.reachDir)-1],data{j,t}.reachDir,'.','color',.8*[1 0 0])
        
        
        f = f+length(data{j,t}.reachDir);
        
        
        
    end
end
xlabel('Trial')
ylabel('Reach Dir')
axis([ 0 605 -80 80]);

plot([0 604],[0 0],'k-');
plot([101 101],[-60 60],'k-');
plot([202 202],[-60 60],'k-');
plot([303 303],[-60 60],'k-');
plot([353 353],[-60 60],'k--');
plot([503 503],[-60 60],'k-');



endposition_hand_y = [];
for i=1:length(subjnames)
    for k=1:length(blocknames)
        for trials = 1:length(data{i,k}.reachDir)
            if isnan(data{i,k}.iEnd(trials))
                endposition_hand_y(i,trials,k) = NaN;
            else
                endposition_hand_y(i,trials,k) = (data{i,k}.Y{trials}(data{i,k}.iEnd(trials))) ;
                
                
            end
            
            
        end
    end
end
endposition_hand_y_cursor = [];
endposition_hand_x_cursor = [];
for i=1:length(subjnames)
    for k=1:length(blocknames)
        for trials = 1:length(data{i,k}.reachDir)
            
            if k == 4
                endposition_hand_x_cursor(i,:,4) = data{i,4}.tFile(:,7);
                endposition_hand_y_cursor(i,trials,4) = (sqrt((endposition_hand(i,trials,k)^2) + (endposition_hand_y(i,trials,k)^2))*0.6);
                
            end
        end
    end
end


success = [];
for i=1:length(subjnames)
    for k=1:length(blocknames)
        for trials = 1:length(endposition_hand(i,:,k))
            if k == 4
                if (endposition_hand_x_cursor(i,trials,k) <=0.005) & (endposition_hand_x_cursor(i,trials,k) >=(-0.005));
                    if (endposition_hand_y_cursor(i,trials,k) <=0.105) & (endposition_hand_y_cursor(i,trials,k)  >=0.095);
                        
                        
                        success(i,trials,k) = 1;
                    else
                        success(i,trials,k) = 0;
                    end
                else
                    success(i,trials,k) = 0;
                end
            else
                if (endposition_hand(i,trials,k) <=0.005) & (endposition_hand(i,trials,k) >=(-0.005));
                    if (endposition_hand_y(i,trials,k) <=0.105) & (endposition_hand_y(i,trials,k)  >=0.095);
                        success(i,trials,k) = 1;
                    else
                        success(i,trials,k) = 0;
                    end
                else
                    success(i,trials,k) = 0;
                end
                
                
            end
        end
    end
end
for k = 1:length(blocknames)
    Amount_of_Ones(i,k) = (nnz(success(i,:,k)));
    RatioCorrect(i,k) = (nnz(success(i,:,k))/length(data{i,k}.reachDir));
end
save testData data
%}