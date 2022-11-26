
clear ;
close all;

 
%Reading land cover raster files for tile h12v04 and h13v04

LC_Type1_h12v04 = hdfread('E:\Maine Lakes Project\Land Cover\h12v04\MCD12Q1.A2015001.h12v04.006.2018055063055.hdf', '/MCD12Q1/Data Fields/LC_Type1', 'Index', {[1  1],[1  1],[2400  2400]});
LC_Type1_h12v04 = double(LC_Type1_h12v04); 

LC_Type1_h13v04 = hdfread('E:\Maine Lakes Project\Land Cover\h13v04\MCD12Q1.A2015001.h13v04.006.2018055063203.hdf', '/MCD12Q1/Data Fields/LC_Type1', 'Index', {[1  1],[1  1],[2400  2400]});
LC_Type1_h13v04 = double(LC_Type1_h13v04);
 
% Changing Land Cover Pixel from 2400 to 1200 - Rescaling the spatial
% resolution of land cover
% from 500 m to 1000 m

LC=zeros(1200,2400);

LC_h12v04=zeros(1200,1200);

for k=1:1200*1200

    a=floor((k-1)/1200)*2400;

        LC_h12v04(k)= mode([LC_Type1_h12v04(2*k-1:a+2*k) LC_Type1_h12v04(a+2400+2*k-1:a+2400+2*k)]);

       

end

 LC_h13v04=zeros(1200,1200);

for k=1:1200*1200

    a=floor((k-1)/1200)*2400;

        LC_h13v04(k)= mode([LC_Type1_h13v04(a+2*k-1:a+2*k) LC_Type1_h13v04(a+2400+2*k-1:a+2400+2*k)]);

       

end

LC(:,:)=[LC_h12v04 LC_h13v04];

Water_MELake01=zeros(17,366);
Water_MELake02=zeros(17,366);
Water_MELake03=zeros(17,366);
Water_MELake04=zeros(17,366);
Water_MELake05=zeros(17,366);
Water_MELake06=zeros(17,366);
Water_MELake07=zeros(17,366);
Water_MELake08=zeros(17,366);
Water_MELake09=zeros(17,366);
Water_MELake10=zeros(17,366);

Water_MELake11=zeros(17,366);
Water_MELake12=zeros(17,366);
Water_MELake13=zeros(17,366);
Water_MELake14=zeros(17,366);
Water_MELake15=zeros(17,366);
Water_MELake16=zeros(17,366);
Water_MELake17=zeros(17,366);
Water_MELake18=zeros(17,366);
Water_MELake19=zeros(17,366);
Water_MELake20=zeros(17,366);

Water_MELake21=zeros(17,366);
Water_MELake22=zeros(17,366);
Water_MELake23=zeros(17,366);
Water_MELake24=zeros(17,366);
Water_MELake25=zeros(17,366);
Water_MELake26=zeros(17,366);
Water_MELake27=zeros(17,366);
Water_MELake28=zeros(17,366);
Water_MELake29=zeros(17,366);
Water_MELake30=zeros(17,366);

Water_MELake31=zeros(17,366);
Water_MELake32=zeros(17,366);
Water_MELake33=zeros(17,366);
Water_MELake34=zeros(17,366);
Water_MELake35=zeros(17,366);
Water_MELake36=zeros(17,366);
Water_MELake37=zeros(17,366);
Water_MELake38=zeros(17,366);
Water_MELake39=zeros(17,366);
Water_MELake40=zeros(17,366);

Water_MELake41=zeros(17,366);
Water_MELake42=zeros(17,366);
Water_MELake43=zeros(17,366);
Water_MELake44=zeros(17,366);
Water_MELake45=zeros(17,366);
Water_MELake46=zeros(17,366);
Water_MELake47=zeros(17,366);
Water_MELake48=zeros(17,366);
Water_MELake49=zeros(17,366);
Water_MELake50=zeros(17,366);

Water_MELake51=zeros(17,366);
Water_MELake52=zeros(17,366);
Water_MELake53=zeros(17,366);
Water_MELake54=zeros(17,366);
Water_MELake55=zeros(17,366);
Water_MELake56=zeros(17,366);
Water_MELake57=zeros(17,366);
Water_MELake58=zeros(17,366);
Water_MELake59=zeros(17,366);
Water_MELake60=zeros(17,366);

Water_MELake61=zeros(17,366);
Water_MELake62=zeros(17,366);
Water_MELake63=zeros(17,366);
Water_MELake64=zeros(17,366);
Water_MELake65=zeros(17,366);
Water_MELake66=zeros(17,366);
Water_MELake67=zeros(17,366);
Water_MELake68=zeros(17,366);
Water_MELake69=zeros(17,366);
Water_MELake70=zeros(17,366);


Water_MELake75=zeros(17,366);
Water_MELake76=zeros(17,366);
Water_MELake77=zeros(17,366);
Water_MELake81=zeros(17,366);
Water_MELake85=zeros(17,366);
Water_MELake88=zeros(17,366);



Water_MELake159=zeros(17,366);
Water_MELake97=zeros(17,366);
Water_MELake106=zeros(17,366);
Water_MELake107=zeros(17,366);
Water_MELake108=zeros(17,366);
Water_MELake109=zeros(17,366);
Water_MELake115=zeros(17,366);
Water_MELake116=zeros(17,366);
Water_MELake119=zeros(17,366);
Water_MELake123=zeros(17,366);
Water_MELake125=zeros(17,366);
Water_MELake127=zeros(17,366);
Water_MELake134=zeros(17,366);
Water_MELake141=zeros(17,366);
Water_MELake142=zeros(17,366);
Water_MELake144=zeros(17,366);
Water_MELake146=zeros(17,366);



%MODIS Data reprojection - From radian to decimal degree
mlat_h12v04  = zeros(1200:1200);
mlon_h12v04 = zeros(1200:1200);

mlat_h13v04  = zeros(1200:1200);
mlon_h13v04 = zeros(1200:1200);



y = 4.00000;
x = 12.00000;


