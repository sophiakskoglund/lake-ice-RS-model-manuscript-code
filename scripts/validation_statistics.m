%  File    :  validation_statistics.m
%  Title   :  Statistical Comparison of MODIS Model-Derived
%             Lake Ice In (freeze) or Out (melt) Dates and
%             in situ Dates
% 
%  Author         :  Sophia K. Skoglund
%  Last Revision  :  07/14/2024
%  Language       :  MATLAB R2023b Update 7 (23.2.0.2515942)
%                    + Statistics and Machine Learning Toolbox
%   
%  Input   :  CSM_icein_DOY.mat   &   insitu_icein_DOY.mat
%             16 (yrs 2002/03 - 17/18) x 13 (lakes)
%                               OR
%             CSM_iceout_DOY.mat  &   insitu_iceout_DOY.mat
%             16 (yrs 2002/03 - 17/18) x 58 (lakes)
%             
%             CSM_iceout_DOY_validation_20.mat  &   insitu_iceout_DOY_validation_20.mat
%             16 (yrs 2002/03 - 17/18) x 20 (lakes)
%
%             CSM_iceout_DOY_validation_58.mat  &   insitu_iceout_DOY_validation_58.mat
%             5 (yrs 2018/19 - 22/23) x 58 (lakes)
%             
%  Output  :  bias, mean average error, statistics
%             % of model approximations within _ days of error (array)
%             
%  Section Outline
%  (corresponding Roman numerals are the header of each script section)
%
%  I    prepare inputs
%  II   error (difference, model - in situ)   calculate overall bias
%  III  absolute value of error               calculate overall MAE
%  IV   linear model outputs
%  V    percent of model approximations within _ days of error
%  VI   MAE for each lake across all years
%
%  Next Steps
%  plot approximated and observed ice phenology (create figures)
%  using MS_figures.Rmd

%%%%%%%
%% I %%
%%%%%%%

% assign shorter variable names
IS = insitu_icein_DOY; % IS = in situ
RS = CSM_icein_DOY; % RS = Remote Sensing (CSM-approximated ice in/out)

seasoncount = 5; % # of rows in above variables
lakecount = 58; % # of columns in above variables

% reshape to single columns
IScolumn = reshape(IS,seasoncount*lakecount,1);
RScolumn = reshape(RS,seasoncount*lakecount,1);

%%%%%%%%
%% II %%
%%%%%%%%

% calculate model error (difference)
error = RScolumn-IScolumn;
% - value means RS is x days early, + value means RS is x days late

% calculate overall bias of the approximation model
bias = mean(error,"omitnan");

%%%%%%%%%
%% III %%
%%%%%%%%%

% calculate absolute value of model error
abserror = abs(error);

% calculate overall Mean Absolute Error (MAE)
MAE = mean(mean(abserror,"omitnan"),"omitnan");

%%%%%%%%
%% IV %%
%%%%%%%%

lm = fitlm(RScolumn,IScolumn); % linear regression model

r = sqrt(lm.Rsquared.Ordinary);
RMSE = lm.RMSE;
tvalue = lm.Coefficients.tStat(2,1);

% p-value, F-statistic, numerator degrees of freedom
[pvalue,F,df] = coefTest(lm);

%%%%%%%
%% V %%
%%%%%%%

percentbyerror = nan(max(abserror),1);

%totalplotted = lm.NumObservations;  %566 for ice out, 85 for ice in

for e=1:max(abserror) % from a 1-day error to the maximum error (e)
    val_e = sum(abserror <= e); % how many approximations <= e?
    percentbyerror(e,1) = (val_e/lm.NumObservations)*100;
    % add to array as a percent of the total model approximations made
end

%%%%%%%%
%% VI %%
%%%%%%%%

errorbylake = RS - IS;
errorbylake = errorbylake';
errorbylake = abs(errorbylake); % absolute value
MAEbylake = mean(errorbylake,2,'omitnan'); % MAE for each lake