%% recall data summary
clear all

load RecallData

for subj=1:length(subjnames)
    d.reachDir(subj,:) = rotDir(subj)*data{subj}.reachDir;
    d.subj(subj) = subj;
    for trial=1:data{subj}.Ntrials;
        d.endPoint(subj,trial) = -rotDir(subj)*data{subj}.X{trial}(data{subj}.iEnd(trial));
    end
    
    d.EndX(subj,:) = rotDir(subj)*data{subj}.tFile(:,8);

    d.EndY(subj,:) = rotDir(subj)*data{subj}.tFile(:,9);

end
d.Ntrials = 1:data{subj}.Ntrials;
    d.EndX(:,[101 202 303 504 605 ]) = [];
    d.EndY(:,[101 202 303 504 605 ]) = [];
       
load RecallControlData
for subj=1:length(subjnames)
    
    dCtrl.reachDir(subj,:) = rotDir(subj)*dataCtrl{subj}.reachDir;
    dCtrl.subj(subj) = subj;
    for trial=1:dataCtrl{subj}.Ntrials;
        dCtrl.endPoint(subj,trial) = -rotDir(subj)*dataCtrl{subj}.X{trial}(dataCtrl{subj}.iEnd(trial));
    end
    dCtrl.EndX(subj,:) = rotDir(subj)*dataCtrl{subj}.tFile(:,8);
    dCtrl.EndY(subj,:) = rotDir(subj)*dataCtrl{subj}.tFile(:,9);
end
dCtrl.Ntrials = 1:dataCtrl{subj}.Ntrials;
dCtrl.EndX(:,[101 202 303 504 605 ]) = [];
dCtrl.EndY(:,[101 202 303 504 605 ]) = [];

load RecallGradualData
for subj=1:length(subjnames)
    dGrad.subj(subj) = subj;
    dGrad.reachDir(subj,:) = rotDir(subj)*dataGrad{subj}.reachDir;
    for trial=1:dataGrad{subj}.Ntrials;
        dGrad.endPoint(subj,trial) = -rotDir(subj)*dataGrad{subj}.X{trial}(dataGrad{subj}.iEnd(trial));
    end
    dGrad.EndX(subj,:) = rotDir(subj)*dataGrad{subj}.tFile(:,8);
    dGrad.EndY(subj,:) = rotDir(subj)*dataGrad{subj}.tFile(:,9);
end
dGrad.Ntrials = 1:dataGrad{subj}.Ntrials;
dGrad.EndX(:,[101 302 503 604 ]) = [];
dGrad.EndY(:,[101 302 503 604 ]) = [];

blklengths = [100 100 100 200 100];
blkends = cumsum(blklengths);
    
clear data
clear dataCtrl
clear dataGrad
save('adaptrecall_alldat.mat')