v = 4.00000;
w = 13.00000;

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

%Combining h12v04 and h13v04 tiles in one tile
mlon= zeros(1200,2400);
mlon(:,1:1200) = mlon_h12v04(:,:);
mlon(:,1201:2400) = mlon_h13v04(:,:);

mlat= zeros(1200,2400);
mlat(:,1:1200) = mlat_h12v04(:,:);
mlat(:,1201:2400) = mlat_h13v04(:,:);




% subsetting small area surrounding the lake - 9 times greater than lake
% surface area
pix_MELake01 = find(mlat>45.43457 & mlat<45.89543 & mlon>-69.79692 & mlon<-69.45772);
pix_MELake02 = find(mlat>43.75283 & mlat<43.93655 & mlon>-70.66011 & mlon<-70.44381);
pix_MELake03 = find(mlat>45.16932 & mlat<45.21626 & mlon>-67.94667 & mlon<-67.87492);
pix_MELake04 = find(mlat>45.91124& mlat<46.01574 & mlon>-69.39121 & mlon<-69.2532);
pix_MELake05 = find(mlat>45.54783 & mlat<45.67535 & mlon>-67.68514 & mlon<-67.41717);
pix_MELake06 = find(mlat>45.10444 & mlat<45.22353 & mlon>-67.75705 & mlon<-67.6077);

pix_MELake07 = find(mlat>45.12975 & mlat<45.2662 & mlon>-70.50213 & mlon<-70.15194);
pix_MELake08 = find(mlat>45.63557& mlat<45.82298 & mlon>-67.87939 & mlon<-67.73382);
pix_MELake09 = find(mlat>44.83787 & mlat<44.96918 & mlon>-70.85894 & mlon<-70.72985);
pix_MELake10 = find(mlat>44.47554 & mlat<44.58837 & mlon>-69.8844 & mlon<-69.7996);


pix_MELake11 = find(mlat>46.22656 & mlat<46.31694 & mlon>-69.4256 & mlon<-69.31746);
pix_MELake12 = find(mlat>45.69095 & mlat<45.73698 & mlon>-69.0349 & mlon<-68.91371);
pix_MELake13 = find(mlat>45.62308 & mlat<45.73122 & mlon>-69.94625 & mlon<-69.86248);
pix_MELake14 = find(mlat>44.58121 & mlat<44.72872 & mlon>-68.452 & mlon<-68.35106);
pix_MELake15 = find(mlat>47.00357 & mlat<47.12237 & mlon>-68.63608 & mlon<-68.3779);
pix_MELake16 = find(mlat>46.27335 & mlat<46.31889 & mlon>-68.97275 & mlon<-68.81551);
pix_MELake17 = find(mlat>47.0062 & mlat<47.11355 & mlon>-68.43725 & mlon<-68.29237);
pix_MELake18 = find(mlat>44.69802 & mlat<44.82271 & mlon>-71.09972 & mlon<-70.98264);
pix_MELake19 = find(mlat>45.31673 & mlat<45.44199 & mlon>-68.97923 & mlon<-68.88962);
pix_MELake20 = find(mlat>45.47239 & mlat<45.54955 & mlon>-71.035303 & mlon<-70.92875);

pix_MELake21 = find(mlat>47.13448 & mlat<47.27956 & mlon>-68.32226 & mlon<-68.13892);
pix_MELake22 = find(mlat>45.47239 & mlat<45.54955 & mlon>-67.891 & mlon<-67.78217);
pix_MELake23 = find(mlat>45.25326 & mlat<45.31003 & mlon>-67.35346 & mlon<-67.11004);
pix_MELake24 = find(mlat>45.87062 & mlat<45.95661 & mlon>-69.98125 & mlon<-69.71895);
pix_MELake25 = find(mlat>45.25836 & mlat<45.34337 & mlon>-68.04041 & mlon<-67.97106);
pix_MELake26 = find(mlat>44.92119 & mlat<44.97392 & mlon>-70.77247 & mlon<-70.62004);
pix_MELake27 = find(mlat>43.96428 & mlat<44.13947 & mlon>-70.70482 & mlon<-70.58946);
pix_MELake28 = find(mlat>46.49575 & mlat<46.6239 & mlon>-68.33806 & mlon<-68.16537);
pix_MELake29 = find(mlat>45.39247 & mlat<45.49773 & mlon>-68.92906 & mlon< -68.85078);
pix_MELake30 = find(mlat>46.13716 & mlat<46.18246 & mlon>-68.82491 & mlon<-68.76277);

pix_MELake31 = find(mlat>46.15235 & mlat<46.25096 & mlon>-69.68401 & mlon<-69.53982);
pix_MELake32 = find(mlat>44.88227 & mlat<44.99843 & mlon>-68.86253 & mlon<-68.74099);
pix_MELake33 = find(mlat>44.15081 & mlat<44.20892 & mlon>-69.50764 & mlon<-69.4479);
pix_MELake34 = find(mlat>44.80621 & mlat<44.91914 & mlon>-70.95037 & mlon<-70.82952);
pix_MELake35 = find(mlat>45.92629 & mlat<45.95303 & mlon>-68.25111 & mlon<-68.22571);
pix_MELake36 = find(mlat>44.82167 & mlat<44.9134 & mlon>-69.31114 & mlon<-69.16626);
pix_MELake37 = find(mlat>43.99862 & mlat<44.13725 & mlon>-70.52369 & mlon<-70.44884);
pix_MELake38 = find(mlat>46.26853 & mlat<46.34809 & mlon>-69.58711 & mlon<-69.47238);
pix_MELake39 = find(mlat>44.28977 & mlat<44.35658 & mlon> -70.12085& mlon<-70.05339);
pix_MELake40 = find(mlat>44.38663 & mlat<44.49253 & mlon>-69.62282 & mlon<-69.48755);

