function ANA = analyzeRecallData_New(what,excludesubjs,change,varargin)
baseDir = 'C:\Users\npopp\Dropbox (Personal)\AdaptRecall Drafts\Analysis';
baseDir = '/Users/nicola/Dropbox (Personal)/Canada/AdaptRecall Drafts/Analysis';
cd (baseDir);
load('RecallData_compact.mat');
%addpath Analysisnew/JoernCode

%setup data
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

% take out bad trials
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

%setup data structure
D.Subj = kron((1:56)',ones(580,1)); %56 subjects 580 to make it as long as the gradaul long case
D.Ntrials = repmat(dGradLong.Ntrials',56,1); %amount of trials
D.Block = repmat(dGradLong.Block(dGradLong.Block <5)',56,1);% block numbers

%bolster data with 80 extra NAN trials to account for long block leave out
%last washout
ex1 = [d.endPoint(:,1:100), NaN(14,80),d.endPoint(:,101:500)]';
ex2 = [dCtrl.endPoint(:,1:100), NaN(14,80),dCtrl.endPoint(:,101:500)]';
ex3 = [dGrad.endPoint(:,1:100), NaN(14,80),dGrad.endPoint(:,101:500)]';
ex4 = dGradLong.endPoint(:,1:580)';
rx1 = [d.reachDir(:,1:100), NaN(14,80),d.reachDir(:,101:500)]';
rx2 = [dCtrl.reachDir(:,1:100), NaN(14,80),dCtrl.reachDir(:,101:500)]';
rx3 = [dGrad.reachDir(:,1:100), NaN(14,80),dGrad.reachDir(:,101:500)]';
rx4 = dGradLong.reachDir(:,1:580)';
xx1 = [d.Xreverse(:,1:100), NaN(14,80),d.Xreverse(:,101:500)]';
xx2 = [dCtrl.Xreverse(:,1:100), NaN(14,80),dCtrl.Xreverse(:,101:500)]';
xx3 = [dGrad.Xreverse(:,1:100), NaN(14,80),dGrad.Xreverse(:,101:500)]';
xx4 = dGradLong.Xreverse(:,1:580)';

% add them together into new structure
D.endPoint = [ex1(:);ex2(:);ex3(:);ex4(:)];
D.reachDir = [rx1(:);rx2(:);rx3(:);rx4(:)];
D.Xreverse = [xx1(:);xx2(:);xx3(:);xx4(:)];
%add Experimental variable
D.Exp = kron((1:4)',ones(580*14,1));

% add a variable for how many trials before and after we want to look at
D.change = zeros(size(D.endPoint,1),2);
% change = how many trials after and before gain onset - variable depends
% on input
ChangeTrials = change;
%set the trials to 1 if before gain onset, 2 for after gain onset and 0 for
%all other trials
Change = [zeros(430-ChangeTrials,1);ones(ChangeTrials,1);2*ones(ChangeTrials,1);zeros(580-(430+ChangeTrials),1)];
D.change = repmat(Change,56,1);

%subj 54 doesn't quite go back to baseline not sure if that matters though
%subj 53 drifts down already during error clamp block
%subj 52 drifts up during error clamp
%subj 50 is kind of just all over the place
%subj 48 is drifting down in error clamp
% we had 33 taken out but not sure why really
%6 is moving up in error clamp
%40 is also kind of weird in the error clamp

%exclude subjects
if(excludesubjs)
    Exclude = [4,21,24,36,50,53];
    D =   getrow(D,D.Subj~= Exclude(1) & D.Subj~= Exclude(2)& D.Subj~= Exclude(3)& D.Subj~= Exclude(4)& D.Subj~= Exclude(5) & D.Subj~= Exclude(6));
end
%block boundaries for plotting purposes
blklengths = [100 180 100 200];
blkends = cumsum(blklengths);

switch what
    case 'Plot_sepSubj' % plot data for one subject use 'Subj' as varargin
        close all;
        Subj = 56;
        vararginoptions(varargin,{'Subj'});
        lineplot(D.Ntrials,D.Xreverse,'subset',D.Subj == Subj);
        drawline(0,'dir','horz')
        hold on;
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2)
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2)
        xlabel('Trial Number')
        ylabel('Endpoint')
        plot([0 580],[0 0],'k')
        axis([0 580 -.07 .12])
        
    case 'Plot_Xreversemean_all' % plot endpoint mean split by Exp
        
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
        
    case 'Plot_Xreverse_byExp' % plot endpoint mean for any Experiment you want use 'Exp' as varargin can also compare experiments
        close all;
        Exp =1;
        vararginoptions(varargin,{'Exp'});
        CAT.errorbars = {'shade'};
        
        if ~ismember(Exp,4)
            X = getrow(D,ismember(D.Exp,Exp) & ismember(D.Ntrials,[101:180]) ==0);
            blklengths = [100 100 100 200];
            blkends = cumsum(blklengths);
        else
            X = getrow(D,ismember(D.Exp,Exp));
        end
        figure(1); hold on;
        lineplot(repmat([1:length(unique(X.Ntrials))]',length(unique(X.Subj)),1),X.Xreverse,'split',X.Exp,'style_thickline','CAT',CAT);
        plot([blkends; blkends],[-.15 .15],'k','linewidth',2);
        plot((blkends(3)+50)*[1 1],[-.15 .15],'k--','linewidth',2);
        xlabel('Trial Number');
        ylabel('Endpoint');
        drawline(0,'dir','horz')
        ylim([-0.05,0.1])
        
    case 'Plot_change_Xreverse' % plot difference between before and after gain onset for each exp separately (subplots)
        % gain change
        
        X1 = tapply(D,{'Subj','change','Block','Exp'},{'Xreverse'},'subset',D.change>0);
        
        figure(2); hold on;
        for i = 1:length(unique(X1.Exp))
            subplot(2,2,i)
            lineplot(X1.change,X1.Xreverse,'split',X1.Subj,'subset',X1.Exp == i,'style_thickline');
            hold on;
            lineplot(X1.change,X1.Xreverse,'subset',X1.Exp ==i,'style_thickline','markercolor','k','linecolor','k');
        end
        
    case 'TTest_Change_PerExp' % perform paired 2-tailed t-test for whichever Exp you want use 'Exp' as varargin
        Exp = 1;
        vararginoptions(varargin, {'Exp'});
        X= tapply(D,{'Subj','Exp','change'},{'Xreverse'});
        ttest(X.Xreverse(X.change == 1 & X.Exp ==Exp),X.Xreverse(X.change == 2 & X.Exp ==Exp),2,'paired')
        
    case 'TTest_Change_combined34' % ttest for change for cominded groups 3&4
     
        X34 = tapply(D,{'Subj','change'},{'Xreverse'},'subset',D.change>0 & D.Exp>2)
        X34.Exp = ones(length(X34.Subj),1)*3;
        XGain = tapply(D,{'Subj','change','Exp'},{'Xreverse'},'subset',D.change>0 & D.Exp==1)
        Xall = addstruct(X34,XGain);
        
        unqExp = unique(Xall.Exp)';
        
        for i =  unqExp;
           ChangeExp{:,i} =  Xall.Xreverse(Xall.change == 2 & Xall.Exp == i) - Xall.Xreverse(Xall.change == 1  & Xall.Exp ==i);
        end
        
        ttest(ChangeExp{:,unqExp(1)}, ChangeExp{:,unqExp(2)},2,'independent');
        
    case 'Ttest_interaction_multi' % ttest for change difference between experiments choose any two experiment use 'Exp' as varargin
        Exp = [1,2];
        vararginoptions(varargin,{'Exp'});
        
        X1 = tapply(D,{'Subj','change','Exp'},{'Xreverse'},'subset',D.change>0 & ismember(D.Exp,Exp));
        unqExp = unique(X1.Exp)';
        
        for i =  unqExp;
           ChangeExp{:,i} =  X1.Xreverse(X1.change == 2 & X1.Exp == i) - X1.Xreverse(X1.change == 1  & X1.Exp ==i);
        end
        
        ttest(ChangeExp{:,unqExp(1)}, ChangeExp{:,unqExp(2)},2,'independent');
    
     case 'Ttest_interaction_34combinedvsgain' % ttest for change difference between experiments choose any two experiment use 'Exp' as varargin
        
        Exp = [1,2];
        vararginoptions(varargin,{'Exp'});
        
        X1 = tapply(D,{'Subj','change','Exp'},{'Xreverse'},'subset',D.change>0 & ismember(D.Exp,Exp));
        unqExp = unique(X1.Exp)';
        
        for i =  unqExp;
           ChangeExp{:,i} =  X1.Xreverse(X1.change == 2 & X1.Exp == i) - X1.Xreverse(X1.change == 1  & X1.Exp ==i);
        end
        
        ttest(ChangeExp{:,unqExp(1)}, ChangeExp{:,unqExp(2)},2,'independent');
     
        
        
    case 'Anova_mutli' % Anova choose which Experiments using 'Exp' as varargin, within - change variable, between - Exp variable
        
        Exp = [1,2];
        vararginoptions(varargin,{'Exp'});
        
        X1 = tapply(D,{'Subj','change','Exp'},{'Xreverse'},'subset',D.change>0)
        
        results=anovaMixed(X1.Xreverse,X1.Subj,'within',X1.change,{'BeforeafterGain'},'between',X1.Exp,{'Exp'},'intercept',1,'subset',ismember(X1.Exp,Exp));
        
    case 'Anova_combined34_vs_Gain' % Combine data from Experiments 3&4 and perform anova including gain
        
        X34 = tapply(D,{'Subj','change'},{'Xreverse'},'subset',D.change>0 & D.Exp>2)
        X34.Exp = ones(length(X34.Subj),1)*3;
        XGain = tapply(D,{'Subj','change','Exp'},{'Xreverse'},'subset',D.change>0 & D.Exp==1)
        Xall = addstruct(X34,XGain);
        
        results=anovaMixed(Xall.Xreverse,Xall.Subj,'within',Xall.change,{'BeforeafterGain'},'between',Xall.Exp,{'Exp'},'intercept',1);
        
    case 'Anova_All' % comprehensive Anova with all experimental conditions 1-4
        X1 = tapply(D,{'Subj','change','Exp'},{'Xreverse'},'subset',D.change>0 )
        
        results=anovaMixed(X1.Xreverse,X1.Subj,'within',X1.change,{'BeforeafterGain'},'between',X1.Exp,{'Exp'},'intercept',1);
        
    case 'Anova_All_combined34' % comprehensive Anova with experimental conditions 3&4 combined
        X34 = tapply(D,{'Subj','change'},{'Xreverse'},'subset',D.change>0 & D.Exp>2)
        X34.Exp = ones(length(X34.Subj),1)*3;
        XGain = tapply(D,{'Subj','change','Exp'},{'Xreverse'},'subset',D.change>0 & D.Exp<3)
        Xall = addstruct(X34,XGain);
        
        results=anovaMixed(Xall.Xreverse,Xall.Subj,'within',Xall.change,{'BeforeafterGain'},'between',Xall.Exp,{'Exp'},'intercept',1);
            
    case 'asymptote' % trying to come up with a good way to estimate when they hit asymptote but don't know how
        
        lineplot(D.Ntrials,D.Xreverse,'subset',D.Block ==2 & D.Exp == 1 & D.Ntrials>125)
        uSubj = unique(D.Subj(D.Exp ==1));
        for i = 1:length(unique(D.Subj(D.Exp ==1)))
            DiffSubj(i,:)  = diff(D.Xreverse(D.Block ==2 & D.Exp == 1 & D.Subj == uSubj(i) & D.Ntrials>125))
        end
        x= nanmedian(DiffSubj,2);
        
        for i = 1:length(unique(D.Subj(D.Exp ==1)))
            Xmax(i) = max(D.Xreverse(D.Block ==2 & D.Exp == 1 & D.Ntrials>120 & D.Subj == uSubj(i)));
            Xmedian(i) = nanmedian(D.Xreverse(D.Block ==2 & D.Exp == 1 & D.Ntrials>120 & D.Subj == uSubj(i)));
            Xfindmedian(i) = find(D.Xreverse(D.Block == 2& D.Exp == 1& D.Subj == uSubj(i) & D.Ntrials>120) >= Xmedian(i),1,'first')
            Xfindmax(i) = find(D.Xreverse(D.Block == 2& D.Exp == 1& D.Subj == uSubj(i) & D.Ntrials>120) >= Xmax(i),1,'first')
        end
        mean(Xfindmedian)
        mean(Xfindmax)
        
        
        
        
end