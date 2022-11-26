%  File    :  CSM_icein.m
%  Title   :  Approximation of Lake Ice-In (freeze) Dates
%             using MODIS LST and the Cumulative Sum Method (CSM)
% 
%  Author         :  Sophia K. Skoglund (sophiakskoglund@gmail.com)
%  Last Revision  :  07/13/2021
%  Language       :  MATLAB R2017a (9.2.0.556344)
%   
%  Input   :  .mat files of MODIS Day LST in Kelvin, one per lake
%                our arrays are 17 (years 2002-18) x 366 (days)
%                and named MELake#.mat (# is the lake's project ID)
%
%             in addition, variable 'insitu_icein_DOT' must be imported
%
%  Output  :  ice-in approximations
%                our array is 16 (yrs 03-18) x 13 (lakes)
%                and named CSM_icein_DOT.mat & CSM_icein_DOY.mat
%
%  Section Outline
%  (corresponding Roman numerals are the header of each script section)
%
%  I    set counts, import data, reformat/reshape, convert to Celsius
%  II   Cumulative Sum Method (CSM)
%          a.  cumulative sum of - deg days with
%              limit on cumulative sum of + deg days
%          b.  find the average cumulative sum @ observed ice-in
%              ^ use this as a threshold (T) to flag ice-in conditions
%  III  use flag array to list possible ice-in days
%       sort into columns by lake
%  IV   translate ice-out approximations from DOT (1-6209) to DOY (1-366)
%
%  Next Steps
%  compare approximated and observed ice in using
%  validation_statistics.m (quantitative)
%  MS_figures.Rmd (figures)

%%%%%%%
%% I %%
%%%%%%%

% count
yrcount = 17;
daycount = yrcount*366;
lakecount = 13;

data = nan(yrcount,366,lakecount); % blank multidimensional data array
% _ years (rows) x 366 days (columns) x _ lakes (pages)

