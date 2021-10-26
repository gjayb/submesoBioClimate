load('spectra_10_4km_bipit_del250_64visc.mat')
ocean_day=(time)/(24*3600)+5;
logrb=log10(radialbands);
yeari=[109:352; 353:596; 597:840]; %or yeari=[109:351; 352:594; 595:837; 838:1080];
zi=21; %200m
%% KEH
[plotday,kehp]=make_seasonal_spectra(ocean_day,yeari(:,1),yeari(:,end),squeeze(keh(:,zi,:)));

figure
logkehp=log10(kehp);
ci=[-0.5:0.1:3.5];
cc=[-0.5 3.5];
logkehp(logkehp<min(ci))=min(ci);
contourf(plotday,logrb,logkehp,ci)
hold on
contour(plotday,logrb,logkehp,ci)
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
set(gca,'YDir','reverse','FontSize',18)
ylabel('cyc/m','FontSize',18)
title('KE_H, 200m')

%datetick('x',3)
%xlim([plotday(1) plotday(end)])
%ylim([logrb(2) logrb(end)])

%% W
clear ci cc 
[plotday,kevp]=make_seasonal_spectra(ocean_day,yeari(:,1),yeari(:,end),squeeze(kev(:,zi,:)));

figure
logkehp=log10(kevp);
ci=[-8:0.2:-3];
cc=[-8 -3];
logkehp(logkehp<min(ci))=min(ci);
contourf(plotday,logrb,logkehp,ci)
hold on
contour(plotday,logrb,logkehp,ci)
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
set(gca,'YDir','reverse','FontSize',18)
ylabel('cyc/m','FontSize',18)
title('KE_v, 200m')
%% WN
cc=[-4 4];
ci=-6:0.5:6;
% cm1=cmocean('balance',24,'pivot',0);
% cm3(1:12,1:3)=cm1(12:-1:1,:);
% cm3(13:24,:)=cm1(24:-1:13,:);
% colormap(cm3)

[plotday,kevp]=make_seasonal_spectra(ocean_day,yeari(:,1),yeari(:,end),squeeze(real(wnspec(:,zi,:))));

figure
logkehp=log10(abs(kevp));
logkehp(logkehp<min(ci))=min(ci); logkehp(logkehp>max(ci))=max(ci);
contourf(plotday,logrb,-logkehp.*sign(kevp),ci,'LineStyle','none')
caxis(cc)
%colormap(cm4);
colorbar
set(gca,'YDir','reverse','FontSize',18)
ylabel('cyc/m','FontSize',18)
title('WN, 200m')
%
figure
ci=-1e-5:0.5e-6:1e-5;
cc=[-5e-6 5e-6];
contourf(plotday,logrb,kevp.*repmat(radialbands.',[1 244]),ci,'LineStyle','none')
caxis(cc)
cmocean('balance','pivot',0)
colorbar
set(gca,'YDir','reverse','FontSize',18)
ylabel('cyc/m','FontSize',18)
title('WN, 200m')
%% WP
[plotday,kevp]=make_seasonal_spectra(ocean_day,yeari(:,1),yeari(:,end),squeeze(real(wpspec(:,zi,:))));
figure
ci=-1e-2:0.5e-3:1e-2;
cc=[-1e-2 1e-2];
contourf(plotday,logrb,kevp,ci,'LineStyle','none')
caxis(cc)
cmocean('balance','pivot',0)
colorbar
set(gca,'YDir','reverse','FontSize',18)
ylabel('cyc/m','FontSize',18)
title('WP, 200m')

figure
ci=-1e-6:2e-8:1e-6;
cc=[-5e-7 5e-7];
contourf(plotday,logrb,kevp.*repmat(radialbands.',[1 244]),ci,'LineStyle','none')
caxis(cc)
cmocean('balance','pivot',0)
colorbar
set(gca,'YDir','reverse','FontSize',18)
ylabel('cyc/m','FontSize',18)
title('WP, 200m')
%% N

ci=-2:0.25:6;
cc=[-2 6];
[plotday,kevp]=make_seasonal_spectra(ocean_day,yeari(:,1),yeari(:,end),squeeze(nnspec(:,zi,:)));

figure
logkehp=log10(kevp);
logkehp(logkehp<min(ci))=min(ci);
contourf(plotday,logrb,logkehp,ci)
hold on
contour(plotday,logrb,logkehp,ci)
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
set(gca,'YDir','reverse','FontSize',18)
ylabel('cyc/m','FontSize',18)
title('N, 200m')