pix_MELake41 = find(mlat>44.88624 & mlat<44.94899 & mlon>-69.58164 & mlon<-69.46018);
pix_MELake42 = find(mlat>44.7372 & mlat<44.81153 & mlon>-67.40048 & mlon<-67.31465);
pix_MELake43 = find(mlat>44.42846 & mlat<44.51358 & mlon>-69.8296 & mlon<-69.75442);
pix_MELake44 = find(mlat>45.23223 & mlat<45.29963 & mlon>-68.57324 & mlon<-68.50355);
pix_MELake45 = find(mlat>46.4253 & mlat<46.47863 & mlon>--69.36825 & mlon<-69.25326);
pix_MELake46 = find(mlat>45.81683 & mlat<45.87887 & mlon>-69.57508 & mlon<-69.48186);
pix_MELake47 = find(mlat>45.61472 & mlat<45.67893 & mlon>-69.4499 & mlon<-69.32229);
pix_MELake48 = find(mlat>44.91626 & mlat<44.98138 & mlon>-67.45592 & mlon<-67.34091);
pix_MELake49 = find(mlat>45.44786 & mlat<45.57465 & mlon>-69.89173 & mlon<-69.7489);
pix_MELake50 = find(mlat>44.61158 & mlat<44.67411 & mlon>-68.5617 & mlon<-68.43742);

pix_MELake51 = find(mlat>45.65448 & mlat<45.6945 & mlon>-68.91746 & mlon<-68.82253);
pix_MELake52 = find(mlat>44.73873 & mlat<44.80821 & mlon>-70.94978 & mlon<-70.83328);
pix_MELake53 = find(mlat>45.59048 & mlat<45.65438 & mlon>-68.90659 & mlon<-68.79278);
pix_MELake54 = find(mlat>45.60138 & mlat<45.68732 & mlon>-70.18274 & mlon<-69.99219);
pix_MELake55 = find(mlat>44.56079 & mlat<44.63512 & mlon>-68.59871 & mlon<-68.50499);
pix_MELake56 = find(mlat>46.46375 & mlat<46.53413 & mlon>-69.6536 & mlon<-69.57498);
pix_MELake57 = find(mlat>45.54662 & mlat<45.59421 & mlon>-70.35895 & mlon<-70.23501);
pix_MELake58 = find(mlat>44.97308 & mlat<45.0146 & mlon>-70.87151 & mlon<-70.80731);
pix_MELake59 = find(mlat>44.17127 & mlat<44.2467 & mlon>-70.92849 & mlon<-70.87751);
pix_MELake60 = find(mlat>45.77279 & mlat<45.86969 & mlon>-69.41752 & mlon<-69.33306);

pix_MELake61 = find(mlat>46.28989 & mlat<46.34053 & mlon>-68.69847 & mlon<-68.62706);
pix_MELake62 = find(mlat>44.6158 & mlat<44.68117 & mlon>-69.36368 & mlon<-69.3);
pix_MELake63 = find(mlat>46.79645 & mlat<46.86187 & mlon> -68.8002 & mlon<-68.73978);
pix_MELake64 = find(mlat>45.11678 & mlat<45.15511 & mlon>-67.95475 & mlon<-67.89151);
pix_MELake65 = find(mlat>45.94698 & mlat<46.00222 & mlon>-68.20112 & mlon<-68.12628);
pix_MELake66 = find(mlat>45.11439 & mlat<45.17041 & mlon>-67.5764 & mlon<-67.50448);
pix_MELake67 = find(mlat>47.07282 & mlat<47.15231 & mlon>-68.37549 & mlon<-68.30317);
pix_MELake68 = find(mlat>44.47393 & mlat<44.52278 & mlon>-68.63193 & mlon<-68.57151);
pix_MELake69 = find(mlat>46.90621 & mlat<47.01427 & mlon>-68.65243 & mlon<-68.57072);
pix_MELake70 = find(mlat>46.16312 & mlat<46.23892 & mlon>-69.34321 & mlon<-69.14271);

pix_MELake75 = find(mlat>44.12263 & mlat<44.17757 & mlon>-70.2906 & mlon<-70.2197);
pix_MELake76 = find(mlat>46.74659 & mlat<46.82463 & mlon>-68.5709 & mlon<-68.45245);
pix_MELake77 = find(mlat>44.59667 & mlat<44.64969 & mlon>-69.87713 & mlon<-69.81225);
pix_MELake81 = find(mlat>44.65316 & mlat<44.71966 & mlon>-70.48403 & mlon<-70.41655);
pix_MELake85 = find(mlat>43.82681 & mlat<43.92611 & mlon>-70.43961 & mlon<-70.38554);
pix_MELake88 = find(mlat>44.11362 & mlat<44.17679 & mlon>-70.12607 & mlon<-70.07646);
pix_MELake97 = find(mlat>43.90218 & mlat<43.94587 & mlon>-70.48831 & mlon<-70.44642);
pix_MELake106 = find(mlat>44.22198 & mlat<44.29499 & mlon>-69.13722 & mlon<-69.0761);
pix_MELake107 = find(mlat>44.42902 & mlat<44.51403 & mlon>-69.83013 & mlon<-69.76112);
pix_MELake108 = find(mlat>44.36907 & mlat<44.37423 & mlon>-69.67451 & mlon<-69.66913);

pix_MELake109 = find(mlat>43.9667 & mlat<44.09407 & mlon>-70.8279 & mlon<-70.77571);
pix_MELake115 = find(mlat>46.99724 & mlat<47.04778 & mlon>-68.2376 & mlon<-68.1849);
pix_MELake116 = find(mlat>43.99967 & mlat<44.09764 & mlon>-69.47659 & mlon<-69.43024);
pix_MELake119 = find(mlat>44.91079 & mlat<44.96778 & mlon> -69.96525 & mlon<-69.92336);
pix_MELake123 = find(mlat>44.66873 & mlat<44.71071 & mlon>-68.49809 & mlon<-68.42771);
pix_MELake125 = find(mlat>44.24253 & mlat<44.30679 & mlon>-70.00928 & mlon<-69.96379);
pix_MELake127 = find(mlat>44.81886 & mlat<44.86657 & mlon>-69.78806 & mlon<-69.74206);
pix_MELake134 = find(mlat>44.86944 & mlat<44.90094 & mlon>-69.14294 & mlon<-69.06638);
pix_MELake141 = find(mlat>44.40705& mlat<44.4552 & mlon>-70.04918 & mlon<-70.00427);
pix_MELake142 = find(mlat>44.39062 & mlat<44.42827 & mlon>-69.67938 & mlon<-69.63294);
pix_MELake144 = find(mlat>44.80413 & mlat<44.84066 & mlon>-68.60302 & mlon<-68.54688);
pix_MELake146 = find(mlat>44.33429 & mlat<44.38172 & mlon>-69.4527 & mlon<-69.40412);