% IMPORT DATA
% make sure Current Folder is set to the Aqua MODIS day .mat files
% (our file names reflect lake project ID #s range from 1 to 216)

column = 1;
for k = 2
    filename(k) = "MELake0" + k + ".mat";
    data(:,:,column) = importdata(filename(k));
    column = column+1;
end

column = 2;
for k = [46,51,58,75,88,119,124,127,132,141,155,211]
    filename(k) = "MELake" + k + ".mat";
    data(:,:,column) = importdata(filename(k));
    column = column+1;
end

data(data==0) = NaN; % replace zeros that should be NaN

% reshape each lake's data into 1 column of _ days
data = permute(data,[2,1,3]);
data = reshape(data,daycount,lakecount); % the data array is now 2D

% delete extra 366th day of non-leap years: (change for your input)
%               2018, 17, 15, 14, 13, 11, 10, 09, 07, 06, 05, 03, 02
for multiplier = [ 0 , 1 , 3 , 4 , 5 , 7 , 8 , 9, 11, 12, 13, 15, 16 ]
    data(daycount-(366*multiplier),:) = [];
end

% 'data' variable is now 6209x216 in size
daycount = size(data,1);

% convert from Kelvin to Celsius
LST = data-273.15;



%%%%%%%%
%% II %%
%%%%%%%%

% Cumulative Sum Method (Ice In)
% when n becomes negative, BEGIN a cumulative sum of only - deg days
% STOP when the cumulative sum reaches -40deg
% meanwhile, if the cumulative sum of POSITIVE deg reaches 10deg,
%               restart process 1 day later
% this restarts at August of each new year (n=213,etc.)

CSum = NaN(daycount,lakecount); % blank output array
poslimit = 10;
neglimit = -40;

for k = 1:lakecount % for each lake (column)
YRstart = 213; % Aug1,2002
YRend = 577; % Jul31,2003
n = YRstart;
while YRend <= daycount
    while LST(n,k) > 0 || isnan(LST(n,k))
        n = n+1; % move one day forward until LST <= 0
    end
    firststart = n; % first time in given yr that temp is below 0deg C
    push = n+1; % this will be used if summing starts too early
    cpos = 0; % this variable contains the running sum of +deg
    cneg = 0; % this variable contains the running sum of -deg
    while cneg >= neglimit
        if LST(n,k) < 0 % if day is < 0deg C,
            cneg = cneg+LST(n,k); % add degrees to cneg
            CSum(n,k) = cneg; % add new cpos to CSum array
        else
            CSum(n,k) = cneg; % if day is > 0deg C, past sum carries over
        end
        if LST(n,k) > 0 % if day is > 0deg C,
            cpos = cpos+LST(n,k); % add degrees to cpos
        end
        n = n+1; % move one day forward and repeat until cneg < -40deg C
    end
    if cpos > poslimit % if cpos reaches 10deg by the time cneg reaches -40deg
        while cpos > poslimit
            n = push; % start cumulative sums one day later
            while LST(n,k) > 0 || isnan(LST(n,k))
                n = n+1;
            end
            push = n+1; % update this for future use
            beforenewstart = n-1;
            CSum(firststart:beforenewstart,k) = NaN;
            firststart = n; % update this for future use
            cpos = 0; % this variable contains the running sum of +deg
            cneg = 0; % this variable contains the running sum of -deg
            while cneg >= neglimit
                if LST(n,k) < 0
                    cneg = cneg+LST(n,k);
                    CSum(n,k) = cneg;
                else
                    CSum(n,k) = cneg;
                end
                if LST(n,k) > 0
                    cpos = cpos+LST(n,k);
                end
                n = n+1;
            end
        end
    end
    if YRstart==578||YRstart==2039||YRstart==3500||YRstart==4961
        YRstart = YRstart+366;
    else
        YRstart = YRstart+365;
    end
    if YRend==577||YRend==2038||YRend==3499||YRend==4960
        YRend = YRend+366;
    else
        YRend = YRend+365;
    end
    n = YRstart;
end
end

% find the average cumulative sum of + deg (CSum) @ observed ice in
% this becomes the Threshold (T) in degrees Celsius

% import insitu_icein_DOT variable
% Note: use Day of Total (1-daycount) rather than Day of Year (1-366)

CSum_at_insitu = NaN(yrcount-1,lakecount); % blank output array

for k = 1:lakecount % each lake
    for n = 1:(yrcount-1) % each year (not 2002)
        if isnan(insitu_icein_DOT(n,k))
            CSum_at_insitu(n,k) = NaN;
        else
            CSum_at_insitu(n,k) = CSum(insitu_icein_DOT(n,k),k);
        end
    end
end

T_bylake = mean(CSum_at_insitu,'omitnan');
T = mean(T_bylake,'omitnan'); % avg -deg accumulated before ice in
% in Skoglund et al. (2021), T = -25.4666 deg C for ice in

% Ice Phenology based on Cumulative Sum and Calculated Threshold
for k = 1:lakecount
    for n = 1:(daycount-1)
        if CSum(n,k) > T && CSum(n+1,k) > T
            icephen(n,k) = 1; % open water
        elseif CSum(n,k) < T && CSum(n+1,k) < T
            icephen(n,k) = -1; % ice cover
        elseif CSum(n,k) < T && isnan(CSum(n+1,k))
            icephen(n,k) = 1; % ice cover
        elseif CSum(n,k) > T && CSum(n+1,k) < T
            icephen(n,k) = .1; % possible ice in
        elseif isnan(CSum(n,k)) && CSum(n+1,k) < T
            icephen(n,k) = .1; % also possible ice in
        elseif isnan(CSum(n,k))
            icephen(n,k) = NaN;
        end
    end
end

%%%%%%%%%
%% III %%
%%%%%%%%%

% list days (DOT) of possible ice in
[DOT_row,lake_column] = find(icephen==.1);

% sort days of possible ice in into columns by lake
CSM_icein_DOT = NaN((yrcount-1),lakecount); % blank output array
lakenumber = 1;
i = 1; % row in sources (DOT_row,lake_column)
l = length(DOT_row);
j = 1; % row in output (CSM_icein_DOT)
while i <= l
   while lake_column(i,1) == lakenumber
       CSM_icein_DOT(j,lakenumber) = DOT_row(i,1);
       j = j+1;
       i = i+1;
   end
   lakenumber = lake_column(i,1); % sets to the next lake
   j = 1; % for the next lake, reset to output in row 1 of the next column
end

% NOTE: code currently breaks here bc "Index exceeds matrix dimensions."

%%%%%%%%
%% IV %%
%%%%%%%%

% to change ice-in approximations from DOT to DOY,
% subtract previous yrs' days from each row
CSM_icein_DOY(1,:)=CSM_icein_DOT(1,:)-((365*1)+(366*0)); % subtract 2002
CSM_icein_DOY(2,:)=CSM_icein_DOT(2,:)-((365*2)+(366*0)); % subtract 02-03
CSM_icein_DOY(3,:)=CSM_icein_DOT(3,:)-((365*2)+(366*1)); % subtract 02-04
CSM_icein_DOY(4,:)=CSM_icein_DOT(4,:)-((365*3)+(366*1)); % subtract 02-05
CSM_icein_DOY(5,:)=CSM_icein_DOT(5,:)-((365*4)+(366*1)); % subtract 02-06
CSM_icein_DOY(6,:)=CSM_icein_DOT(6,:)-((365*5)+(366*1)); % subtract 02-07
CSM_icein_DOY(7,:)=CSM_icein_DOT(7,:)-((365*5)+(366*2)); % subtract 02-08
CSM_icein_DOY(8,:)=CSM_icein_DOT(8,:)-((365*6)+(366*2)); % subtract 02-09
CSM_icein_DOY(9,:)=CSM_icein_DOT(9,:)-((365*7)+(366*2)); % subtract 02-10
CSM_icein_DOY(10,:)=CSM_icein_DOT(10,:)-((365*8)+(366*2)); % subtr. 02-11
CSM_icein_DOY(11,:)=CSM_icein_DOT(11,:)-((365*8)+(366*3)); % subtr. 02-12
CSM_icein_DOY(12,:)=CSM_icein_DOT(12,:)-((365*9)+(366*3)); % subtr. 02-13
CSM_icein_DOY(13,:)=CSM_icein_DOT(13,:)-((365*10)+(366*3)); % subt. 02-14
CSM_icein_DOY(14,:)=CSM_icein_DOT(14,:)-((365*11)+(366*3)); % subt. 02-15
CSM_icein_DOY(15,:)=CSM_icein_DOT(15,:)-((365*11)+(366*4)); % subt. 02-16
CSM_icein_DOY(16,:)=CSM_icein_DOT(16,:)-((365*12)+(366*4)); % subt. 02-17
% the first row is 2002-2003 season
% if negative, ice in is in 2002, if +, it's in 2003