function ANA = analyzeRecallData(what,varargin)
load('adaptrecall_alldat.mat')
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

excludesubjs = 1;

if(excludesubjs)
  d.reachDir(9,:) = [];
  d.endPoint(9,:) = [];
  d.reachDir(4,:) = [];
  d.endPoint(4,:) = [];
  dCtrl.reachDir(10,:) = [];
  dCtrl.endPoint(10,:) = [];
%  dCtrl.reachDir(7,:) = [];
%  dCtrl.endPoint(7,:) = [];
  dGrad.reachDir(5,:) = [];
  dGrad.endPoint(5,:) = [];
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

switch what
    
    case 'reachdirmean'
        %% mean reachdir
        figure(1); clf; hold on
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
        
        %plot(meanNaN(dGrad.reachDir)','m-','linewidth',2);
        
        
        xlabel('Trial Number')
        ylabel('Reach Direction')
        axis([0 620 -20 60])
        
    case 'endpointmean'
        %figure(1)
%         d.endPoint([4 9],:) = NaN;
%         dGrad.endPoint(5,:) = NaN;
        
        figure(1); clf; hold on
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
        axis([0 620 -.07 .15])
        
        
    case 'actualseenendpoints'
        %%


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
        plot(dGrad.EndX','-','color',[0 1 0],'linewidth',2);
        plot(dGrad.Xend','-','color',[0 1 0],'linewidth',2);
        
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
        plot(dGrad.EndY','-','color',[0 1 0],'linewidth',2);
        plot(meanNaN(dGrad.EndY),'g.-','linewidth',2)
        
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 610],[0 0],'k')
        axis([0 620 -.1 .2])
        
        
    case 'reachdirgain'
        %close all
        %for i = 1:length(d.subj)
            figure(1); clf; hold on
            
            %subplot(4,3,i)
            hold on
            plot(d.Ntrials',d.reachDir','color',.6*[1 1 1])
            
            plot([blkends; blkends],[-100 100],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-100 100],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Reach Direction')
            axis([0 620 -30 80])
            plot([0 610],[0 0],'k')
        %end
        plot(d.Ntrials,meanNaN(d.reachDir),'linewidth',2)
        
    case 'reachdircontrol'
        %close all
        %for i = 1:length(dCtrl.subj)
            
      
            figure(1); clf; hold on
            
            %subplot(4,3,i)
            hold on
            plot(dCtrl.Ntrials',dCtrl.reachDir','color',.6*[1 1 1])
            plot([blkends; blkends],[-100 100],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-100 100],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Reach Direction')
            axis([0 620 -30 80])
            plot([0 610],[0 0],'k')
        %end
        plot(d.Ntrials,meanNaN(dCtrl.reachDir),'r','linewidth',2)
        
    case 'reachdirgradual'
        %close all
        
        %for i = 1:length(dGrad.subj)
            
            figure(1); clf; hold on
            
            %subplot(4,3,i)
            hold on
            plot(dGrad.Ntrials',dGrad.reachDir','color',.6*[1 1 1])
            plot([blkends; blkends],[-100 100],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-100 100],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Reach Direction')
            axis([0 620 -30 80])
            plot([0 610],[0 0],'k')
        %end
        plot(d.Ntrials,meanNaN(dGrad.reachDir),'m','linewidth',2)
        
    case 'endpointgain'
        %close all
        %for i = 1:length(d.subj)
            
           figure(1); clf; hold on
            %subplot(4,3,i)
            hold on
            plot(d.Ntrials',d.endPoint','color',.6*[1 1 1])
            plot([blkends; blkends],[-15 15],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-15 15],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Endpoint')
            plot([0 610],[0 0],'k')
            axis([0 620 -7 15])
        %end
        plot(d.Ntrials,meanNaN(d.endPoint),'b','linewidth',2)
        %keyboard
    case 'endpointcontrol'
        %close all
        %for i = 1:length(dCtrl.subj)
            
           figure(1); clf; hold on
            %subplot(4,3,i)
            hold on
            plot(dCtrl.Ntrials',dCtrl.endPoint','color',.6*[1 1 1])
            plot([blkends; blkends],[-15 15],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-15 15],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Endpoint')
            plot([0 610],[0 0],'k')
            axis([0 620 -7 15])
        %end
        plot(d.Ntrials,meanNaN(dCtrl.endPoint),'r','linewidth',2)
        
    case 'endpointgradual'
        %close all
        %for i = 1:length(dGrad.subj)
            figure(1); clf; hold on
            %subplot(4,3,i)
            
            hold on
            plot(dGrad.Ntrials',dGrad.endPoint','color',.6*[1 1 1])
            plot([blkends; blkends],[-15 15],'k','linewidth',2)
            plot((blkends(3)+50)*[1 1],[-15 15],'k--','linewidth',2)
            xlabel('Trial Number')
            ylabel('Endpoint')
            plot([0 610],[0 0],'k')
            axis([0 620 -7 15])
        %end
        plot(d.Ntrials,meanNaN(dGrad.endPoint),'m','linewidth',2)
        
    case 'changeendpoint'
        %% gain change
        
%         for i = 1:size(d.endPoint,1)
%             d.SubjSwitch(i,1) = nanmean([d.endPoint(i,350) d.endPoint(i,351)]) ;
%             dCtrl.SubjSwitch(i,1) = nanmean([dCtrl.endPoint(i,350) dCtrl.endPoint(i,351)]) ;
%             dGrad.SubjSwitch(i,1) = nanmean([dGrad.endPoint(i,350) dGrad.endPoint(i,351)]) ;
%         end
        w = 25;
        for i = 1:size(d.endPoint,1)
            d.SubjEndPMean(i,1) = nanmean(d.endPoint(i,350-w+1:350)) ;
            d.SubjEndPMean(i,2) = nanmean(d.endPoint(i,351:350+w)) ;
            dCtrl.SubjEndPMean(i,1) = nanmean(dCtrl.endPoint(i,350-w+1:350))  ;
            dCtrl.SubjEndPMean(i,2) = nanmean(dCtrl.endPoint(i,351:350+w)) ;
            dGrad.SubjEndPMean(i,1) = nanmean(dGrad.endPoint(i,350-w+1:350))  ;
            dGrad.SubjEndPMean(i,2) = nanmean(dGrad.endPoint(i,351:350+w))  ;
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
        %% gain change
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
Endpoint1 = d.endPoint(:,325:350);
Endpoint2 = d.endPoint(:,351:376);
Endpoint = [Endpoint1 Endpoint2];
  vEndpointGa = reshape(permute(Endpoint,[2 1]),[length(Endpoint(:)) 1])*100 ;      
  vSubjGa =  kron(d.subj,ones(size(Endpoint,2),1));   
  
 Endpointco1 = dCtrl.endPoint(:,325:350);
 Endpointco2 = dCtrl.endPoint(:,351:376);
Endpointco = [Endpointco1 Endpointco2];
   vSubjCo =  kron(dCtrl.subj,ones(size(Endpointco,2),1));      
  vEndpointCo = reshape(permute(Endpointco,[2 1]),[length(Endpointco(:)) 1])*100 ;  
  
  Endpointgrad1 = dGrad.endPoint(:,325:350);
 Endpointgrad2 = dGrad.endPoint(:,351:376);
Endpointgrad = [Endpointgrad1 Endpointgrad2];
   vSubjGrad =  kron(dGrad.subj,ones(size(Endpointgrad,2),1));      
  vEndpointGrad = reshape(permute(Endpointgrad,[2 1]),[length(Endpointgrad(:)) 1])*100 ;      
  
  v.Subj = [vSubjGa(:); vSubjCo(:) ;vSubjGrad(:)];
  v.Endpoint = [vEndpointGa ; vEndpointCo ; vEndpointGrad];
  v.Group = [ones(length(vSubjGa(:)),1);2*ones(length(vSubjCo(:)),1); 3*ones(length(vSubjGrad(:)),1)];
  v.BeforeAfter = kron([ones(1,26) 2*ones(1,26)],ones(size([d.subj dCtrl.subj dGrad.subj],2),1))';
  
  
   results=anovaMixed(v.Endpoint,v.Subj, 'within',v.BeforeAfter(:) ,{'BeforeafterGain'},'between',v.Group,{'Group'},'intercept',1);

             
               lineplot(v.BeforeAfter(:),v.Endpoint,'split',v.Group,'leg','auto')
               
          
             
    case 'ttest_interaction' 
        %% ttest group

              w = 50;
              %Gain: calculate difference in means per subject between last 25
              %adaptation and first 25 gain
              DifMeanReachGain =  mean(d.reachDir(:,351:350+w),2)- mean(d.reachDir(:,351-w:350),2);
              DifMeanErrorGain =  mean(d.endPoint(:,351:350+w),2)- mean(d.endPoint(:,351-w:350),2) ;
               
              
               
              % Control:calculate difference in means per subject between last 25
              %adaptation and first 25 gain
              DifMeanReachControl =  mean(dCtrl.reachDir(:,351:350+w),2) - mean(dCtrl.reachDir(:,351-w:350),2);
              DifMeanErrorControl =  mean(dCtrl.endPoint(:,351:350+w),2) - mean(dCtrl.endPoint(:,351-w:350),2);
               
             
              %Gradual: calculate difference in means per subject between last 25
              %adaptation and first 25 gain
              DifMeanReachGrad =  mean(dGrad.reachDir(:,351:350+w),2) - mean(dGrad.reachDir(:,351-w:350),2);
              DifMeanErrorGrad =  mean(dGrad.endPoint(:,351:350+w),2) - mean(dGrad.endPoint(:,351-w:350),2);
               
              
               %compare difference Gain - Control
               ttest(DifMeanErrorGain,DifMeanErrorControl,1,'independent')
                %compare difference Gain - Grad
               ttest(DifMeanErrorGain,DifMeanErrorGrad,1,'independent')
                   %compare difference  Grad - Control 
               ttest(DifMeanErrorGrad,DifMeanErrorControl,2,'independent')
               
                  %compare difference Gain - Control
               ttest(DifMeanReachGain,DifMeanReachControl,1,'independent')
                %compare difference Gain - Grad
               ttest(DifMeanReachGain,DifMeanReachGrad,1,'independent')
                   %compare difference  Grad - Control 
               ttest(DifMeanReachGrad,DifMeanReachControl,2,'independent')
               
               
               
               
               
end