% subsetting land cover files
S01LC_Water= LC(pix_MELake01);
S02LC_Water= LC(pix_MELake02); 
S03LC_Water= LC(pix_MELake03); 
S04LC_Water= LC(pix_MELake04); 
S05LC_Water= LC(pix_MELake05); 
S06LC_Water= LC(pix_MELake06); 
S07LC_Water= LC(pix_MELake07); 
S08LC_Water= LC(pix_MELake08); 
S09LC_Water= LC(pix_MELake09); 
S10LC_Water= LC(pix_MELake10); 

S11LC_Water= LC(pix_MELake11);
S12LC_Water= LC(pix_MELake12); 
S13LC_Water= LC(pix_MELake13); 
S14LC_Water= LC(pix_MELake14); 
S15LC_Water= LC(pix_MELake15); 
S16LC_Water= LC(pix_MELake16); 
S17LC_Water= LC(pix_MELake17); 
S18LC_Water= LC(pix_MELake18); 
S19LC_Water= LC(pix_MELake19); 
S20LC_Water= LC(pix_MELake20);

S21LC_Water= LC(pix_MELake21);
S22LC_Water= LC(pix_MELake22); 
S23LC_Water= LC(pix_MELake23); 
S24LC_Water= LC(pix_MELake24); 
S25LC_Water= LC(pix_MELake25); 
S26LC_Water= LC(pix_MELake26); 
S27LC_Water= LC(pix_MELake27); 
S28LC_Water= LC(pix_MELake28); 
S29LC_Water= LC(pix_MELake29); 
S30LC_Water= LC(pix_MELake30);

S31LC_Water= LC(pix_MELake31);
S32LC_Water= LC(pix_MELake32); 
S33LC_Water= LC(pix_MELake33); 
S34LC_Water= LC(pix_MELake34); 
S35LC_Water= LC(pix_MELake35); 
S36LC_Water= LC(pix_MELake36); 
S37LC_Water= LC(pix_MELake37); 
S38LC_Water= LC(pix_MELake38); 
S39LC_Water= LC(pix_MELake39); 
S40LC_Water= LC(pix_MELake40);

S41LC_Water= LC(pix_MELake41);
S42LC_Water= LC(pix_MELake42); 
S43LC_Water= LC(pix_MELake43); 
S44LC_Water= LC(pix_MELake44); 
S45LC_Water= LC(pix_MELake45); 
S46LC_Water= LC(pix_MELake46); 
S47LC_Water= LC(pix_MELake47); 
S48LC_Water= LC(pix_MELake48); 
S49LC_Water= LC(pix_MELake49); 
S50LC_Water= LC(pix_MELake50);

S51LC_Water= LC(pix_MELake51);
S52LC_Water= LC(pix_MELake52); 
S53LC_Water= LC(pix_MELake53); 
S54LC_Water= LC(pix_MELake54); 
S55LC_Water= LC(pix_MELake55); 
S56LC_Water= LC(pix_MELake56); 
S57LC_Water= LC(pix_MELake57); 
S58LC_Water= LC(pix_MELake58); 
S59LC_Water= LC(pix_MELake59); 
S60LC_Water= LC(pix_MELake60);

S61LC_Water= LC(pix_MELake61);
S62LC_Water= LC(pix_MELake62); 
S63LC_Water= LC(pix_MELake63); 
S64LC_Water= LC(pix_MELake64); 
S65LC_Water= LC(pix_MELake65); 
S66LC_Water= LC(pix_MELake66); 
S67LC_Water= LC(pix_MELake67); 
S68LC_Water= LC(pix_MELake68); 
S69LC_Water= LC(pix_MELake69); 
S70LC_Water= LC(pix_MELake70);

S75LC_Water= LC(pix_MELake75); 
S76LC_Water= LC(pix_MELake76); 
S77LC_Water= LC(pix_MELake77); 
S81LC_Water= LC(pix_MELake81); 
S85LC_Water= LC(pix_MELake85); 
S88LC_Water= LC(pix_MELake88);


S97LC_Water= LC(pix_MELake97); 
S106LC_Water= LC(pix_MELake106); 
S107LC_Water= LC(pix_MELake107); 
S108LC_Water= LC(pix_MELake108); 
 
 
S109LC_Water= LC(pix_MELake109);
S115LC_Water= LC(pix_MELake115);
S116LC_Water= LC(pix_MELake116); 
S119LC_Water= LC(pix_MELake119); 
S123LC_Water= LC(pix_MELake123); 
S125LC_Water= LC(pix_MELake125); 
S127LC_Water= LC(pix_MELake127); 
S134LC_Water= LC(pix_MELake134); 
S141LC_Water= LC(pix_MELake141); 
S142LC_Water= LC(pix_MELake142); 
S144LC_Water= LC(pix_MELake144);
S146LC_Water= LC(pix_MELake146); 


 
 
% reading the LST data from 2002 to 2018
for yr = 2002:2018
lst=zeros(1200,2400);
  

for jd = 1:366

dirName1=['E:/Raw Data/h12v04'];
dirName2=['E:/Raw Data/h13v04'];


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
data1 = hdfread(Fname1, '/MODIS_Grid_Daily_1km_LST/Data Fields/LST_Night_1km', 'Index', ...
    {[1  1],[1  1],[1200  1200]});


if nfile2>0

    disp(yr)

    disp(jd)
    
