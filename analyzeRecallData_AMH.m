function ANA = analyzeRecallData(what,varargin)
load('adaptrecall_alldat.mat')
 d.reachDir(10,:) = [];
 d.endPoint(10,:) = [];
 d.reachDir(4,:) = [];
 d.endPoint(4,:) = [];
 dCtrl.reachDir(7,:) = [];
 dCtrl.endPoint(7,:) = [];
 dCtrl.reachDir(10,:) = [];
 dCtrl.endPoint(10,:) = [];
 dGrad.reachDir(8,:) = [];
 dGrad.endPoint(8,:) = [];
 d.subj = 1:size(d.reachDir,1);
 dCtrl.subj = 1:size(dCtrl.reachDir,1);
 dGrad.subj = 1:size(dGrad.reachDir,1);

switch what
    
    case 'reachdirmean'
        %% mean reachdir
        figure(1)
%         d.reachDir([4 9],:) = NaN;
%         dGrad.reachDir(5,:) = NaN;
        %d.reachDir(3,:) = NaN;
        blklengths = [100 100 100 200 100];
        blkends = cumsum(blklengths);
        figure(1); clf; hold on
        %plot(d.reachDir','-','color',.7*[1 1 1]);
        plot(meanNaN(d.reachDir),'b.-','linewidth',2)
        plot([blkends; blkends],[-100 100],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-100 100],'k--','linewidth',2)
        
        %plot(dCtrl.reachDir','-','color',[1 .7 .7]);
        plot(meanNaN(dCtrl.reachDir),'r.-','linewidth',2)
        plot([0 610],[0 0],'k')
        
        plot(meanNaN(dGrad.reachDir)','-','color',[0 1 0],'linewidth',2);
        
        
        xlabel('Trial Number')
        ylabel('Reach Direction')
        axis([0 620 -30 80])
        
    case 'endpointmean'
        figure(2)
%         d.endPoint([4 9],:) = NaN;
%         dGrad.endPoint(5,:) = NaN;
        
        figure(2); clf; hold on
        %plot(d.endPoint','-','color',.[.7 .7 1]);
        plot(meanNaN(d.endPoint),'b.-','linewidth',2)
        %plot(dCtrl.endPoint','-','color',[1 .7 .7]);
        plot(meanNaN(dCtrl.endPoint),'r.-','linewidth',2)
        %plot(dGrad.endPoint','-','color',.7*[.7 1 .7])
        plot(meanNaN(dGrad.endPoint),'g.-','color',[0 1 0],'linewidth',2);
        
        
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -.1 .2])
        
        
    case 'actualseenendpoints'
        %%
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
        %%---
        figure(3); clf; hold on
        plot(d.EndX','-','color',.7*[1 1 1]);
        plot(d.Xend','-','color',.7*[1 1 1]);
        plot(meanNaN(d.EndX),'b.-','linewidth',2)
        plot(meanNaN(d.Xend),'b.-','linewidth',2)
        plot(dCtrl.EndX','-','color',[1 .7 .7]);
        plot(dCtrl.Xend','-','color',[1 .7 .7]);
        plot(meanNaN(dCtrl.EndX),'r.-','linewidth',2)
        plot(meanNaN(dCtrl.Xend),'r.-','linewidth',2)
        plot(dGrad.EndX,'-','color',[0 1 0],'linewidth',2);
        plot(dGrad.Xend,'-','color',[0 1 0],'linewidth',2);
        
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -.1 .2])
        
        %---
        figure(4); clf; hold on
        plot(d.EndY','-','color',.7*[1 1 1]);
        plot(meanNaN(d.EndY),'b.-','linewidth',2)
        plot(dCtrl.EndY','-','color',[1 .7 .7]);
        plot(meanNaN(dCtrl.EndY),'r.-','linewidth',2)
        plot(dGrad.EndY,'-','color',[0 1 0],'linewidth',2);
        
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -.1 .2])
        
        
    case 'reachdirgain'
        close all
        for i = 1:length(d.subj)
            
            %figure(i)
            subplot(3,4,i)
            hold on
            plot(d.Ntrials',d.reachDir(i,:)')
            plot([blkends; blkends],[-100 100],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-100 100],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Reach Direction')
            axis([0 620 -30 80])
            plot([0 610],[0 0],'k')
        end
        
    case 'reachdircontrol'
        close all
        for i = 1:length(dCtrl.subj)
            
            %figure(i)
            subplot(3,4,i)
            hold on
            plot(dCtrl.Ntrials',dCtrl.reachDir(i,:)')
            plot([blkends; blkends],[-100 100],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-100 100],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Reach Direction')
            axis([0 620 -30 80])
            plot([0 610],[0 0],'k')
        end
    case 'reachdirgradual'
        close all
        
        for i = 1:length(dGrad.subj)
            
            %figure(i)
            subplot(3,4,i)
            hold on
            plot(dGrad.Ntrials',dGrad.reachDir(i,:)')
            plot([blkends; blkends],[-100 100],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-100 100],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Reach Direction')
            axis([0 620 -30 80])
            plot([0 610],[0 0],'k')
        end
    case 'endpointgain'
        %close all
        for i = 1:length(d.subj)
            
            %figure(i)
            subplot(3,4,i)
            hold on
            plot(d.Ntrials',d.endPoint(i,:)')
            plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Endpoint')
            plot([0 610],[0 0],'k')
            axis([0 620 -.1 .2])
        end
        
    case 'endpointcontrol'
        close all
        for i = 1:length(dCtrl.subj)
            
            %figure(i)
            subplot(3,4,i)
            hold on
            plot(dCtrl.Ntrials',dCtrl.endPoint(i,:)')
            plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Endpoint')
            plot([0 610],[0 0],'k')
            axis([0 620 -.1 .2])
        end
        
    case 'endpointgradual'
        close all
        for i = 1:length(dGrad.subj)
            %figure(i)
            subplot(3,4,i)
            hold on
            plot(dGrad.Ntrials',dGrad.endPoint(i,:)')
            plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Endpoint')
            plot([0 610],[0 0],'k')
            axis([0 620 -.1 .2])
        end
        
    case 'changeendpoint'
        %% gain change
        w = 25;
        for i = 1:size(d.endPoint,1)
            d.SubjSwitch(i,1) = nanmean([d.endPoint(i,351) d.endPoint(i,352)]) ;
            %d.SubjSwitch(i,1) = nanmean([d.endPoint(i,346:50) d.endPoint(i,351:355)]) ;
            dCtrl.SubjSwitch(i,1) = nanmean([dCtrl.endPoint(i,350) dCtrl.endPoint(i,351)]) ;
            dGrad.SubjSwitch(i,1) = nanmean([dGrad.endPoint(i,350) dGrad.endPoint(i,351)]) ;
        end
        
        for i = 1:size(d.endPoint,1)
            d.SubjEndPMean(i,1) = nanmean(d.endPoint(i,351-w:350));% - d.SubjSwitch(i) ;
            d.SubjEndPMean(i,2) = nanmean(d.endPoint(i,351:350+w));%  - d.SubjSwitch(i) ;
            dCtrl.SubjEndPMean(i,1) = nanmean(dCtrl.endPoint(i,351-w:350));% - dCtrl.SubjSwitch(i) ;
            dCtrl.SubjEndPMean(i,2) = nanmean(dCtrl.endPoint(i,351:350+w));%  - dCtrl.SubjSwitch(i) ;
            dGrad.SubjEndPMean(i,1) = nanmean(dGrad.endPoint(i,351-w:350));% - dGrad.SubjSwitch(i) ;
            dGrad.SubjEndPMean(i,2) = nanmean(dGrad.endPoint(i,351:350+w));%  - dGrad.SubjSwitch(i) ;
        end
        
        ttest(d.SubjEndPMean(:,2),d.SubjEndPMean(:,1),2,'paired')
        ttest(dCtrl.SubjEndPMean(:,2),dCtrl.SubjEndPMean(:,1),2,'paired')
        ttest(dGrad.SubjEndPMean(:,2),dGrad.SubjEndPMean(:,1),2,'paired')
        A = d.SubjEndPMean(:,2)-d.SubjEndPMean(:,1);
        B = dCtrl.SubjEndPMean(:,2)-dCtrl.SubjEndPMean(:,1);
        ttest(A,B,2,'independent')
        %close all
        
        w = 25;
                   %Gain: calculate difference in means per subject between last 25
              %adaptation and first 25 gain
              DifMeanReachGain =  mean(d.reachDir(:,351:350+w),2)- mean(d.reachDir(:,350-w+1:350),2);
              DifMeanErrorGain =  mean(d.endPoint(:,351:350+w),2)- mean(d.endPoint(:,350-w+1:350),2) ;
               
              
               
                             % Control:calculate difference in means per subject between last 25
              %adaptation and first 25 gain
              DifMeanReachControl =   mean(dCtrl.reachDir(:,351:376),2) - mean(dCtrl.reachDir(:,325:350),2);
              DifMeanErrorControl =  mean(dCtrl.endPoint(:,351:376),2) - mean(dCtrl.endPoint(:,325:350),2);
               
             
                             %Gradual: calculate difference in means per subject between last 25
              %adaptation and first 25 gain
              DifMeanReachGrad =  mean(dGrad.reachDir(:,351:376),2) - mean(dGrad.reachDir(:,325:350),2);
              DifMeanErrorGrad =   mean(dGrad.endPoint(:,351:376),2) - mean(dGrad.endPoint(:,325:350),2);
               
              [DifMeanErrorGain DifMeanErrorControl]
               %compare difference Gain - Control
               ttest(DifMeanErrorGain,DifMeanErrorControl,'1','independent')
        
        figure(11)
        
        subplot(1,3,1)
        hold on
        
        for i = 1:size(d.SubjEndPMean,1)
            plot([1 2],d.SubjEndPMean(i,:),'-or')
        end
        lineplot([ones(size(d.SubjEndPMean,1),1); 2*ones(size(d.SubjEndPMean,1),1)],d.SubjEndPMean(:),'style_thickline')
        
        subplot(1,3,2)
        hold on
        
        for i = 1:size(dCtrl.SubjEndPMean,1)
            plot([1 2],dCtrl.SubjEndPMean(i,:),'-ok')
        end
        lineplot([ones(size(dCtrl.SubjEndPMean,1),1); 2*ones(size(dCtrl.SubjEndPMean,1),1)],dCtrl.SubjEndPMean(:),'style_thickline')
        
        %dGrad.SubjEndPMean(8,:) = [];
        subplot(1,3,3)
        hold on
        for i = 1:size(dGrad.SubjEndPMean,1)
            plot([1 2],dGrad.SubjEndPMean(i,:),'-og')
        end
        lineplot([ones(size(dGrad.SubjEndPMean,1),1); 2*ones(size(dGrad.SubjEndPMean,1),1)],dGrad.SubjEndPMean(:),'style_thickline')
        
        1;
        [d.SubjEndPMean(:,2)-d.SubjEndPMean(:,1) dCtrl.SubjEndPMean(:,2)-dCtrl.SubjEndPMean(:,1)]*100
       
    case 'changereachdir'
        %% gain change
        window = 10;
        
        for i = 1:size(d.reachDir,1)
            %d.SubjSwitch(i,1) = mean([d.reachDir(i,350) d.reachDir(i,351)]) ;
            d.SubjSwitch(i,1) = mean([d.reachDir(i,341:350) d.reachDir(i,351:360)]) ;
            dCtrl.SubjSwitch(i,1) = mean([dCtrl.reachDir(i,350) dCtrl.reachDir(i,351)]) ;
            dGrad.SubjSwitch(i,1) = mean([dGrad.reachDir(i,350) dGrad.reachDir(i,351)]) ;
        end
        
        for i = 1:size(d.endPoint,1)
            d.SubjEndPMean(i,1) = mean(d.reachDir(i,351-window:350));% - d.SubjSwitch(i) ;
            d.SubjEndPMean(i,2) = mean(d.reachDir(i,351:350+window));%  - d.SubjSwitch(i) ;
            dCtrl.SubjEndPMean(i,1) = mean(dCtrl.reachDir(i,351-window:350));% - dCtrl.SubjSwitch(i) ;
            dCtrl.SubjEndPMean(i,2) = mean(dCtrl.reachDir(i,351:350+window));%  - dCtrl.SubjSwitch(i) ;
            dGrad.SubjEndPMean(i,1) = mean(dGrad.reachDir(i,351-window:350));% - dGrad.SubjSwitch(i) ;
            dGrad.SubjEndPMean(i,2) = mean(dGrad.reachDir(i,351:350+window));%  - dGrad.SubjSwitch(i) ;
        end
        
        ttest(d.SubjEndPMean(:,2),d.SubjEndPMean(:,1),1,'paired')
        ttest(dCtrl.SubjEndPMean(:,2),dCtrl.SubjEndPMean(:,1),1,'paired')
        ttest(dGrad.SubjEndPMean(:,2),dGrad.SubjEndPMean(:,1),1,'paired')
        close all
        figure(1)
        
        subplot(1,3,1)
        hold on
        
        for i = 1:size(d.SubjEndPMean,1)
            plot([1 2],d.SubjEndPMean(i,:),'-or')
        end
        lineplot([ones(size(d.SubjEndPMean,1),1); 2*ones(size(d.SubjEndPMean,1),1)],d.SubjEndPMean(:),'style_thickline')
        title('Gain')
        
        subplot(1,3,2)
        hold on
        
        for i = 1:size(dCtrl.SubjEndPMean,1)
            plot([1 2],dCtrl.SubjEndPMean(i,:),'-ok')
        end
        lineplot([ones(size(dCtrl.SubjEndPMean,1),1); 2*ones(size(dCtrl.SubjEndPMean,1),1)],dCtrl.SubjEndPMean(:),'style_thickline')
        title('Control')
        
        %dGrad.SubjEndPMean(8,:) = [];
        subplot(1,3,3)
        hold on
        for i = 1:size(dGrad.SubjEndPMean,1)
            plot([1 2],dGrad.SubjEndPMean(i,:),'-og')
        end
        lineplot([ones(size(dGrad.SubjEndPMean,1),1); 2*ones(size(dGrad.SubjEndPMean,1),1)],dGrad.SubjEndPMean(:),'style_thickline')
        title('Gradual')
        
        
end