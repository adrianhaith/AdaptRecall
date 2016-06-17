function viewTrajs(data,trialrng)

figure(1); clf; hold on
% set up subplots
subplot(3,2,1); hold on
plot(trialrng,-data.reachDir(trialrng),'.','markersize',20,'color',.7*[1 1 1]);
xlabel('TrialNum')
ylabel('Initial Reach Direction')

subplot(3,2,3); hold on
for i=1:length(trialrng)
    plot(trialrng(i),data.X{trialrng(i)}(data.iEnd(trialrng(i))),'.','markersize',20,'color',.7*[1 1 1]);
end
xlabel('TrialNum')
ylabel('Endpoint X - offline')

subplot(3,2,5); hold on
plot(trialrng,data.tFile(trialrng,8),'.','markersize',20,'color',.7*[1 1 1]);
xlabel('TrialNum')
ylabel('Endpoint X - online')

for i=1:length(trialrng)
    ii = trialrng(i);
    
    %--- plot initial reach angle
    subplot(3,2,1); hold on
    plot(ii,-data.reachDir(ii),'r.','markersize',20);
    if(i>1)
        plot(trialrng(i-1),-data.reachDir(trialrng(i-1)),'k.','markersize',20)
    end
    
    %--- plot endpoint
    subplot(3,2,3); hold on
    plot(ii,data.X{ii}(data.iEnd(ii)),'r.','markersize',20);
    if(i>1)
        plot(trialrng(i-1),data.X{trialrng(i-1)}(data.iEnd(trialrng(i-1))),'k.','markersize',20)
    end
    
    subplot(3,2,5); hold on
    plot(ii,data.tFile(ii,8),'r.','markersize',20);
    if(i>1)
        plot(trialrng(i-1),data.tFile(trialrng(i-1),8),'k.','markersize',20)
    end
    
    %--- plot trajectory
    subplot(3,2,[2 4 6]); cla; hold on   
    plot(0,0,'ko','linewidth',2)
    plot(0,.08,'go','linewidth',2,'markersize',20)
    %plot(data.X{ii}(data.RT(ii):data.iEnd(ii)),data.Y{ii}(data.RT(ii):data.iEnd(ii)),'linewidth',2)
    plot(data.X{ii}(1:data.iEnd(ii)),data.Y{ii}(1:data.iEnd(ii)),'linewidth',2)
    plot(data.X{ii}(data.iDir(ii)),data.Y{ii}(data.iDir(ii)),'k.','markersize',20)
    plot(data.X{ii}(data.iEnd(ii)),data.Y{ii}(data.iEnd(ii)),'k.','markersize',20)
    axis([-.1 .1 -.02 .14])
    %axis equal
    
    
    
    
    pause
    
end
    
    