Fname2 = fullfile(dirName2,file_list2{1});
data2 = hdfread(Fname2, '/MODIS_Grid_Daily_1km_LST/Data Fields/LST_Night_1km', 'Index', ...
    {[1  1],[1  1],[1200  1200]});

lst1 = double(data1);
lst2 = double(data2);


lst1 = lst1 *0.02;
lst2 = lst2 *0.02;

lst1(lst1<100) = NaN;
lst2(lst2<100) = NaN;

lst=[lst1 lst2];
 
%subsetting LST data

S01_Water = lst(pix_MELake01);
S02_Water = lst(pix_MELake02);
S03_Water = lst(pix_MELake03);
S04_Water = lst(pix_MELake04);
S05_Water = lst(pix_MELake05);
S06_Water = lst(pix_MELake06);
S07_Water = lst(pix_MELake07);
S08_Water = lst(pix_MELake08);
S09_Water = lst(pix_MELake09);
S10_Water = lst(pix_MELake10);

S11_Water = lst(pix_MELake11);
S12_Water = lst(pix_MELake12);
S13_Water = lst(pix_MELake13);
S14_Water = lst(pix_MELake14);
S15_Water = lst(pix_MELake15);
S16_Water = lst(pix_MELake16);
S17_Water = lst(pix_MELake17);
S18_Water = lst(pix_MELake18);
S19_Water = lst(pix_MELake19);
S20_Water = lst(pix_MELake20);

S21_Water = lst(pix_MELake21);
S22_Water = lst(pix_MELake22);
S23_Water = lst(pix_MELake23);
S24_Water = lst(pix_MELake24);
S25_Water = lst(pix_MELake25);
S26_Water = lst(pix_MELake26);
S27_Water = lst(pix_MELake27);
S28_Water = lst(pix_MELake28);
S29_Water = lst(pix_MELake29);
S30_Water = lst(pix_MELake30);

S31_Water = lst(pix_MELake31);
S32_Water = lst(pix_MELake32);
S33_Water = lst(pix_MELake33);
S34_Water = lst(pix_MELake34);
S35_Water = lst(pix_MELake35);
S36_Water = lst(pix_MELake36);
S37_Water = lst(pix_MELake37);
S38_Water = lst(pix_MELake38);
S39_Water = lst(pix_MELake39);
S40_Water = lst(pix_MELake40);

S41_Water = lst(pix_MELake41);
S42_Water = lst(pix_MELake42);
S43_Water = lst(pix_MELake43);
S44_Water = lst(pix_MELake44);
S45_Water = lst(pix_MELake45);
S46_Water = lst(pix_MELake46);
S47_Water = lst(pix_MELake47);
S48_Water = lst(pix_MELake48);
S49_Water = lst(pix_MELake49);
S50_Water = lst(pix_MELake50);

S51_Water = lst(pix_MELake51);
S52_Water = lst(pix_MELake52);
S53_Water = lst(pix_MELake53);
S54_Water = lst(pix_MELake54);
S55_Water = lst(pix_MELake55);
S56_Water = lst(pix_MELake56);
S57_Water = lst(pix_MELake57);
S58_Water = lst(pix_MELake58);
S59_Water = lst(pix_MELake59);
S60_Water = lst(pix_MELake60);

S61_Water = lst(pix_MELake61);
S62_Water = lst(pix_MELake62);
S63_Water = lst(pix_MELake63);
S64_Water = lst(pix_MELake64);
S65_Water = lst(pix_MELake65);
S66_Water = lst(pix_MELake66);
S67_Water = lst(pix_MELake67);
S68_Water = lst(pix_MELake68);
S69_Water = lst(pix_MELake69);
S70_Water = lst(pix_MELake70);

S75_Water = lst(pix_MELake75);
S76_Water = lst(pix_MELake76);
S77_Water = lst(pix_MELake77);
S81_Water = lst(pix_MELake81);
S85_Water = lst(pix_MELake85);
S88_Water = lst(pix_MELake88);



S97_Water = lst(pix_MELake97);
S106_Water = lst(pix_MELake106);
S107_Water = lst(pix_MELake107);


S108_Water = lst(pix_MELake108);
S109_Water = lst(pix_MELake109);
S115_Water = lst(pix_MELake115);
S116_Water = lst(pix_MELake116);
S119_Water = lst(pix_MELake119);
S123_Water = lst(pix_MELake123);
S125_Water = lst(pix_MELake125);
S127_Water = lst(pix_MELake127);
S134_Water = lst(pix_MELake134);
S141_Water = lst(pix_MELake141);
S142_Water = lst(pix_MELake142);
S144_Water = lst(pix_MELake144);
S146_Water = lst(pix_MELake146);






 

% reading daily mean LST of water pixels
Water_MELake01(yr-2001,jd)=nanmean(S01_Water(S01LC_Water==17));
Water_MELake02(yr-2001,jd)=nanmean(S02_Water(S02LC_Water==17));
Water_MELake03(yr-2001,jd)=nanmean(S03_Water(S03LC_Water==17));
Water_MELake04(yr-2001,jd)=nanmean(S04_Water(S04LC_Water==17));
Water_MELake05(yr-2001,jd)=nanmean(S05_Water(S05LC_Water==17));
Water_MELake06(yr-2001,jd)=nanmean(S06_Water(S06LC_Water==17));
Water_MELake07(yr-2001,jd)=nanmean(S07_Water(S07LC_Water==17));
Water_MELake08(yr-2001,jd)=nanmean(S08_Water(S08LC_Water==17));
Water_MELake09(yr-2001,jd)=nanmean(S09_Water(S09LC_Water==17));
Water_MELake10(yr-2001,jd)=nanmean(S10_Water(S10LC_Water==17));

