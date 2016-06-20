function [data] = LoadAllSubData(groupname,subjname,blocknames)

Nblocks = length(blocknames);
trial = 1;
tFileFull = [];

for blk=1:Nblocks
    %disp(['Subject ',subjname,', ','Block: ',blocknames(blk)]);
    path = ['../Data/',groupname,'/',subjname,'/',blocknames{blk}];
    disp(path);
    tFile = dlmread([path,'/tFile.tgt']);%'TRDelay5.txt');
    fnames = dir(path);
    Ntrials = size(tFile,1);
    if strcmp('Gradual',groupname)
        for j=1:Ntrials
            if blk ~= 2 | blk ~=4
                if j == 101
                    continue
                end
            elseif blk == 2 | blk == 4
                if j == 201
                    continue
                end
            end
                    d = dlmread([path,'/',fnames(j+2).name],' ',6,0);
        X{trial} = d(3:4:end,3)-.6;
        Y{trial} = d(3:4:end,4)-.25;
        
        %%jump_time(trial) = 400;%tFile(j,8);
        target(trial,1) = tFile(j,2);
        target(trial,2) = tFile(j,3);
        %target_post(trial,1) = tFile(j,6);
        %target_post(trial,2) = tFile(j,7);
        start(trial,1:2) = [.60 .25];
        %jump(trial) = tFile(j,2)~=tFile(j,6); % jump trial flag
        
        
        trial = trial+1;
        end
    else
        for j=1:Ntrials
            if blk ~= 4
                if j == 101
                    continue
                end
            elseif blk == 4
                if j == 201
                    continue
                end
            end
        
    
        
        d = dlmread([path,'/',fnames(j+2).name],' ',6,0);
        X{trial} = d(3:4:end,3)-.6;
        Y{trial} = d(3:4:end,4)-.25;
        
        %%jump_time(trial) = 400;%tFile(j,8);
        target(trial,1) = tFile(j,2);
        target(trial,2) = tFile(j,3);
        %target_post(trial,1) = tFile(j,6);
        %target_post(trial,2) = tFile(j,7);
        start(trial,1:2) = [.60 .25];
        %jump(trial) = tFile(j,2)~=tFile(j,6); % jump trial flag
        
        
        trial = trial+1;
        end
    end
    tFileFull = [tFileFull; tFile];

end



% compute target angle
targAng = atan2(target(:,2)-start(:,2),target(:,1)-start(:,1));
data.target = mod(ceil(targAng*4/pi - .01),8); % target number

%targAngPost = atan2(target_post(:,2)-start(:,2),target_post(:,1)-start(:,1));
%data.target2 = mod(ceil(targAngPost*4/pi - .01),8);
data.X = X;
data.Y = Y;
data.Xunrot = X;
data.Yunrot = Y;
data.Ntrials = size(target,1);
%data.jump = jump;
%data.jump_time = jump_time;
X0 = 0.6;%tFile(1,1);
Y0 = 0.25;%tFile(1,2);
data.X0 = X0;
data.Y0 = Y0;
data.targPos = target;%-repmat([X0 Y0],size(target,1),1);
%data.targ2Pos = target_post - repmat([X0 Y0],size(target_post,1),1);
data.tFile = tFileFull;

d0 = 0*data.target;
data.rPT = d0;
data.reachDir = d0;
data.d_dir = d0;
data.iRT = d0;
data.iDir = d0;
data.iEnd = d0;

%ijmp = 1;

%disp('dfalkdsfal;dsjfal;dsjfl;asdfj')
%         figure(1); clf; hold on
%         for j=1:data.Ntrials % iterate through all trials
%             theta = atan2(data.targPos(j,2),data.targPos(j,1))-pi/2;
%             %R = [cos(theta) sin(theta); -sin(theta) cos(theta)];
%             R = eye(2);
%             data.handPos{j} = (R*[data.X{j}'-X0;data.Y{j}'-Y0])';
%
%
%
%             data.X{j} = data.handPos{j}(:,1);
%             data.Y{j} = data.handPos{j}(:,2);
%
%
%             %
%             plot(data.X{j},data.Y{j})
%             plot(data.targPos(j,1),data.targPos(j,2),'bo')
%             %plot(data.targ2Pos(j,1),data.targ2Pos(j,2),'rx')
%             axis equal
%pause
%keyboard
%         end

data = getErr_new(data);
%{
        iJmp = find(data.jump);
        dat = getSubset(data,iJmp);
        
        % no jump trials
        iNoJmp = find(1-data.jump);
        datNJ = getSubset(data,iNoJmp);
        dat = getErr_fixedT(dat);
        
        if(nargout>1)
            datNJ = getErr_fixedT(datNJ);
        end
        
        dat.reachDir = -dat.reachDir;
        
        data = dat;
%}
%dataNJ = datNJ;
end