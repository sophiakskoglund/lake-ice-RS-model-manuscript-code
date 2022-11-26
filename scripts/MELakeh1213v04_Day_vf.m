%Code for Tile h12v04 h13v04 MELake01-70

clear all;
close all;

 
%Reading land cover data

LC_Type1_h12v04 = hdfread('D:\Maine Lakes Project\Land Cover\h12v04\MCD12Q1.A2015001.h12v04.006.2018055063055.hdf', '/MCD12Q1/Data Fields/LC_Type1', 'Index', {[1  1],[1  1],[2400  2400]});
LC_Type1_h12v04 = double(LC_Type1_h12v04); 

LC_Type1_h13v04 = hdfread('D:\Maine Lakes Project\Land Cover\h13v04\MCD12Q1.A2015001.h13v04.006.2018055063203.hdf', '/MCD12Q1/Data Fields/LC_Type1', 'Index', {[1  1],[1  1],[2400  2400]});
LC_Type1_h13v04 = double(LC_Type1_h13v04);
 
% Changing Land Cover Pixel from 2400 to 1200

LC=zeros(1200,2400);

LC_h12v04=zeros(1200,1200);

for k=1:1200*1200

    a=floor((k-1)/1200)*2400;

        LC_h12v04(k)= mode([LC_Type1_h12v04(a+2*k-1:a+2*k) LC_Type1_h12v04(a+2400+2*k-1:a+2400+2*k)]);

       

end

 LC_h13v04=zeros(1200,1200);

for k=1:1200*1200

    a=floor((k-1)/1200)*2400;

        LC_h13v04(k)= mode([LC_Type1_h13v04(a+2*k-1:a+2*k) LC_Type1_h13v04(a+2400+2*k-1:a+2400+2*k)]);

       

end

LC(:,:)=[LC_h12v04 LC_h13v04];



mlat_h12v04  = zeros(1200:1200);

mlon_h12v04 = zeros(1200:1200);

 

mlat_h13v04  = zeros(1200:1200);

mlon_h13v04 = zeros(1200:1200);


%y is the v of your file name

y = 4.00000;

%x is h

x = 12.00000;


%y is the v of your file name

v = 4.00000;

%x is h

w = 13.00000;
 


Water_MELake02=zeros(17,366);
Water_MELake46=zeros(17,366);
Water_MELake51=zeros(17,366);
Water_MELake58=zeros(17,366);
Water_MELake75=zeros(17,366);
Water_MELake88=zeros(17,366);
Water_MELake119=zeros(17,366);
Water_MELake124=zeros(17,366);
Water_MELake127=zeros(17,366);
Water_MELake132=zeros(17,366);
Water_MELake141=zeros(17,366);
Water_MELake155=zeros(17,366);
Water_MELake211=zeros(17,366);





%........................................................................

%MODIS Data Projection

for i=1:1200

 

    for j=1:1200

 

mlat_h12v04(i,j)=(rad2deg(((y+((i-1)/1200))-9)/-9)*pi/2);

mlon_h12v04(i,j)=(((x+((j-1)/1200)-18)*10))/cos(deg2rad(mlat_h12v04(i,1)));

 

    end

 

end

for i=1:1200

 

    for j=1:1200

 

mlat_h13v04(i,j)=(rad2deg(((v+((i-1)/1200))-9)/-9)*pi/2);

mlon_h13v04(i,j)=(((w+((j-1)/1200)-18)*10))/cos(deg2rad(mlat_h13v04(i,1)));

 

    end

 

end

%LEFT HAND SIDE TILE
mlon= zeros(1200,2400);
mlon(:,1:1200) = mlon_h12v04(:,:);
mlon(:,1201:2400) = mlon_h13v04(:,:);

mlat= zeros(1200,2400);
mlat(:,1:1200) = mlat_h12v04(:,:);
mlat(:,1201:2400) = mlat_h13v04(:,:);



%...................................................



pix_MELake02 = find(mlat>43.75283 & mlat<43.93655 & mlon>-70.66011 & mlon<-70.44381);
pix_MELake46 = find(mlat>45.81683 & mlat<45.87887 & mlon>-69.57508 & mlon<-69.48186);
pix_MELake51 = find(mlat>45.65448 & mlat<45.6945 & mlon>-68.91746 & mlon<-68.82253);
pix_MELake58 = find(mlat>44.97308 & mlat<45.0146 & mlon>-70.87151 & mlon<-70.80731);

pix_MELake75 = find(mlat>44.91328 & mlat<44.97743 & mlon>-70.77724 & mlon<-70.60866);
pix_MELake88 = find(mlat>43.94605 & mlat<43.96421 & mlon>-70.77719 & mlon<-70.75179);


pix_MELake119 = find(mlat>44.94557 & mlat<44.95925 & mlon> -69.95549 & mlon<-69.94336);
pix_MELake124 = find(mlat>43.90046 & mlat<43.94621 & mlon>-70.49254 & mlon<-70.44413);
pix_MELake127 = find(mlat>44.81886 & mlat<44.86657 & mlon>-69.78806 & mlon<-69.74206);
pix_MELake132 = find(mlat>44.23062 & mlat<44.29504 & mlon>-69.14195 & mlon<-69.07638);
pix_MELake141 = find(mlat>44.40705& mlat<44.4552 & mlon>-70.04918 & mlon<-70.00427);
pix_MELake155 = find(mlat>46.08138 & mlat<46.11043 & mlon>-68.06409 & mlon<-68.00006);
pix_MELake211 = find(mlat>44.52312 & mlat<44.55591 & mlon>-68.57393 & mlon<-68.50869);


% Land Subset (Land Cover)


