% using Lake Auburn (MELake75) data to produce method figures

%%%%%%%
%% I %%
%%%%%%%

% IMPORT DATA

data = nan(17,366); % blank multidimensional data array
% 17 years (rows) x 366 days (columns)

filename(75) = "MELake" + 75 + ".mat";
data(:,:) = importdata(filename(75)); % importdata(filename("MELake" + 75 + ".mat")); %

data(data==0)=NaN; % replace zeros that should be NaN

% reshape each lake's data into 1 column of 6222 days (17 years x 366 days)
data=data';
data=reshape(data,6222,1); % the data array is now 2-dimensional

% delete extra 366th day of non-leap years
data(6222,:) = []; %2018
data(5856,:) = []; %2017
data(5124,:) = []; %2015
data(4758,:) = []; %2014
data(4392,:) = []; %2013
data(3660,:) = []; %2011
data(3294,:) = []; %2010
data(2928,:) = []; %2009
data(2196,:) = []; %2007
data(1830,:) = []; %2006
data(1464,:) = []; %2005
data(732,:) = [];  %2003
data(366,:) = [];  %2002
% 'data' variable is now 6209x1 in size

% convert Kelvin to Celsius
LST=data-273.15;

% figure % make sure everything looks normal
% plot(LST,'.');

%%%%%%%%
%% II %%
%%%%%%%%

%% [METHOD 1] Moving Average
% each data point becomes the avg of [10, 20, or 30] days prior

LST_mavg(:,:)=movmean(LST(:,:),[30 0],'omitnan'); % try 30, 20, 10 days

figure % make sure everything looks normal
plot(LST_mavg);

%% [METHOD 2b] Cumulative Sum
% when n becomes positive, BEGIN a cumulative sum of only pos deg days
% STOP when the cumulative sum reaches 20deg
% meanwhile, if the cumulative sum of NEGATIVE deg reaches -20deg,
%               restart process 1 day later
% this restarts at each new year (n=1, n=366, n=731, etc.)

RunSum = NaN(6209,1); % blank output array

% ice-off
YRstart=366; % skip 2002 because MODIS data is not available until July
YRend=730;
n=YRstart;
while YRend < 6210
    while LST(n,1)<0 || isnan(LST(n,1))
        n = n+1;
    end
    oldstart=n; % first time in given yr that temp is above 0deg C
    push=n+1; % this will be used if summing starts too early
    c=0; % this variable contains the running sum of +deg
    cminus=0; % this variable contains the running sum of -deg
    while c < 20
        if LST(n,1)>0
            RunSum(n,1)=c+LST(n,1);
            c=c+LST(n,1);
        else
            RunSum(n,1)=c;
        end
        if LST(n,1)<0%
            cminus=cminus+LST(n,1);%
        end%
        n = n+1;
    end
    if cminus < -20
        while cminus < -20
            n=push;
            while LST(n,1)<0 || isnan(LST(n,1))
                n = n+1;
            end
            push=n+1; % update this for future use
            newstart=n-1;
            RunSum(oldstart:newstart,1) = NaN;
            oldstart=n; % update this for future use
            c=0; % this variable contains the running sum of +deg
            cminus=0; % this variable contains the running sum of -deg
            while c < 20%
                if LST(n,1)>0%
                    RunSum(n,1)=c+LST(n,1);%
                    c=c+LST(n,1);%
                else
                    RunSum(n,1)=c;%
                end%
                if LST(n,1)<0%
                cminus=cminus+LST(n,1);%
                end%
                n = n+1;%
            end
            
        end
    end
    if YRstart==731||YRstart==2192||YRstart==3653||YRstart==5114
        YRstart=YRstart+366;
    else
        YRstart=YRstart+365;
    end
    if YRend==730||YRend==2191||YRend==3652||YRend==5113
        YRend=YRend+366;
    else
        YRend=YRend+365;
    end
    n=YRstart;
end


% ice-on
NSUM = -40;
PSUM = 10;

RunSumIN = NaN(6209,1); % blank output array


YRstart=213; % Aug1,2002
YRend=577; % Jul31,2003
n=YRstart;
while YRend < 6210
    while LST(n,1)>0 || isnan(LST(n,1))
        n = n+1;
    end
    oldstart=n; % first time in given yr that temp is above 0deg C
    push=n+1; % this will be used if summing starts too early
    c=0; % this variable contains the running sum of -deg
    cplus=0; % this variable contains the running sum of +deg
    while c > NSUM
        if LST(n,1)<0
            RunSumIN(n,1)=c+LST(n,1);
            c=c+LST(n,1);
        else
            RunSumIN(n,1)=c;
        end
        if LST(n,1)>0%
            cplus=cplus+LST(n,1);%
        end%
        n = n+1;
    end
    if cplus > PSUM
        while cplus > PSUM
            n=push;
            while LST(n,1)>0 || isnan(LST(n,1))
                n = n+1;
            end
            push=n+1; % update this for future use
            newstart=n-1;
            RunSumIN(oldstart:newstart,1) = NaN;
            oldstart=n; % update this for future use
            c=0; % this variable contains the running sum of -deg
            cplus=0; % this variable contains the running sum of +deg
            while c > NSUM%
                if LST(n,1)<0%
                    RunSumIN(n,1)=c+LST(n,1);%
                    c=c+LST(n,1);%
                else
                    RunSumIN(n,1)=c;%
                end%
                if LST(n,1)>0%
                cplus=cplus+LST(n,1);%
                end%
                n = n+1;%
            end
            
        end
    end
    if YRstart==578||YRstart==2039||YRstart==3500||YRstart==4961
        YRstart=YRstart+366;
    else
        YRstart=YRstart+365;
    end
    if YRend==577||YRend==2038||YRend==3499||YRend==4960
        YRend=YRend+366;
    else
        YRend=YRend+365;
    end
    n=YRstart;
