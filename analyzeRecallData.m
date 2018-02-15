function ANA = analyzeRecallData(what,varargin)
%baseDir = 'C:\Users\npopp\Dropbox (Personal)\AdaptRecall-master';
%cd (baseDir);

load('RecallData_compact.mat')
addpath Analysisnew/JoernCode

d.Block(1:100) = 1;
d.Block(101:200) = 2;
d.Block(201:300) = 3;
d.Block(301:500) = 4;
d.Block(501:600) = 5;
dCtrl.Block(1:100) = 1;
dCtrl.Block(101:200) = 2;
dCtrl.Block(201:300) = 3;
dCtrl.Block(301:500) = 4;
dCtrl.Block(501:600) = 5;
dGrad.Block(1:100) = 1;
dGrad.Block(101:200) = 2;
dGrad.Block(201:300) = 3;
dGrad.Block(301:500) = 4;
dGrad.Block(501:600) = 5;
dGradLong.Block(1:100) = 1;
dGradLong.Block(101:200) = 2;
dGrad.Block(201:300) = 3;
dGrad.Block(301:500) = 4;
dGrad.Block(501:600) = 5;
excludesubjs = 0;

if(excludesubjs)
    gainExclude = [4];
    d.reachDir(gainExclude,:) = NaN;
    d.endPoint(gainExclude,:) = NaN;
    d.Xreverse(gainExclude,:) = NaN;
    
    ctrlExclude = [7 10];
    dCtrl.reachDir(ctrlExclude,:) = NaN;
    dCtrl.endPoint(ctrlExclude,:) = NaN;
    dCtrl.Xreverse(ctrlExclude,:) = NaN;
    
    gradExclude = [5 8];
    dGrad.reachDir(gradExclude,:) = NaN;
    dGrad.endPoint(gradExclude,:) = NaN;
    dGrad.Xreverse(gradExclude,:) = NaN;
    
end

bad_trials_gain = [2 308; 2 396; 9 393; 9 396];
for i=1:length(bad_trials_gain)
    d.reachDir(bad_trials_gain(i,1),bad_trials_gain(i,2))= NaN;
end

bad_trials_ctrl = [3 301; 3 398; 8 326; 8 333; 8 391; 8 392];
for i=1:length(bad_trials_ctrl)
    dCtrl.reachDir(bad_trials_ctrl(i,1),bad_trials_ctrl(i,2))= NaN;
end

bad_trials_grad = [4 326; 4 327; 3 373; 7 330];
for i=1:length(bad_trials_grad)
    dGrad.reachDir(bad_trials_grad(i,1),bad_trials_grad(i,2))= NaN;
end

d.subj = 1:size(d.reachDir,1);
dCtrl.subj = 1:size(dCtrl.reachDir,1);
dGrad.subj = 1:size(dGrad.reachDir,1);
if strcmp(what,'endpointmean') == 0
    d.endPoint = d.endPoint*100;
    dGrad.endPoint =  dGrad.endPoint*100;
    dCtrl.endPoint = dCtrl.endPoint*100;
end
% if strcmp(what,'Anova') ~= 1
%
% for i = 1:size(d.endPoint,1)
%     d.endPoint(i,d.endPoint(i,:) > 3*nanstd(d.endPoint(i,:)))= NaN
% end
% for i = 1:size(dCtrl.endPoint,1)
%     dCtrl.endPoint(i,dCtrl.endPoint(i,:) > 3*nanstd(dCtrl.endPoint(i,:)))= NaN
% end
% for i = 1:size(dGrad.endPoint,1)
%     dGrad.endPoint(i,dGrad.endPoint(i,:) > 3*nanstd(dGrad.endPoint(i,:)))= NaN
% end
% end

blklengths = [100 100 100 200 100];
blkends = cumsum(blklengths);

%dGradLong.Ntrials = size(dGradLong.endPoint,2);

