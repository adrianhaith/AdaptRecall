function viewTrajs(data,trialrng)

figure(1); clf; hold on
Nr = 4; % number of subplot rows
% set up subplots
subplot(Nr,2,1); hold on
plot(trialrng,-data.reachDir(trialrng),'.','markersize',20,'color',.7*[1 1 1]);
xlabel('TrialNum')
ylabel('Initial Reach Direction')

subplot(Nr,2,3); hold on
for i=1:length(trialrng)
    plot(trialrng(i),data.X{trialrng(i)}(data.iEnd(trialrng(i))),'.','markersize',20,'color',.7*[1 1 1]);
end
xlabel('TrialNum')
ylabel('Endpoint X - offline')

subplot(Nr,2,5); hold on
for i=1:length(trialrng)
    plot(trialrng(i),data.X{trialrng(i)}(data.iReverse(trialrng(i))),'.','markersize',20,'color',.7*[1 1 1]);
end
xlabel('TrialNum')
ylabel('Endpoint X - offline')

for i=1:length(trialrng)
    ii = trialrng(i);
    
    %--- plot initial reach angle
    subplot(Nr,2,1); hold on
    plot(ii,-data.reachDir(ii),'r.','markersize',20);
    if(i>1)
        plot(trialrng(i-1),-data.reachDir(trialrng(i-1)),'k.','markersize',20)
    end
    
    %--- plot endpoint (max excursion)
    subplot(Nr,2,3); hold on
    plot(ii,data.X{ii}(data.iEnd(ii)),'r.','markersize',20);
    if(i>1)
        plot(trialrng(i-1),data.X{trialrng(i-1)}(data.iEnd(trialrng(i-1))),'k.','markersize',20)
    end
    
    %--- plot reversal point
    subplot(Nr,2,5); hold on
    plot(ii,data.X{ii}(data.iReverse(ii)),'r.','markersize',20);
    if(i>1)
        plot(trialrng(i-1),data.X{trialrng(i-1)}(data.iReverse(trialrng(i-1))),'k.','markersize',20)
    end    
    
    %--- plot velocity profile
    subplot(Nr,2,7); cla; hold on
    yvel = diff(savGolayFilt(data.Y{ii}',3,11));
    plot(yvel)
    plot([1 length(yvel)],[0 0],'k')
    plot(data.iEnd(ii),yvel(data.iEnd(ii)),'r.','markersize',15)
    plot(data.iRT(ii),yvel(data.iRT(ii)),'k.','markersize',15)
    plot(data.iDir(ii),yvel(data.iDir(ii)),'.','markersize',15)
    plot(data.iReverse(ii),yvel(data.iReverse(ii)),'.','markersize',15)
    ylabel('velocity')
    
    %--- plot trajectory
    subplot(Nr,2,2:2:2*Nr); cla; hold on   
    plot(0,0,'ko','linewidth',2)
    plot(0,.1,'go','linewidth',2,'markersize',20)
    %plot(data.X{ii}(data.RT(ii):data.iEnd(ii)),data.Y{ii}(data.RT(ii):data.iEnd(ii)),'linewidth',2)
    plot(data.X{ii},data.Y{ii},'color',.8*[1 1 1],'linewidth',2)
    plot(data.X{ii}(1:data.iEnd(ii)),data.Y{ii}(1:data.iEnd(ii)),'linewidth',2)
    plot(data.X{ii}(data.iRT(ii)),data.Y{ii}(data.iRT(ii)),'k.','markersize',20)
    plot(data.X{ii}(data.iDir(ii)),data.Y{ii}(data.iDir(ii)),'k.','markersize',20)
    plot(data.X{ii}(data.iEnd(ii)),data.Y{ii}(data.iEnd(ii)),'r.','markersize',20)
    plot(data.X{ii}(data.iReverse(ii)),data.Y{ii}(data.iReverse(ii)),'g.','markersize',20)
    axis([-.1 .1 -.02 .21])
    %axis equal
    
    
    
    
    pause
    
end
    
    