end


% %% FIGURES 2015-16
% 
% % METHOD 1
% figure
% hold on
% title('Method 1');
% plot(LST,'k.');
% plot(LST_mavg,'k');
% xlim([4930 5296])
% %ylim([-0.4 0.8])
% hline = refline(0, 0);
% hline.Color = 'k';
% plot(5099,0,'bo') % ice in approximation
% plot(5241,0,'ro') % ice out approximation
% plot(5132,0,'b*') % ice in observed - change to shading ice cover?
% plot(5191,0,'r*') % ice out observed
% hold off
% 
% %% METHOD 2
% figure
% hold on
% title('Method 2');
% plot(LST,'k.');
% xlim([4930 5296])
% %ylim([-0.4 0.8])
% hline = refline(0, 0);
% hline.Color = 'k';
% %hline.LineStyle = '--';
% hlineCP = refline(0, 20);
% hlineCP.Color = 'r';
% hlineCP.LineStyle = '--';
% hlineCN = refline(0, -20);
% hlineCN.Color = 'b';
% hlineCN.LineStyle = '--';
% plot(RunSum,'r');
% %plot(RunSum,'b');
% %plot(5099,0,'bo') % ice in approximation
% %plot(5241,0,'ro') % ice out approximation
% plot(5132,0,'b*') % ice in observed - change to shading ice cover?
% plot(5191,0,'r*') % ice out observed
% hold off

%% FIGURES 2014-15



% METHOD 1
figure
%subplot(2,1,1)
hold on
title('Method 1');
ylabel('?C');
xticks([4718 4749 4780 4808 4839 4869]);
xticklabels({'Dec','Jan','Feb','Mar','Apr','May'});
l1 = plot(LST,'k.');
l2 = plot(LST_mavg,'k');
xlim([4703 4899])
ylim([-45 25])
hline = refline(0, 0);
hline.Color = 'k';
hline.LineStyle = ':';
sh=area (4754:4861,repmat(40,1,108),-45);
sh(1).FaceColor=[0 0 0]; %[0.6 0.8 1];
sh(1).EdgeColor='none'; %[0.6 0.8 1];
alpha(sh,.075);
oic = 'O  B  S  E  R  V  E  D   I  C  E   C  O  V  E  R';
txt = text(4807.5,-40,oic,'HorizontalAlignment','center','Color',[1 1 1],'FontSize',16,'FontWeight','bold');
l3 = plot(4733,0,'bo'); % ice in approximation CHECK IT
l4 = plot(4875,0,'ro'); % ice out approximation CHECK IT

legend([l1 l2 l3 l4],'MODIS LST','moving average','ice in approximation','ice out approximation');

hold off



% METHOD 2
figure
%subplot(2,1,2)
hold on
title('Method 2');
ylabel('?C');
xticks([4718 4749 4780 4808 4839 4869]);
xticklabels({'Dec','Jan','Feb','Mar','Apr','May'});
la = plot(LST,'k.');
xlim([4703 4899])
ylim([-45 25])
hline = refline(0, 0);
hline.Color = 'k';
hline.LineStyle = ':';

lc = plot([4807.5,4899],[20,20],'r:'); % ice out positive limit
plot([4807.5,4899],[-20,-20],'b:'); % ice out negative limit
ld = plot([4860,4880],[6.2470,6.2470],'r--'); % ice out threshhold 6.2470 deg C

plot([4703,4807.5],[10,10],'r:'); % ice in positive limit
plot([4703,4807.5],[-40,-40],'b:'); % ice in negative limit
plot([4735,4755],[-25.4666,-25.4666],'b--'); % ice in threshhold -25.4666 deg C

% shaded region of observed ice cover
sh=area (4754:4861,repmat(40,1,108),-45);
sh(1).FaceColor=[0 0 0]; %[0.6 0.8 1];
sh(1).EdgeColor='none'; %[0.6 0.8 1];
alpha(sh,.075);
oic = 'O  B  S  E  R  V  E  D   I  C  E   C  O  V  E  R';
txt = text(4807.5,-40,oic,'HorizontalAlignment','center','Color',[1 1 1],'FontSize',16,'FontWeight','bold');

plot(RunSumIN,'b');
plot(RunSumNegIN(:,1),RunSumNegIN(:,2),'r');
plot(4745,-25.4666,'bo'); % in approx. is -3 = 2014 day 362 +4383(adding 2002-13)

lb = plot(RunSum,'r');
plot(RunSumNeg(:,1),RunSumNeg(:,2),'b');
le = plot(4870,6.2470,'ro'); % out approx. is 2015 day 122 +4748(adding 2002-14)

legend([la lb lc ld le],'MODIS LST','cumulative sums','cumulative sum limits','approximation thresholds','model approximations');

hold off