Water_MELake11(yr-2001,jd)=nanmean(S11_Water(S11LC_Water==17));
Water_MELake12(yr-2001,jd)=nanmean(S12_Water(S12LC_Water==17));
Water_MELake13(yr-2001,jd)=nanmean(S13_Water(S13LC_Water==17));
Water_MELake14(yr-2001,jd)=nanmean(S14_Water(S14LC_Water==17));
Water_MELake15(yr-2001,jd)=nanmean(S15_Water(S15LC_Water==17));
Water_MELake16(yr-2001,jd)=nanmean(S16_Water(S16LC_Water==17));
Water_MELake17(yr-2001,jd)=nanmean(S17_Water(S17LC_Water==17));
Water_MELake18(yr-2001,jd)=nanmean(S18_Water(S18LC_Water==17));
Water_MELake19(yr-2001,jd)=nanmean(S19_Water(S19LC_Water==17));
Water_MELake20(yr-2001,jd)=nanmean(S20_Water(S20LC_Water==17));

Water_MELake21(yr-2001,jd)=nanmean(S21_Water(S21LC_Water==17));
Water_MELake22(yr-2001,jd)=nanmean(S22_Water(S22LC_Water==17));
Water_MELake23(yr-2001,jd)=nanmean(S23_Water(S23LC_Water==17));
Water_MELake24(yr-2001,jd)=nanmean(S24_Water(S24LC_Water==17));
Water_MELake25(yr-2001,jd)=nanmean(S25_Water(S25LC_Water==17));
Water_MELake26(yr-2001,jd)=nanmean(S26_Water(S26LC_Water==17));
Water_MELake27(yr-2001,jd)=nanmean(S27_Water(S27LC_Water==17));
Water_MELake28(yr-2001,jd)=nanmean(S28_Water(S28LC_Water==17));
Water_MELake29(yr-2001,jd)=nanmean(S29_Water(S29LC_Water==17));
Water_MELake30(yr-2001,jd)=nanmean(S30_Water(S30LC_Water==17));

Water_MELake31(yr-2001,jd)=nanmean(S31_Water(S31LC_Water==17));
Water_MELake32(yr-2001,jd)=nanmean(S32_Water(S32LC_Water==17));
Water_MELake33(yr-2001,jd)=nanmean(S33_Water(S33LC_Water==17));
Water_MELake34(yr-2001,jd)=nanmean(S34_Water(S34LC_Water==17));
Water_MELake35(yr-2001,jd)=nanmean(S35_Water(S35LC_Water==17));
Water_MELake36(yr-2001,jd)=nanmean(S36_Water(S36LC_Water==17));
Water_MELake37(yr-2001,jd)=nanmean(S37_Water(S37LC_Water==17));
Water_MELake38(yr-2001,jd)=nanmean(S38_Water(S38LC_Water==17));
Water_MELake39(yr-2001,jd)=nanmean(S39_Water(S39LC_Water==17));
Water_MELake40(yr-2001,jd)=nanmean(S40_Water(S40LC_Water==17));

Water_MELake41(yr-2001,jd)=nanmean(S41_Water(S41LC_Water==17));
Water_MELake42(yr-2001,jd)=nanmean(S42_Water(S42LC_Water==17));
Water_MELake43(yr-2001,jd)=nanmean(S43_Water(S43LC_Water==17));
Water_MELake44(yr-2001,jd)=nanmean(S44_Water(S44LC_Water==17));
Water_MELake45(yr-2001,jd)=nanmean(S45_Water(S45LC_Water==17));
Water_MELake46(yr-2001,jd)=nanmean(S46_Water(S46LC_Water==17));
Water_MELake47(yr-2001,jd)=nanmean(S47_Water(S47LC_Water==17));
Water_MELake48(yr-2001,jd)=nanmean(S48_Water(S48LC_Water==17));
Water_MELake49(yr-2001,jd)=nanmean(S49_Water(S49LC_Water==17));
Water_MELake50(yr-2001,jd)=nanmean(S50_Water(S50LC_Water==17));

Water_MELake51(yr-2001,jd)=nanmean(S51_Water(S51LC_Water==17));
Water_MELake52(yr-2001,jd)=nanmean(S52_Water(S52LC_Water==17));
Water_MELake53(yr-2001,jd)=nanmean(S53_Water(S53LC_Water==17));
Water_MELake54(yr-2001,jd)=nanmean(S54_Water(S54LC_Water==17));
Water_MELake55(yr-2001,jd)=nanmean(S55_Water(S55LC_Water==17));
Water_MELake56(yr-2001,jd)=nanmean(S56_Water(S56LC_Water==17));
Water_MELake57(yr-2001,jd)=nanmean(S57_Water(S57LC_Water==17));
Water_MELake58(yr-2001,jd)=nanmean(S58_Water(S58LC_Water==17));
Water_MELake59(yr-2001,jd)=nanmean(S59_Water(S59LC_Water==17));
Water_MELake60(yr-2001,jd)=nanmean(S60_Water(S60LC_Water==17));

Water_MELake61(yr-2001,jd)=nanmean(S61_Water(S61LC_Water==17));
Water_MELake62(yr-2001,jd)=nanmean(S62_Water(S62LC_Water==17));
Water_MELake63(yr-2001,jd)=nanmean(S63_Water(S63LC_Water==17));
Water_MELake64(yr-2001,jd)=nanmean(S64_Water(S64LC_Water==17));
Water_MELake65(yr-2001,jd)=nanmean(S65_Water(S65LC_Water==17));
Water_MELake66(yr-2001,jd)=nanmean(S66_Water(S66LC_Water==17));
Water_MELake67(yr-2001,jd)=nanmean(S67_Water(S67LC_Water==17));
Water_MELake68(yr-2001,jd)=nanmean(S68_Water(S68LC_Water==17));
Water_MELake69(yr-2001,jd)=nanmean(S69_Water(S69LC_Water==17));
Water_MELake70(yr-2001,jd)=nanmean(S70_Water(S70LC_Water==17));

