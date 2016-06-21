
clear all
groupname = 'Gain';

subjnames = {'S17','S18','S19','S20','S21','S23','S24','S25','200.240','200.243','200.248','200.249','200.299','200.300'}; % ctrl: 'S22'
blocknames = {'B1','B2','B3','B4','B5'};

rotDir = [-1 1 1 -1 -1 1 1 1 1 -1 -1 -1 1 -1]; % rotation direction


for subj=1:length(subjnames)
    data{subj} = LoadAllSubData(groupname,[subjnames{subj}],blocknames);
    data{subj}.rotDir = rotDir(subj);
end

%dlmread('C:/Users/DiedrichsenLab/Documents/Nicola/Adaptrecall/Experiment2/Data/Gain/S17/B1/tFile.tgt')

%save RecallData
%% control
groupname = 'Control';

subjnames = {'S22','200.250','200.254','200.255','200.257','200.259','200.260','200.261','200.262','200.263','200.265','200.266','200.310','200.311'}; % ctrl: 'S22'
blocknames = {'B1','B2','B3','B4','B5'};
rotDir = [1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1]; % rotation direction

for subj=1:length(subjnames)
    dataCtrl{subj} = LoadAllSubData(groupname,[subjnames{subj}],blocknames);
    dataCtrl{subj}.rotDir = rotDir(subj);
end

%save RecallControlData

%% gradual
groupname = 'Gradual';
subjnames = {'200.269','200.272','200.273','200.274','200.275','200.276','200.277','200.278','200.279','200.280','200.281','200.282','200.303','200.306'};

blocknames = {'B1','B23G','B4','B5'};
rotDir = [1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1]; % rotation direction

for subj=1:length(subjnames)
    dataGrad{subj} = LoadAllSubData(groupname,[subjnames{subj}],blocknames);
    dataGrad{subj}.rotDir = rotDir(subj);
end

%%
save RecallData_all
compactify_all

save RecallData_compact d dCtrl dGrad