switch what
    
    case 'reachdirmean'
        %% mean reachdir for gain,gradual and control
        
        figure(1); clf; hold on
        
        plot(nanmean(d.reachDir),'b.-','linewidth',2)
        plot([blkends; blkends],[-100 100],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-100 100],'k--','linewidth',2)
        
        plot(nanmean(dCtrl.reachDir),'r.-','linewidth',2)
        plot([0 610],[0 0],'k')
        
        plot(nanmean(dGrad.reachDir)','m-','linewidth',2);
        
        %plot(nanmena(d
        
        xlabel('Trial Number')
        ylabel('Reach Direction')
        axis([0 620 -20 60])
        
    case 'endpointmean'
        %mean endpint offset for gain,gradual and control
        figure(1); clf; hold on
        
        plot(nanmean(d.endPoint),'b.-','linewidth',2)
        plot(nanmean(dCtrl.endPoint),'r.-','linewidth',2)
        plot(nanmean(dGrad.endPoint),'g.-','color',[0 1 0],'linewidth',2);
        
        plot([blkends; blkends],[-10 15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-10 15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -10 15])
        
        
    case 'Xreversemean'
        
        % smoothed estimates of endpoint mean
        figure(1); clf; hold on
        plot(nanmean(d.Xreverse),'b.-','linewidth',2)
        plot(nanmean(dCtrl.Xreverse),'r.-','linewidth',2)
        plot(nanmean(dGrad.Xreverse),'g.-','color',[0 1 0],'linewidth',2);
        plot(dGradLong.Ntrials-80,nanmean(dGradLong.Xreverse),'m.-','linewidth',2)
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 500],[0 0],'k')
        axis([0 500 -.07 .12])
        
        
 figure(2); clf; hold on   
 rng = 1:500;
 rngL = 1:580;
 shadedErrorBar([],nanmean(d.Xreverse(:,rng)),seNaN(d.Xreverse(:,rng)),'r.-');%,0);    
 shadedErrorBar([],nanmean(dCtrl.Xreverse(:,rng)),seNaN(dCtrl.Xreverse(:,rng)),'b.-');%,1);   
 shadedErrorBar([],nanmean(dGrad.Xreverse(:,rng)),seNaN(dGrad.Xreverse(:,rng)),'k.-');%,1);%{'-','markerfacecolor',[0.128 0.128 0.128],'Color',[0.128 0.128 0.128]},0);    
 shadedErrorBar([],nanmean(dGradLong.Xreverse(:,rng+80)),seNaN(dGradLong.Xreverse(:,rng+80)),'m.-');
 %shadedErrorBar(5*[1:100]-2.5,nanmean(binData(d.Xreverse(:,rng),5)),seNaN(binData(d.Xreverse(:,rng),5)),'r');%,0);    
 %shadedErrorBar(5*[1:100]-2.5,nanmean(binData(dCtrl.Xreverse(:,rng),5)),seNaN(binData(d.Xreverse(:,rng),5)),'b');%,1);   
 %shadedErrorBar(5*[1:100]-2.5,nanmean(binData(dGrad.Xreverse(:,rng),5)),seNaN(binData(d.Xreverse(:,rng),5)),'k');%,1);%{'-','markerfacecolor',[0.128 0.128 0.128],'Color',[0.128 0.128 0.128]},0);    
 
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 500],[0 0],'k')
        axis([0 500 -.05 .1])
        
    case 'reverseAnglemean'
        
        figure(1); clf; hold on
        plot(nanmean(d.reverseAngle),'b.-','linewidth',2)
        plot(nanmean(dCtrl.reverseAngle),'r.-','linewidth',2)
        plot(nanmean(dGrad.reverseAngle),'g.-','color',[0 1 0],'linewidth',2);
        
        
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        
    case 'actualseenendpoints'
        
        figure(3); clf; hold on
        plot(d.EndX','-','color',.7*[1 1 1]);
        %plot(d.Xend','-','color',.7*[1 1 1]);
        plot(nanmean(d.EndX),'b.-','linewidth',2)
        %plot(nanmean(d.Xend),'b.-','linewidth',2)
        plot(dCtrl.EndX','-','color',[1 .7 .7]);
        %plot(dCtrl.Xend','-','color',[1 .7 .7]);
        plot(nanmean(dCtrl.EndX),'r.-','linewidth',2)
        % plot(nanmean(dCtrl.Xend),'r.-','linewidth',2)
        plot(dGrad.EndX','-','color',[0 1 0],'linewidth',2);
        % plot(dGrad.Xend','-','color',[0 1 0],'linewidth',2);
        plot(nanmean(dGrad.EndX),'-','color',[0 1 0],'linewidth',2);
        
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -.1 .2])
        
        %---
        figure(4); clf; hold on
        plot(d.EndY','-','color',.7*[1 1 1]);
        plot(nanmean(d.EndY),'b.-','linewidth',2)
        plot(dCtrl.EndY','-','color',[1 .7 .7]);
        plot(nanmean(dCtrl.EndY),'r.-','linewidth',2)
        plot(dGrad.EndY','-','color',[0 1 0],'linewidth',2);
        plot(nanmean(dGrad.EndY),'g.-','linewidth',2)
        
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -.1 .2])
        
    case 'Xreversegain'
        %close all
        %for i = 1:length(d.subj)
        
        figure(1); clf; hold on
        %subplot(4,3,i)
        hold on
        plot(d.Ntrials',d.Xreverse','color',.6*[1 1 1])
        plot([blkends; blkends],[-15 15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-15 15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -.05 .15])
        %end
        plot(d.Ntrials,nanmean(d.Xreverse),'b','linewidth',2)
        %keyboard
        
    case 'Xreversecontrol'
        %close all
        %for i = 1:length(dCtrl.subj)
        
        figure(1); clf; hold on
        %subplot(4,3,i)
        hold on
        plot(dCtrl.Ntrials',dCtrl.Xreverse','color',.6*[1 1 1])
        plot([blkends; blkends],[-15 15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-15 15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -.05 .15])
        %end
        plot(d.Ntrials,nanmean(dCtrl.Xreverse),'r','linewidth',2)
        
    case 'Xreversegradual'
        %close all
        %for i = 1:length(dGrad.subj)
        figure(1); clf; hold on
        %subplot(4,3,i)
        
        hold on
        plot(dGrad.Ntrials',dGrad.Xreverse','color',.6*[1 1 1])
        plot([blkends; blkends],[-15 15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-15 15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -.05 .15])
        %end
        plot(d.Ntrials,nanmean(dGrad.Xreverse),'m','linewidth',2)
        
    case 'Xreversegradlong'
        figure(1); clf; hold on
        plot(dGradLong.Ntrials',dGradLong.Xreverse','color',.6*[1 1 1])
        plot([blkends; blkends],[-15 15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-15 15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -.05 .15])
        %end
        plot(dGradLong.Ntrials,nanmean(dGradLong.Xreverse),'m','linewidth',2)        
        
    case 'changeendpoint'
        %% gain change
        w = 25;
        for i = 1:size(d.endPoint,1)
            d.SubjEndPMean(i,1) = nanmean(d.endPoint(i,350-w+1:350)) ;
            d.SubjEndPMean(i,2) = nanmean(d.endPoint(i,351:350+w)) ;
            dCtrl.SubjEndPMean(i,1) = nanmean(dCtrl.endPoint(i,350-w+1:350))  ;
            dCtrl.SubjEndPMean(i,2) = nanmean(dCtrl.endPoint(i,351:350+w)) ;
            dGrad.SubjEndPMean(i,1) = nanmean(dGrad.endPoint(i,350-w+1:350))  ;
            dGrad.SubjEndPMean(i,2) = nanmean(dGrad.endPoint(i,351:350+w))  ;
            dGradLong.SubjEndPMean(i,1) = nanmean(dGradLong.endPoint(i,350-w+1+80:350+80))  ;
            dGradLong.SubjEndPMean(i,2) = nanmean(dGradLong.endPoint(i,351+80:350+w+80))  ;
        end
        
        ttest(d.SubjEndPMean(:,2),d.SubjEndPMean(:,1),2,'paired')
        ttest(dCtrl.SubjEndPMean(:,2),dCtrl.SubjEndPMean(:,1),2,'paired')
        ttest(dGrad.SubjEndPMean(:,2),dGrad.SubjEndPMean(:,1),2,'paired')
        close all
        
        figure(1);
        
        subplot(1,3,1);
        hold on
        
        for i = 1:size(d.SubjEndPMean,1)
            plot([1 2],d.SubjEndPMean(i,:),'-or');
        end
        lineplot([ones(size(d.SubjEndPMean,1),1); 2*ones(size(d.SubjEndPMean,1),1)],d.SubjEndPMean(:),'style_thickline');
        
        subplot(1,3,2)
        hold on
        
        for i = 1:size(dCtrl.SubjEndPMean,1);
            plot([1 2],dCtrl.SubjEndPMean(i,:),'-ok');
        end
        lineplot([ones(size(dCtrl.SubjEndPMean,1),1); 2*ones(size(dCtrl.SubjEndPMean,1),1)],dCtrl.SubjEndPMean(:),'style_thickline');
        
        %dGrad.SubjEndPMean(8,:) = [];
        subplot(1,3,3);
        hold on
        for i = 1:size(dGrad.SubjEndPMean,1)
            plot([1 2],dGrad.SubjEndPMean(i,:),'-og');
        end
        lineplot([ones(size(dGrad.SubjEndPMean,1),1); 2*ones(size(dGrad.SubjEndPMean,1),1)],dGrad.SubjEndPMean(:),'style_thickline');
        
    case 'changereachdir'
        % gain change
        w = 25;
        for i = 1:size(d.reachDir,1)
            d.SubjSwitch(i,1) = mean([d.reachDir(i,350) d.reachDir(i,351)]) ;
            dCtrl.SubjSwitch(i,1) = mean([dCtrl.reachDir(i,350) dCtrl.reachDir(i,351)]) ;
            dGrad.SubjSwitch(i,1) = mean([dGrad.reachDir(i,350) dGrad.reachDir(i,351)]) ;
        end
        
        for i = 1:size(d.endPoint,1)
            d.SubjEndPMean(i,1) = mean(d.reachDir(i,350-w+1:350)) - d.SubjSwitch(i) ;
            d.SubjEndPMean(i,2) = mean(d.reachDir(i,351:350+w))  - d.SubjSwitch(i) ;
            dCtrl.SubjEndPMean(i,1) = mean(dCtrl.reachDir(i,350-w+1:350)) - dCtrl.SubjSwitch(i) ;
            dCtrl.SubjEndPMean(i,2) = mean(dCtrl.reachDir(i,351:350+w))  - dCtrl.SubjSwitch(i) ;
            dGrad.SubjEndPMean(i,1) = mean(dGrad.reachDir(i,350-w+1:350)) - dGrad.SubjSwitch(i) ;
            dGrad.SubjEndPMean(i,2) = mean(dGrad.reachDir(i,351:350+w))  - dGrad.SubjSwitch(i) ;
        end
        
        ttest(d.SubjEndPMean(:,2),d.SubjEndPMean(:,1),1,'paired')
        ttest(dCtrl.SubjEndPMean(:,2),dCtrl.SubjEndPMean(:,1),1,'paired')
        ttest(dGrad.SubjEndPMean(:,2),dGrad.SubjEndPMean(:,1),1,'paired')
        close all
        figure(1);
        
        subplot(1,3,1)
        hold on
        
        for i = 1:size(d.SubjEndPMean,1)
            plot([1 2],d.SubjEndPMean(i,:),'-or');
        end
        lineplot([ones(size(d.SubjEndPMean,1),1); 2*ones(size(d.SubjEndPMean,1),1)],d.SubjEndPMean(:),'style_thickline');
        
        subplot(1,3,2)
        hold on
        
        for i = 1:size(dCtrl.SubjEndPMean,1)
            plot([1 2],dCtrl.SubjEndPMean(i,:),'-ok')
        end
        lineplot([ones(size(dCtrl.SubjEndPMean,1),1); 2*ones(size(dCtrl.SubjEndPMean,1),1)],dCtrl.SubjEndPMean(:),'style_thickline');
        
        %dGrad.SubjEndPMean(8,:) = [];
        subplot(1,3,3)
        hold on
        for i = 1:size(dGrad.SubjEndPMean,1)
            plot([1 2],dGrad.SubjEndPMean(i,:),'-og')
        end
        lineplot([ones(size(dGrad.SubjEndPMean,1),1); 2*ones(size(dGrad.SubjEndPMean,1),1)],dGrad.SubjEndPMean(:),'style_thickline');
        
        
    case 'changeXreverse'
        % gain change
        % 25 trials before and after gain onset
        
        w = 50;
        
        
        d.SubjEndPMean(:,1) = nanmean(d.Xreverse(:,350-w+1:350)');
        d.SubjEndPMean(:,2) = nanmean(d.Xreverse(:,351:350+w)');
        dCtrl.SubjEndPMean(:,1) = nanmean(dCtrl.Xreverse(:,350-w+1:350)');
        dCtrl.SubjEndPMean(:,2) = nanmean(dCtrl.Xreverse(:,351:350+w)');
        dGrad.SubjEndPMean(:,1) = nanmean(dGrad.Xreverse(:,350-w+1:350)');
        dGrad.SubjEndPMean(:,2) = nanmean(dGrad.Xreverse(:,351:350+w)');
        dGradLong.SubjEndPMean(:,1) = nanmean(dGradLong.Xreverse(:,350-w+1+80:350+80)');
        dGradLong.SubjEndPMean(:,2) = nanmean(dGradLong.Xreverse(:,351+80:350+w+80)');
        
        ttest(d.SubjEndPMean(:,2),d.SubjEndPMean(:,1),1,'paired')
        ttest(dCtrl.SubjEndPMean(:,2),dCtrl.SubjEndPMean(:,1),1,'paired')
        ttest(dGrad.SubjEndPMean(:,2),dGrad.SubjEndPMean(:,1),1,'paired')
        ttest(dGradLong.SubjEndPMean(:,2),dGradLong.SubjEndPMean(:,1),1,'paired')
        close all
        figure(1);
        
        subplot(1,4,1)
        hold on
        
        for i = 1:size(d.SubjEndPMean,1)
            hold on
            h = plot([1 2],d.SubjEndPMean(i,:),'.-r');
            h.Color(4) = 0.4;
        end
        iplot = find(~isnan(d.SubjEndPMean(:)));
        lineplot([ones(size(d.SubjEndPMean(iplot),1)/2,1); 2*ones(size(d.SubjEndPMean(iplot),1)/2,1)],d.SubjEndPMean(iplot),'style_thickline','linecolor',[1 0 0],'markercolor',[1 0 0],'errorcolor',[1 0 0]);
        ax = gca;
        ax.XTickLabel = {'Before Gain Onset','After Gain onset'}
        ylabel('Horizontal Endpoint Offset')
        axis([0.8 2.2,-0.02 0.04])

        subplot(1,4,2)
        hold on
        
        for i = 1:size(dCtrl.SubjEndPMean,1)
            hold on
            ha = plot([1 2],dCtrl.SubjEndPMean(i,:),'.-b');
            ha.Color(4) = 0.4;
        end
        iplot = find(~isnan(dCtrl.SubjEndPMean(:)));
        lineplot([ones(size(dCtrl.SubjEndPMean(iplot),1)/2,1); 2*ones(size(dCtrl.SubjEndPMean(iplot),1)/2,1)],dCtrl.SubjEndPMean(iplot),'style_thickline','linecolor',[0 0 1],'markercolor',[0 0 1],'errorcolor',[0 0 1]);
        ax = gca;
        ax.XTickLabel = {'Before Gain Onset','After Gain onset'}
        ylabel('Horizontal Endpoint Offset')
        axis([0.8 2.2,-0.02 0.04])
        
        subplot(1,4,3)
        hold on
        for i = 1:size(dGrad.SubjEndPMean,1)
            hb = plot([1 2],dGrad.SubjEndPMean(i,:),'.-','Color',[0.128,0.128,0.128]);
            hb.Color(4) = 0.4;     
        end
        iplot = find(~isnan(dGrad.SubjEndPMean(:)));
        lineplot([ones(size(dGrad.SubjEndPMean(iplot),1)/2,1); 2*ones(size(dGrad.SubjEndPMean(iplot),1)/2,1)],dGrad.SubjEndPMean(iplot),'style_thickline','linecolor',[0.128,0.128,0.128],'markercolor',[0.128,0.128,0.128],'errorcolor',[0.128,0.128,0.128]);
        ax = gca;
        ax.XTickLabel = {'Before Gain Onset','After Gain onset'};
        ylabel('Horizontal Endpoint Offset')
        axis([0.8 2.2,-0.02 0.04])
        
        subplot(1,4,4)
        hold on
        for i = 1:size(dGradLong.SubjEndPMean,1)
            hb = plot([1 2],dGradLong.SubjEndPMean(i,:),'m.-');
            hb.Color(4) = 0.4;     
        end
        iplot = find(~isnan(dGradLong.SubjEndPMean(:)));
        lineplot([ones(size(dGradLong.SubjEndPMean(iplot),1)/2,1); 2*ones(size(dGradLong.SubjEndPMean(iplot),1)/2,1)],dGradLong.SubjEndPMean(iplot),'style_thickline','linecolor',[1 0 1],'markercolor',[1 0 1],'errorcolor',[1 0 1]);
        ax = gca;
        ax.XTickLabel = {'Before Gain Onset','After Gain onset'};
        ylabel('Horizontal Endpoint Offset')
        axis([0.8 2.2,-0.02 0.04])
        
    case 'endpointvsreach'
        %%check out endpoint vs reachdir
        
        % Plot reach direction vs endpoint
        close all
        figure(1)
        subplot(3,1,1)
        xlabel('gain')
        hold on
        plot(d.reachDir,d.endPoint*100,'o')
        plot([-100 150],[-100 150],'-')
        subplot(3,1,2)
        ylabel('endpoint*100')
        
        hold on
        plot(dCtrl.reachDir,dCtrl.endPoint*100,'o')
        plot([-100 150],[-100 150],'-')
        xlabel('control')
        subplot(3,1,3)
        hold on
        plot(dGrad.reachDir,dGrad.endPoint*100,'o')
        plot([-100 150],[-100 150],'-')
        xlabel('gradual - reachDir')
        
        figure(2)
        
        %plot block 2 (adaptation) vs. block 4 (gain)
        subplot(3,1,1)
        hold on
        plot(d.reachDir(:,d.Block == 2),d.endPoint(:,d.Block == 2)*100,'bo')
        plot(d.reachDir(:,d.Block == 4),d.endPoint(:,d.Block == 4)*100,'ro')
        
        subplot(3,1,2)
        hold on
        plot(dCtrl.reachDir(:,dCtrl.Block == 2),dCtrl.endPoint(:,dCtrl.Block == 2)*100,'bo')
        plot(dCtrl.reachDir(:,dCtrl.Block == 4),dCtrl.endPoint(:,dCtrl.Block == 4)*100,'ro')
        ylabel('endpoint')
        
        subplot(3,1,3)
        hold on
        plot(dGrad.reachDir(:,dGrad.Block == 2),dGrad.endPoint(:,dGrad.Block == 2)*100,'bo')
        plot(dGrad.reachDir(:,dGrad.Block == 4),dGrad.endPoint(:,dGrad.Block == 4)*100,'ro')
        
        xlabel('reachDir')
        
        % plot reachdir last 25 trials of adaptation vs first 25 trials in when the gain started
        
        figure(3)
        subplot(3,2,1)
        hold on
        plot(mean(d.reachDir(:,195:220),2),'ob')
        plot(mean(d.reachDir(:,351:376),2),'or')
        xlabel('Subj')
        ylabel('reachDir')
        
        axis([0 13 0 45])
        % plot endpoint last 25 trials of adaptation vs first 25 trials in when the gain started
        subplot(3,2,2)
        hold on
        plot(mean(d.endPoint(:,195:220)*100,2),'ok')
        plot(mean(d.endPoint(:,351:376)*100,2),'om')
        xlabel('Subj')
        ylabel('endPoint')
        
        figure(3)
        subplot(3,2,3)
        hold on
        plot(mean(dCtrl.reachDir(:,195:220),2),'ob')
        plot(mean(dCtrl.reachDir(:,351:376),2),'or')
        xlabel('Subj')
        ylabel('reachDir')
        
        axis([0 13 0 45])
        % plot endpoint last 25 trials of adaptation vs first 25 trials in when the gain started
        subplot(3,2,4)
        hold on
        plot(mean(dCtrl.endPoint(:,195:220)*100,2),'ok')
        plot(mean(dCtrl.endPoint(:,351:376)*100,2),'om')
        xlabel('Subj')
        ylabel('endPoint')
        
        figure(3)
        subplot(3,2,5)
        hold on
        plot(mean(dGrad.reachDir(:,195:220),2),'ob')
        plot(mean(dGrad.reachDir(:,351:376),2),'or')
        xlabel('Subj')
        ylabel('reachDir')
        
        axis([0 13 0 45])
        % plot endpoint last 25 trials of adaptation vs first 25 trials in when the gain started
        subplot(3,2,6)
        hold on
        plot(mean(dGrad.endPoint(:,195:220)*100,2),'ok')
        plot(mean(dGrad.endPoint(:,351:376)*100,2),'om')
        xlabel('Subj')
        ylabel('endPoint')
        
        %Gain: calculate difference in means per subject between last 25
        %adaptation and first 25 gain
        DifMeanReachDir =  mean(d.reachDir(:,195:220),2) - mean(d.reachDir(:,351:376),2);
        DifMeanErrorDir =  mean(d.endPoint(:,195:220)*100,2) - mean(d.endPoint(:,351:376)*100,2);
        
        %compare difference
        ttest(DifMeanReachDir,DifMeanErrorDir,'2','paired')
        
        % Control:calculate difference in means per subject between last 25
        %adaptation and first 25 gain
        DifMeanReachDir =  mean(dCtrl.reachDir(:,195:220),2) - mean(dCtrl.reachDir(:,351:376),2);
        DifMeanErrorDir =  mean(dCtrl.endPoint(:,195:220)*100,2) - mean(dCtrl.endPoint(:,351:376)*100,2);
        
        %compare difference
        ttest(DifMeanReachDir,DifMeanErrorDir,'2','paired')
        
        %Gradual: calculate difference in means per subject between last 25
        %adaptation and first 25 gain
        DifMeanReachDir =  mean(dGrad.reachDir(:,195:220),2) - mean(dGrad.reachDir(:,351:376),2);
        DifMeanErrorDir =  mean(dGrad.endPoint(:,195:220)*100,2) - mean(dGrad.endPoint(:,351:376)*100,2);
        
        %compare difference
        ttest(DifMeanReachDir,DifMeanErrorDir,'2','paired')
        
    case 'Anova'
        %% Anova
        Endpoint1 = d.Xreverse(:,326:350);
        Endpoint2 = d.Xreverse(:,351:375);
        Endpoint = [Endpoint1 Endpoint2];
        vEndpointGa = reshape(permute(Endpoint,[2 1]),[length(Endpoint(:)) 1])*100 ;
        vSubjGa =  kron(d.subj,ones(size(Endpoint,2),1));
        
        Endpointco1 = dCtrl.Xreverse(:,326:350);
        Endpointco2 = dCtrl.Xreverse(:,351:375);
        Endpointco = [Endpointco1 Endpointco2];
        vSubjCo =  kron(dCtrl.subj,ones(size(Endpointco,2),1));
        vEndpointCo = reshape(permute(Endpointco,[2 1]),[length(Endpointco(:)) 1])*100 ;
        
        Endpointgrad1 = dGrad.Xreverse(:,326:350);
        Endpointgrad2 = dGrad.Xreverse(:,351:375);
        Endpointgrad = [Endpointgrad1 Endpointgrad2];
        vSubjGrad =  kron(dGrad.subj,ones(size(Endpointgrad,2),1));
        vEndpointGrad = reshape(permute(Endpointgrad,[2 1]),[length(Endpointgrad(:)) 1])*100 ;
        v.BeforeAfter = kron([ones(1,25) 2*ones(1,25)],ones(size([d.subj dCtrl.subj dGrad.subj],2),1))';

        v.Subj = [vSubjGa(:); vSubjCo(:) ;vSubjGrad(:)];
        v.Endpoint = [vEndpointGa ; vEndpointCo ; vEndpointGrad];
        v.Group = [ones(length(vSubjGa(:)),1);2*ones(length(vSubjCo(:)),1); 3*ones(length(vSubjGrad(:)),1)];
        v.BeforeAfter = v.BeforeAfter(:);
        
        v.Group(isnan(v.Endpoint)) = [];
        v.Subj(isnan(v.Endpoint)) = [];
        v.BeforeAfter(isnan(v.Endpoint)) = [];
        v.Endpoint(isnan(v.Endpoint)) = [];

        results=anovaMixed(v.Endpoint,v.Subj, 'within',v.BeforeAfter(:) ,{'BeforeafterGain'},'between',v.Group,{'Group'},'intercept',1);
        
        
        lineplot(v.BeforeAfter(:),v.Endpoint,'split',v.Group,'leg','auto')
        
        
        
    case 'ttest_interaction'
        %% ttest group
        
        w = 50;
        %Gain: calculate difference in means per subject between last 25
        %adaptation and first 25 gain
        
        DifMeanReachGain =  mean(d.reachDir(:,351:350+w),2)- mean(d.reachDir(:,351-w:350),2);
        DifMeanErrorGain =  mean(d.endPoint(:,351:350+w),2)- mean(d.endPoint(:,351-w:350),2) ;
        DifMeanXRevGain =  mean(d.Xreverse(:,351:350+w),2)- mean(d.Xreverse(:,351-w:350),2) ;

        
        % Control:calculate difference in means per subject between last 25
        %adaptation and first 25 gain
        DifMeanReachControl =  mean(dCtrl.reachDir(:,351:350+w),2) - mean(dCtrl.reachDir(:,351-w:350),2);
        DifMeanErrorControl =  mean(dCtrl.endPoint(:,351:350+w),2) - mean(dCtrl.endPoint(:,351-w:350),2);
        DifMeanXRevControl =  mean(dCtrl.Xreverse(:,351:350+w),2) - mean(dCtrl.Xreverse(:,351-w:350),2);
        
        
        %Gradual: calculate difference in means per subject between last 25
        %adaptation and first 25 gain
        DifMeanReachGrad =  mean(dGrad.reachDir(:,351:350+w),2) - mean(dGrad.reachDir(:,351-w:350),2);
        DifMeanErrorGrad =  mean(dGrad.endPoint(:,351:350+w),2) - mean(dGrad.endPoint(:,351-w:350),2);
        DifMeanXRevGrad =  mean(dGrad.Xreverse(:,351:350+w),2) - mean(dGrad.Xreverse(:,351-w:350),2);
        
        % Gradual Long
        DifMeanReachGradLong =  mean(dGradLong.reachDir(:,351+80:350+80+w),2) - mean(dGradLong.reachDir(:,351-w+80:350+80),2);
        DifMeanErrorGradLong =  mean(dGradLong.endPoint(:,351+80:350+80+w),2) - mean(dGradLong.endPoint(:,351-w+80:350+80),2);
        DifMeanXRevGradLong =  mean(dGradLong.Xreverse(:,351+80:350+80+w),2) - mean(dGradLong.Xreverse(:,351-w+80:350+80),2);
        
        
        
        ttest(DifMeanXRevGain,DifMeanXRevControl,2,'independent')
        ttest(DifMeanXRevGain,DifMeanXRevGrad,2,'independent')
        ttest(DifMeanXRevGain,DifMeanXRevGradLong,2,'independent')
        %ttest(DifMeanXRevControl,DifMeanXRevGrad,2,'independent')
        
        
end