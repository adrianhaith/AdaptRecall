function d = compactify_data(data)
% get a more compact data structure to work with
% get rid of full trajectories
% store variables as a matrix, not cell array

Nsubjs = length(data);
for subj=1:Nsubjs
    d.reachDir(subj,:) = data{subj}.rotDir*data{subj}.reachDir;
    d.subj(subj) = subj;
    for trial=1:data{subj}.Ntrials;
        d.endPoint(subj,trial) = -data{subj}.rotDir*data{subj}.X{trial}(data{subj}.iEnd(trial));       
    end
    d.EndX(subj,:) = data{subj}.rotDir*data{subj}.tFile(:,8);
    d.EndY(subj,:) = data{subj}.rotDir*data{subj}.tFile(:,9);
    d.Xreverse(subj,:) = -data{subj}.rotDir*data{subj}.Xreverse;
    d.Yreverse(subj,:) = -data{subj}.rotDir*data{subj}.Yreverse;
    d.rotDir(subj) = data{subj}.rotDir;
end
d.reverseAngle = atan2(d.Yreverse,d.Xreverse)*180/pi;
d.Ntrials = 1:data{subj}.Ntrials;
%d.EndX(:,[101 202 303 504 605 ]) = [];
%d.EndY(:,[101 202 303 504 605 ]) = [];