S01LC_Water= LC(pix_MELake02);
S02LC_Water= LC(pix_MELake46); 
S03LC_Water= LC(pix_MELake51); 
S04LC_Water= LC(pix_MELake58); 
S05LC_Water= LC(pix_MELake75); 
S06LC_Water= LC(pix_MELake88); 
S07LC_Water= LC(pix_MELake119); 
S08LC_Water= LC(pix_MELake124); 
S09LC_Water= LC(pix_MELake127); 
S10LC_Water= LC(pix_MELake132); 

S11LC_Water= LC(pix_MELake141);
S12LC_Water= LC(pix_MELake155); 
S13LC_Water= LC(pix_MELake211); 


for yr = 2002:2018
lst=zeros(1200,2400);
%Change to your directory!   

for jd = 1:366

dirName1=['D:/Raw Data/h12v04'];
dirName2=['D:/Raw Data/h13v04'];


files1=dir(fullfile(dirName1,['MYD11A1.A' num2str(yr, '%04d') num2str(jd, '%03d') '*.hdf']));
files2=dir(fullfile(dirName2,['MYD11A1.A' num2str(yr, '%04d') num2str(jd, '%03d') '*.hdf']));


file_list1={files1.name}';
file_list2={files2.name}';


nfile1=numel(file_list1);
nfile2=numel(file_list2);




if nfile1>0

    disp(yr)

    disp(jd)

Fname1 = fullfile(dirName1,file_list1{1});
data1 = hdfread(Fname1, '/MODIS_Grid_Daily_1km_LST/Data Fields/LST_Day_1km', 'Index', ...
    {[1  1],[1  1],[1200  1200]});


if nfile2>0

    disp(yr)

    disp(jd)
    
Fname2 = fullfile(dirName2,file_list2{1});
data2 = hdfread(Fname2, '/MODIS_Grid_Daily_1km_LST/Data Fields/LST_Day_1km', 'Index', ...
    {[1  1],[1  1],[1200  1200]});

lst1 = double(data1);
lst2 = double(data2);


lst1 = lst1 *0.02;
lst2 = lst2 *0.02;

lst1(lst1<100) = NaN;
lst2(lst2<100) = NaN;

lst=[lst1 lst2];
%Water subset (Land Surface Temperature)

S01_Water = lst(pix_MELake02);
S02_Water = lst(pix_MELake46);
S03_Water = lst(pix_MELake51);
S04_Water = lst(pix_MELake58);
S05_Water = lst(pix_MELake75);
S06_Water = lst(pix_MELake88);
S07_Water = lst(pix_MELake119);
S08_Water = lst(pix_MELake124);
S09_Water = lst(pix_MELake127);
S10_Water = lst(pix_MELake132);

S11_Water = lst(pix_MELake141);
S12_Water = lst(pix_MELake155);
S13_Water = lst(pix_MELake211);



Water_MELake02(yr-2001,jd)=nanmean(S01_Water(S01LC_Water==17));
Water_MELake46(yr-2001,jd)=nanmean(S02_Water(S02LC_Water==17));
Water_MELake51(yr-2001,jd)=nanmean(S03_Water(S03LC_Water==17));
Water_MELake58(yr-2001,jd)=nanmean(S04_Water(S04LC_Water==17));
Water_MELake75(yr-2001,jd)=nanmean(S05_Water(S05LC_Water==17));
Water_MELake88(yr-2001,jd)=nanmean(S06_Water(S06LC_Water==17));
Water_MELake119(yr-2001,jd)=nanmean(S07_Water(S07LC_Water==17));
Water_MELake124(yr-2001,jd)=nanmean(S08_Water(S08LC_Water==17));
Water_MELake127(yr-2001,jd)=nanmean(S09_Water(S09LC_Water==17));
Water_MELake132(yr-2001,jd)=nanmean(S10_Water(S10LC_Water==17));

Water_MELake141(yr-2001,jd)=nanmean(S11_Water(S11LC_Water==17));
Water_MELake155(yr-2001,jd)=nanmean(S12_Water(S12LC_Water==17));
Water_MELake211(yr-2001,jd)=nanmean(S13_Water(S13LC_Water==17));


%..................................................... 

Water_MELake02(Water_MELake02<100)=NaN;
Water_MELake46(Water_MELake46<100)=NaN;
Water_MELake51(Water_MELake51<100)=NaN;
Water_MELake58(Water_MELake58<100)=NaN;
Water_MELake75(Water_MELake75<100)=NaN;
Water_MELake88(Water_MELake88<100)=NaN;
Water_MELake119(Water_MELake119<100)=NaN;
Water_MELake124(Water_MELake124<100)=NaN;
Water_MELake127(Water_MELake127<100)=NaN;
Water_MELake132(Water_MELake132<100)=NaN;

Water_MELake141(Water_MELake141<100)=NaN;
Water_MELake155(Water_MELake155<100)=NaN;
Water_MELake211(Water_MELake13<100)=NaN;


end

end

end
 
% saving Data file  
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake02.mat'],'Water_MELake02','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake46.mat'],'Water_MELake46','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake51.mat'],'Water_MELake51','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake58.mat'],'Water_MELake58','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake75.mat'],'Water_MELake75','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake88.mat'],'Water_MELake88','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake119.mat'],'Water_MELake119','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake124.mat'],'Water_MELake124','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake127.mat'],'Water_MELake127','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake132.mat'],'Water_MELake132','-v6');

save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake141.mat'],'Water_MELake141','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake155.mat'],'Water_MELake155','-v6');
save(['D:/Maine Lakes Project/H1213V04 Mat Files2/MELake211.mat'],'Water_MELake211','-v6');


end

 

% 
