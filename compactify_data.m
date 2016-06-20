function d = compactify_data(data,rotDir)
% get a more compact data structure to work with
% get rid of full trajectories
% store variables as a matrix, not cell array

Nsubjs = length(data);
for subj=1:Nsubjs
    d.reachDir(subj,:) = rotDir(subj)*data{subj}.reachDir;
    d.subj(subj) = subj;
    for trial=1:data{subj}.Ntrials;
        d.endPoint(subj,trial) = -rotDir(subj)*data{subj}.X{trial}(data{subj}.iEnd(trial));
    end
    d.EndX(subj,:) = rotDir(subj)*data{subj}.tFile(:,8);
    d.EndY(subj,:) = rotDir(subj)*data{subj}.tFile(:,9);
    d.Xreverse(subj,:) = rotDir(subj)*data{subj}.Xreverse;
end
d.Ntrials = 1:data{subj}.Ntrials;
%d.EndX(:,[101 202 303 504 605 ]) = [];
%d.EndY(:,[101 202 303 504 605 ]) = [];
