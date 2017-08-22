function ANA = analyzeRecallData_New(what,excludesubjs,change)
baseDir = 'C:\Users\npopp\Dropbox (Personal)\AdaptRecall Drafts\Analysis';
baseDir = '/Users/nicola/Dropbox (Personal)/Canada/AdaptRecall Drafts/Analysis';
cd (baseDir);
load('RecallData_compact.mat')
%addpath Analysisnew/JoernCode


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
dGradLong.Block(101:280) = 2;
dGradLong.Block(281:380) = 3;
dGradLong.Block(381:580) = 4;

bad_trials_gain = [2 308; 2 396; 9 393; 9 396];
for i=1:length(bad_trials_gain)
    d.reachDir(bad_trials_gain(i,1),bad_trials_gain(i,2))= NaN;
    d.Xreverse(bad_trials_gain(i,1),bad_trials_gain(i,2))= NaN;
    d.endPoint(bad_trials_gain(i,1),bad_trials_gain(i,2))= NaN;

end

bad_trials_ctrl = [3 301; 3 398; 8 326; 8 333; 8 391; 8 392];
for i=1:length(bad_trials_ctrl)
    dCtrl.reachDir(bad_trials_ctrl(i,1),bad_trials_ctrl(i,2))= NaN;
    dCtrl.Xreverse(bad_trials_ctrl(i,1),bad_trials_ctrl(i,2))= NaN;
    dCtrl.endPoint(bad_trials_ctrl(i,1),bad_trials_ctrl(i,2))= NaN;
end

bad_trials_grad = [4 326; 4 327; 3 373; 7 330];
for i=1:length(bad_trials_grad)
    dGrad.reachDir(bad_trials_grad(i,1),bad_trials_grad(i,2))= NaN;
    dGrad.Xreverse(bad_trials_grad(i,1),bad_trials_grad(i,2))= NaN;
    dGrad.endPoint(bad_trials_grad(i,1),bad_trials_grad(i,2))= NaN;
end


%D.Subj = [kron((1:42)',ones(500,1));kron((43:56)',ones(580,1))];
%D.NTrials = [kron((1:42)',ones(500,1));kron((43:56)',ones(580,1))];
%D.Block = [kron((1:42)',ones(500,1));kron((43:56)',ones(580,1))];

