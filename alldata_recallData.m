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

        % actual seen endpoints
for s=1:length(subjnames)
    for i=1:data{s}.Ntrials
        dist = sqrt(data{s}.X{i}.^2+data{s}.Y{i}.^2);
        [maxDist ii] = max(dist);
        data{s}.endX = data{s}.X{i}(ii);
        data{s}.endY = data{s}.Y{i}(ii);
        d.Xend(s,i) = data{s}.endX;
        d.Yend(s,i) = data{s}.endY;
    end
end


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

        % actual seen endpoints
for s=1:length(subjnames)
    for i=1:dataCtrl{s}.Ntrials
        dist = sqrt(dataCtrl{s}.X{i}.^2+dataCtrl{s}.Y{i}.^2);
        [maxDist ii] = max(dist);
        dataCtrl{s}.endX = dataCtrl{s}.X{i}(ii);
        dataCtrl{s}.endY = dataCtrl{s}.Y{i}(ii);
        dCtrl.Xend(s,i) = dataCtrl{s}.endX;
        dCtrl.Yend(s,i) = dataCtrl{s}.endY;
    end
end


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

        % actual seen endpoints
for s=1:length(subjnames)
    for i=1:dataGrad{s}.Ntrials
        dist = sqrt(dataGrad{s}.X{i}.^2+dataGrad{s}.Y{i}.^2);
        [maxDist ii] = max(dist);
        dataGrad{s}.endX = dataGrad{s}.X{i}(ii);
        dataGrad{s}.endY = dataGrad{s}.Y{i}(ii);
        dGrad.Xend(s,i) = dataGrad{s}.endX;
        dGrad.Yend(s,i) = dataGrad{s}.endY;
    end
end

blklengths = [100 100 100 200 100];
blkends = cumsum(blklengths);

% only save the 'd' structures, not 'data' ones - they are massive since they
% contain all the trajectories for each trial. 'd' is a compact summary.
save adaptrecall_alldat d dCtrl dGrad