Water_MELake75(yr-2001,jd)=nanmean(S75_Water(S75LC_Water==17));
Water_MELake76(yr-2001,jd)=nanmean(S76_Water(S76LC_Water==17));
Water_MELake77(yr-2001,jd)=nanmean(S77_Water(S77LC_Water==17));
Water_MELake81(yr-2001,jd)=nanmean(S81_Water(S81LC_Water==17));
Water_MELake85(yr-2001,jd)=nanmean(S85_Water(S85LC_Water==17));
Water_MELake88(yr-2001,jd)=nanmean(S88_Water(S88LC_Water==17));


Water_MELake97(yr-2001,jd)=nanmean(S97_Water(S97LC_Water==17));
Water_MELake106(yr-2001,jd)=nanmean(S106_Water(S106LC_Water==17));
Water_MELake107(yr-2001,jd)=nanmean(S107_Water(S107LC_Water==17));
Water_MELake108(yr-2001,jd)=nanmean(S108_Water(S108LC_Water==17));

Water_MELake108(yr-2001,jd)=nanmean(S108_Water(S108LC_Water==17));
Water_MELake109(yr-2001,jd)=nanmean(S109_Water(S109LC_Water==17));

Water_MELake115(yr-2001,jd)=nanmean(S115_Water(S115LC_Water==17));
Water_MELake116(yr-2001,jd)=nanmean(S116_Water(S116LC_Water==17));
Water_MELake119(yr-2001,jd)=nanmean(S119_Water(S119LC_Water==17));
Water_MELake123(yr-2001,jd)=nanmean(S123_Water(S123LC_Water==17));
Water_MELake125(yr-2001,jd)=nanmean(S125_Water(S125LC_Water==17));
Water_MELake127(yr-2001,jd)=nanmean(S127_Water(S127LC_Water==17));
Water_MELake134(yr-2001,jd)=nanmean(S134_Water(S134LC_Water==17));
Water_MELake141(yr-2001,jd)=nanmean(S141_Water(S141LC_Water==17));
Water_MELake142(yr-2001,jd)=nanmean(S142_Water(S142LC_Water==17));
Water_MELake144(yr-2001,jd)=nanmean(S144_Water(S144LC_Water==17));
Water_MELake146(yr-2001,jd)=nanmean(S146_Water(S146LC_Water==17));





% Replacing LST values less than 100 by NaN;
Water_MELake01(Water_MELake01<100)=NaN;
Water_MELake02(Water_MELake02<100)=NaN;
Water_MELake03(Water_MELake03<100)=NaN;
Water_MELake04(Water_MELake04<100)=NaN;
Water_MELake05(Water_MELake05<100)=NaN;
Water_MELake06(Water_MELake06<100)=NaN;
Water_MELake07(Water_MELake07<100)=NaN;
Water_MELake08(Water_MELake08<100)=NaN;
Water_MELake09(Water_MELake09<100)=NaN;
Water_MELake10(Water_MELake10<100)=NaN;

Water_MELake11(Water_MELake11<100)=NaN;
Water_MELake12(Water_MELake12<100)=NaN;
Water_MELake13(Water_MELake13<100)=NaN;
Water_MELake14(Water_MELake14<100)=NaN;
Water_MELake15(Water_MELake15<100)=NaN;
Water_MELake16(Water_MELake16<100)=NaN;
Water_MELake17(Water_MELake17<100)=NaN;
Water_MELake18(Water_MELake18<100)=NaN;
Water_MELake19(Water_MELake19<100)=NaN;
Water_MELake20(Water_MELake20<100)=NaN;

 Water_MELake21(Water_MELake21<100)=NaN;
Water_MELake22(Water_MELake22<100)=NaN;
Water_MELake23(Water_MELake23<100)=NaN;
Water_MELake24(Water_MELake24<100)=NaN;
Water_MELake25(Water_MELake25<100)=NaN;
Water_MELake26(Water_MELake26<100)=NaN;
Water_MELake27(Water_MELake27<100)=NaN;
Water_MELake28(Water_MELake28<100)=NaN;
Water_MELake29(Water_MELake29<100)=NaN;
Water_MELake30(Water_MELake30<100)=NaN;

Water_MELake31(Water_MELake31<100)=NaN;
Water_MELake32(Water_MELake32<100)=NaN;
Water_MELake33(Water_MELake33<100)=NaN;
Water_MELake34(Water_MELake34<100)=NaN;
Water_MELake35(Water_MELake35<100)=NaN;
Water_MELake36(Water_MELake36<100)=NaN;
Water_MELake37(Water_MELake37<100)=NaN;
Water_MELake38(Water_MELake38<100)=NaN;
Water_MELake39(Water_MELake39<100)=NaN;
Water_MELake40(Water_MELake40<100)=NaN;

Water_MELake41(Water_MELake41<100)=NaN;
Water_MELake42(Water_MELake42<100)=NaN;
Water_MELake43(Water_MELake43<100)=NaN;
Water_MELake44(Water_MELake44<100)=NaN;
Water_MELake45(Water_MELake45<100)=NaN;
Water_MELake46(Water_MELake46<100)=NaN;
Water_MELake47(Water_MELake47<100)=NaN;
Water_MELake48(Water_MELake48<100)=NaN;
Water_MELake49(Water_MELake49<100)=NaN;
Water_MELake50(Water_MELake50<100)=NaN;

Water_MELake51(Water_MELake51<100)=NaN;
Water_MELake52(Water_MELake52<100)=NaN;
Water_MELake53(Water_MELake53<100)=NaN;
Water_MELake54(Water_MELake54<100)=NaN;
Water_MELake55(Water_MELake55<100)=NaN;
Water_MELake56(Water_MELake56<100)=NaN;
Water_MELake57(Water_MELake57<100)=NaN;
Water_MELake58(Water_MELake58<100)=NaN;
Water_MELake59(Water_MELake59<100)=NaN;
Water_MELake60(Water_MELake60<100)=NaN;

Water_MELake61(Water_MELake61<100)=NaN;
Water_MELake62(Water_MELake62<100)=NaN;
Water_MELake63(Water_MELake63<100)=NaN;
Water_MELake64(Water_MELake64<100)=NaN;
Water_MELake65(Water_MELake65<100)=NaN;
Water_MELake66(Water_MELake66<100)=NaN;
Water_MELake67(Water_MELake67<100)=NaN;
Water_MELake68(Water_MELake68<100)=NaN;
Water_MELake69(Water_MELake69<100)=NaN;
Water_MELake70(Water_MELake70<100)=NaN;