D.Subj = kron((1:56)',ones(580,1));
D.Ntrials = repmat(dGradLong.Ntrials',56,1);
D.Block = repmat(dGradLong.Block(dGradLong.Block <5)',56,1);

ex1 = [d.endPoint(:,1:200), NaN(14,80),d.endPoint(:,201:500)]';
ex2 = [dCtrl.endPoint(:,1:200), NaN(14,80),dCtrl.endPoint(:,201:500)]';
ex3 = [dGrad.endPoint(:,1:200), NaN(14,80),dGrad.endPoint(:,201:500)]';
ex4 = dGradLong.endPoint(:,1:580)';
rx1 = [d.reachDir(:,1:200), NaN(14,80),d.reachDir(:,201:500)]';
rx2 = [dCtrl.reachDir(:,1:200), NaN(14,80),dCtrl.reachDir(:,201:500)]';
rx3 = [dGrad.reachDir(:,1:200), NaN(14,80),dGrad.reachDir(:,201:500)]';
rx4 = dGradLong.reachDir(:,1:580)';
xx1 = [d.Xreverse(:,1:200), NaN(14,80),d.Xreverse(:,201:500)]';
xx2 = [dCtrl.Xreverse(:,1:200), NaN(14,80),dCtrl.Xreverse(:,201:500)]';
xx3 = [dGrad.Xreverse(:,1:200), NaN(14,80),dGrad.Xreverse(:,201:500)]';
xx4 = dGradLong.Xreverse(:,1:580)';

D.endPoint = [ex1(:);ex2(:);ex3(:);ex4(:)];
D.reachDir = [rx1(:);rx2(:);rx3(:);rx4(:)];
D.Xreverse = [xx1(:);xx2(:);xx3(:);xx4(:)];
D.Exp = kron((1:4)',ones(580*14,1));
D.change = zeros(size(D.endPoint,1),2);

% change = how many trials after and before gain onset
ChangeTrials = change;
%Change = [zeros(350-ChangeTrials,1);ones(ChangeTrials,1);2*ones(ChangeTrials,1);zeros(500-(350+ChangeTrials),1)];
Change = [zeros(430-ChangeTrials,1);ones(ChangeTrials,1);2*ones(ChangeTrials,1);zeros(580-(430+ChangeTrials),1)];
D.change = repmat(Change,56,1);

if(excludesubjs)
    Exclude = [4,21,24,33,36];
  D =   getrow(D,D.Subj~= Exclude(1) & D.Subj~= Exclude(2)& D.Subj~= Exclude(3)& D.Subj~= Exclude(4)& D.Subj~= Exclude(5))
end


% if strcmp(what,'endpointmean') == 0
%     d.endPoint = d.endPoint*100;
%     dGrad.endPoint =  dGrad.endPoint*100;
%     dCtrl.endPoint = dCtrl.endPoint*100;
%     dGradLong.endPoint = dGradLong.endPoint*100;
% end
% if strcmp(what,'Anova') ~= 1
%

blklengths = [100 180 100 200];
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
        
        plot(nanmean(dGradLong.reachDir)','g-','linewidth',2);
        
        
        xlabel('Trial Number')
        ylabel('Reach Direction')
        axis([0 620 -20 60])
        
    case 'endpointmean'
        %mean endpint offset for gain,gradual and control
        CAT.errorbars = {'shade'};
        CAT.linecolor = {[1,0,0],[0,0,1],[0,1,0],[0.2,0.2,0.2]};
        CAT.markersize = 2;
        CAT.markerfill = {[1,0,0],[0,0,1],[0,1,0],[0.2,0.2,0.2]};
        CAT.shadecolor ={[1,0,0],[0,0,1],[0,1,0],[0.2,0.2,0.2]};
        CAT.markercolor = {[1,0,0],[0,0,1],[0,1,0],[0.2,0.2,0.2]};
        figure(1); hold on;
        lineplot(D.NTrials,D.endPoint,'split',D.Exp,'style_thickline','CAT',CAT)
         plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 500],[0 0],'k')
        axis([0 500 -.07 .12])
        
        
    case 'Xreversemean'
        
        CAT.errorbars = {'shade'};
        CAT.linecolor = {[1,0,0],[0,0,1],[0,1,0],[0.2,0.2,0.2]};
        CAT.markersize = 2;
        CAT.markerfill = {[1,0,0],[0,0,1],[0,1,0],[0.2,0.2,0.2]};
        CAT.shadecolor ={[1,0,0],[0,0,1],[0,1,0],[0.2,0.2,0.2]};
        CAT.markercolor = {[1,0,0],[0,0,1],[0,1,0],[0.2,0.2,0.2]};
        figure(1); hold on;
        lineplot(D.Ntrials,D.Xreverse,'split',D.Exp,'style_thickline','CAT',CAT)
         plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 580],[0 0],'k')
        axis([0 580 -.07 .12])
        
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
       
      
        ttest(D.endPoint(D.change == 1 & D.Exp == 1),D.endPoint(D.change == 2& D.Exp == 1),2,'paired');
        ttest(D.endPoint(D.change == 1& D.Exp == 2),D.endPoint(D.change == 2& D.Exp == 2),2,'paired');
        ttest(D.endPoint(D.change == 1& D.Exp == 3),D.endPoint(D.change == 2& D.Exp == 3),2,'paired');
        ttest(D.endPoint(D.change == 1& D.Exp == 4),D.endPoint(D.change == 2& D.Exp == 4),2,'paired');
       
        figure(2)
        for i = 1:length(unique(D.Exp))
        subplot(2,2,i)
        lineplot(D.change,D.endPoint,'split',D.Subj,'subset',D.Exp == i & D.change>0,'style_thickline','leg','auto');
        end

        
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

        X1 = tapply(D,{'Subj','change','Block','Exp'},{'Xreverse'},'subset',D.change>0)
        
        ttest(X1.Xreverse(X1.change == 2& X1.Exp == 1),X1.Xreverse(X1.change == 1 & X1.Exp == 1),2,'paired');
        ttest(X1.Xreverse(X1.change == 2& X1.Exp == 2),X1.Xreverse(X1.change == 1& X1.Exp == 2),2,'paired');
        ttest(X1.Xreverse(X1.change == 2& X1.Exp == 3),X1.Xreverse(X1.change == 1& X1.Exp == 3),2,'paired');
        ttest(X1.Xreverse(X1.change == 2& X1.Exp == 4),X1.Xreverse(X1.change == 1& X1.Exp == 4),2,'paired');
       
        figure(2); hold on;
        for i = 1:length(unique(X1.Exp))
        subplot(2,2,i)
        lineplot(X1.change,X1.Xreverse,'split',X1.Subj,'subset',X1.Exp == i & X1.change>0,'style_thickline');
        hold on;
        lineplot(X1.change(X.Exp == i),X1.Xreverse(X1.Exp == i),'style_thickline','markercolor','k','linecolor','k')
        end
        
       keyboard; 
      
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
        %Endpoint1 = d.Xreverse(:,326:350);
        %Endpoint2 = d.Xreverse(:,351:375);
        %Endpoint = [Endpoint1 Endpoint2];
        %vEndpointGa = reshape(permute(Endpoint,[2 1]),[length(Endpoint(:)) 1])*100 ;
        %vSubjGa =  kron(d.subj,ones(size(Endpoint,2),1));
        
        %Endpointco1 = dCtrl.Xreverse(:,326:350);
        %Endpointco2 = dCtrl.Xreverse(:,351:375);
        %Endpointco = [Endpointco1 Endpointco2];
        %vSubjCo =  kron(dCtrl.subj,ones(size(Endpointco,2),1));
        %vEndpointCo = reshape(permute(Endpointco,[2 1]),[length(Endpointco(:)) 1])*100 ;
        
        %Endpointgrad1 = dGrad.Xreverse(:,326:350);
        %Endpointgrad2 = dGrad.Xreverse(:,351:375);
        %Endpointgrad = [Endpointgrad1 Endpointgrad2];
        %vSubjGrad =  kron(dGrad.subj,ones(size(Endpointgrad,2),1));
        %vEndpointGrad = reshape(permute(Endpointgrad,[2 1]),[length(Endpointgrad(:)) 1])*100 ;
        %v.BeforeAfter = kron([ones(1,25) 2*ones(1,25)],ones(size([d.subj dCtrl.subj dGrad.subj],2),1))';
        
        %v.Subj = [vSubjGa(:); vSubjCo(:) ;vSubjGrad(:)];
        %v.Endpoint = [vEndpointGa ; vEndpointCo ; vEndpointGrad];
        %v.Group = [ones(length(vSubjGa(:)),1);2*ones(length(vSubjCo(:)),1); 3*ones(length(vSubjGrad(:)),1)];
        %v.BeforeAfter = v.BeforeAfter(:);
        
        %v.Group(isnan(v.Endpoint)) = [];
        %v.Subj(isnan(v.Endpoint)) = [];
        %v.BeforeAfter(isnan(v.Endpoint)) = [];
        %v.Endpoint(isnan(v.Endpoint)) = [];
      
        X1 = tapply(D,{'Subj','change','Block','Exp'},{'Xreverse'},'subset',D.change>0)
        
        results=anovaMixed(X.Xreverse,X.Subj,'within',X.change,{'BeforeafterGain'},'between',X.Exp,{'Exp'},'intercept',1);
        
        
        lineplot(X.change,X.Xreverse,'split',X.Exp,'leg','auto','style_thickline')
        
      
        
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