function data = getErr(data)
% Calculates reach direction given a data structure loaded from raw
% kinereach output using the loadSubjData function
%
% Input:  data - output from 'loadSubjData'
%                (i.e. data_ns = loadSubjdata('JC_9_23ns',100) )
%
% Output  data - same as input data structure but with other variables
%                added

for i=1:data.Ntrials
    bad_trial = 0; % flag to keep track of whether this is a bad trial or not
    
    xpos = data.X{i}; % x position
    ypos = data.Y{i}; % y position
    pos = [xpos'; ypos'];
    
    % get smoothed position and velocity
    clear pos_filt
    w = 9;
    pos_filt(1,:) = savgolayFilt(pos(1,:),3,w);
    pos_filt(2,:) = savgolayFilt(pos(2,:),3,w);
    
    vel = [diff(pos_filt(1,:));diff(pos_filt(2,:))]; % compute velocity ('diff' computes difference between consecutive timepoints)
    clear vel_filt
    vel_filt(1,:) = savgolayFilt(vel(1,:),3,w);
    vel_filt(2,:) = savgolayFilt(vel(2,:),3,w);
    
    tanVel = sqrt(sum(vel_filt.^2)); % tangential velocity (i.e. overall speed, regardless of direction)
    
    VEL_THR_START = .001;
    
    % find end of movement - furthest point from start position
    d2 = sum(pos_filt.^2);
    [xx i_end(i)] = max(d2);
    i_end(i) = i_end(i)-1; % subtract 1 to use as index for velocity
    
    % get peak velocity
    if(i_end(i)<51)
        bad_trial=1;
    else
        [pV(i) i_pkVel] = max(tanVel(50:i_end(i))); % ignore first 50 timesteps in case something crazy is happening there
        i_pkVel = i_pkVel + 50; % compensate for ignored first 50 timesteps
        
        % get initiation time
        i_init = max(find(tanVel(1:i_pkVel)<VEL_THR_START)); % look backwards from peak velocity for first time vel is below threshold
    end

    
    if(isempty(i_init))
        bad_trial = 1;
    end
    
    % treat as a dud trial if movement goes less than 1cm
    if(max(d2)<.01^2)
        bad_trial = 1;
    end
    
    % bad trial, set everything to NaN
    if(bad_trial)
        RT(i) = NaN;
        reachDir(i) = NaN;
        iDir(i) = NaN;
    else
        RT(i) = i_init;
        iDir(i) = i_init+13; % measure direction 100ms after movement onset
        if(iDir>size(vel_filt,2)) % bad trial if movement onset was >100ms before movement end
            reachDir(i)=NaN;
            reachDir_unrot(i)=NaN;
            bad_trial = 1;
        else
            reachDir(i) = atan2(vel_filt(2,iDir(i)),vel_filt(1,iDir(i))); % compute angle based on instantaneous velocity
        end
    end
    
    tanVelocity{i} = tanVel;
end

%% tidy up variables
reachDir =reachDir*180/pi - 90; % convert from radians to degrees
ibad = find(reachDir < -180); % fix to range [-180,180];
reachDir(ibad) = reachDir(ibad)+360;

data.reachDir = reachDir;
%data.reachDir_unrot = reachDir_unrot*180/pi;
data.RT = RT;
data.iDir = iDir;
data.iEnd = i_end;

data.tanVel = tanVelocity;

data.pkVel = pV;