Water_MELake75(Water_MELake75<100)=NaN;
Water_MELake76(Water_MELake76<100)=NaN;
Water_MELake77(Water_MELake77<100)=NaN;
Water_MELake81(Water_MELake81<100)=NaN;
Water_MELake85(Water_MELake85<100)=NaN;
Water_MELake88(Water_MELake88<100)=NaN;


Water_MELake97(Water_MELake97<100)=NaN;
Water_MELake106(Water_MELake106<100)=NaN;
Water_MELake107(Water_MELake107<100)=NaN;
Water_MELake108(Water_MELake108<100)=NaN;
Water_MELake109(Water_MELake109<100)=NaN;

Water_MELake115(Water_MELake115<100)=NaN;
Water_MELake116(Water_MELake116<100)=NaN;
Water_MELake119(Water_MELake119<100)=NaN;
Water_MELake123(Water_MELake123<100)=NaN;
Water_MELake125(Water_MELake125<100)=NaN;
Water_MELake127(Water_MELake127<100)=NaN;
Water_MELake134(Water_MELake134<100)=NaN;
Water_MELake141(Water_MELake141<100)=NaN;
Water_MELake142(Water_MELake142<100)=NaN;
Water_MELake144(Water_MELake144<100)=NaN;
Water_MELake146(Water_MELake146<100)=NaN;



end

end

end
 
% saving LST Data   
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake01.mat'],'Water_MELake01','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake02.mat'],'Water_MELake02','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake03.mat'],'Water_MELake03','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake04.mat'],'Water_MELake04','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake05.mat'],'Water_MELake05','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake06.mat'],'Water_MELake06','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake07.mat'],'Water_MELake07','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake08.mat'],'Water_MELake08','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake09.mat'],'Water_MELake09','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake10.mat'],'Water_MELake10','-v6');

save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake11.mat'],'Water_MELake11','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake12.mat'],'Water_MELake12','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake13.mat'],'Water_MELake13','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake14.mat'],'Water_MELake14','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake15.mat'],'Water_MELake15','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake16.mat'],'Water_MELake16','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake17.mat'],'Water_MELake17','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake18.mat'],'Water_MELake18','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake19.mat'],'Water_MELake19','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake20.mat'],'Water_MELake20','-v6');

save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake21.mat'],'Water_MELake21','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake22.mat'],'Water_MELake22','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake23.mat'],'Water_MELake23','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake24.mat'],'Water_MELake24','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake25.mat'],'Water_MELake25','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake26.mat'],'Water_MELake26','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake27.mat'],'Water_MELake27','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake28.mat'],'Water_MELake28','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake29.mat'],'Water_MELake29','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake30.mat'],'Water_MELake30','-v6');

save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake31.mat'],'Water_MELake31','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake32.mat'],'Water_MELake32','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake33.mat'],'Water_MELake33','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake34.mat'],'Water_MELake34','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake35.mat'],'Water_MELake35','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake36.mat'],'Water_MELake36','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake37.mat'],'Water_MELake37','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake38.mat'],'Water_MELake38','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake39.mat'],'Water_MELake39','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake40.mat'],'Water_MELake40','-v6');

save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake41.mat'],'Water_MELake41','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake42.mat'],'Water_MELake42','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake43.mat'],'Water_MELake43','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake44.mat'],'Water_MELake44','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake45.mat'],'Water_MELake45','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake46.mat'],'Water_MELake46','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake47.mat'],'Water_MELake47','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake48.mat'],'Water_MELake48','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake49.mat'],'Water_MELake49','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake50.mat'],'Water_MELake50','-v6');

save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake51.mat'],'Water_MELake51','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake52.mat'],'Water_MELake52','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake53.mat'],'Water_MELake53','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake54.mat'],'Water_MELake54','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake55.mat'],'Water_MELake55','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake56.mat'],'Water_MELake56','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake57.mat'],'Water_MELake57','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake58.mat'],'Water_MELake58','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake59.mat'],'Water_MELake59','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake60.mat'],'Water_MELake60','-v6');

save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake61.mat'],'Water_MELake61','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake62.mat'],'Water_MELake62','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake63.mat'],'Water_MELake63','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake64.mat'],'Water_MELake64','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake65.mat'],'Water_MELake65','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake66.mat'],'Water_MELake66','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake67.mat'],'Water_MELake67','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake68.mat'],'Water_MELake68','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake69.mat'],'Water_MELake69','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake70.mat'],'Water_MELake70','-v6');

save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake75.mat'],'Water_MELake75','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake76.mat'],'Water_MELake76','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake77.mat'],'Water_MELake77','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake81.mat'],'Water_MELake81','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake85.mat'],'Water_MELake85','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake88.mat'],'Water_MELake88','-v6');



save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake97.mat'],'Water_MELake97','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake106.mat'],'Water_MELake106','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake107.mat'],'Water_MELake107','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files2/MELake108.mat'],'Water_MELake108','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake109.mat'],'Water_MELake109','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake115.mat'],'Water_MELake115','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake116.mat'],'Water_MELake116','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake119.mat'],'Water_MELake119','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake123.mat'],'Water_MELake123','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake125.mat'],'Water_MELake125','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake127.mat'],'Water_MELake127','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake134.mat'],'Water_MELake134','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake141.mat'],'Water_MELake141','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake142.mat'],'Water_MELake142','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake144.mat'],'Water_MELake144','-v6');
save(['E:/Maine Lakes Project/H1213V04_Night Mat Files3/MELake146.mat'],'Water_MELake146','-v6');


end




