load('spectra_10_4km_bipit_del250_64visc.mat')
ocean_day=(time)/(24*3600)+5;
logrb=log10(radialbands);

sliceis=[222 303 344 426]; %Dec 31 May 1 Jul 1 Nov 1 %WSSF
sliceie=[243 323 364 445]; %Feb 1 May 31 Jul 31 Nov 30

slicei1=[223:243 467:487 711:731];
slicei2=[303:323 547:567 791:811];
slicei3=[ 830:838 109:120 344:364 587:607];
slicei4=[182:202 426:446 670:690];
%% KE_H
figure; 
ci=[-0.5:0.1:3.5];
cc=[-0.5 3.5];

kehi=log10(mean(keh(:,:,slicei1),3)); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jan')

kehi=log10(mean(keh(:,:,slicei2),3)); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May')

kehi=log10(mean(keh(:,:,slicei3),3)); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jul')

kehi=log10(mean(keh(:,:,slicei4),3)); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov')

%% WW
figure; 
ci=[-8:0.2:-3];
cc=[-8 -3];

kehi=log10(mean(kev(:,:,slicei1),3)); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jan'); ylabel('m')

kehi=log10(mean(kev(:,:,slicei2),3)); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May')

kehi=log10(mean(kev(:,:,slicei3),3)); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jul');  xlabel('cyc/m'); ylabel('m')

kehi=log10(mean(kev(:,:,slicei4),3)); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov'); xlabel('cyc/m')

%% WP
figure; 
ci=[-8:0.25:-2];
cc=[-8 -2];

kehi=log10(abs(mean(wpspec(:,:,slicei1),3))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jan'); ylabel('m')

kehi=log10(abs(mean(wpspec(:,:,slicei2),3))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May')

kehi=log10(abs(mean(wpspec(:,:,slicei3),3))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jul');  xlabel('cyc/m'); ylabel('m')

kehi=log10(abs(mean(wpspec(:,:,slicei4),3))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov'); xlabel('cyc/m')
%% WP signed
figure; 
cc=[-6 6];
ci=-6:0.5:6;

wpi=mean(wpspec(:,:,slicei1),3);
kehi=-log10(abs(wpi)).*sign(wpi); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm2)
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jan'); ylabel('m')

wpi=mean(wpspec(:,:,slicei2),3);
kehi=-log10(abs(wpi)).*sign(wpi); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm2);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May')

wpi=mean(wpspec(:,:,slicei3),3);
kehi=-log10(abs(wpi)).*sign(wpi); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm2);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jul');  xlabel('cyc/m'); ylabel('m')

wpi=mean(wpspec(:,:,slicei4),3);
kehi=-log10(abs(wpi)).*sign(wpi); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm2);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov'); xlabel('cyc/m')
cm1=cmocean('balance',32,'pivot',0);
cm2(1:14,:)=cm1(16:-1:3,:);
cm2(19:32,:)=cm1(30:-1:17,:);
cm2(15:18,:)=0;
colormap(cm2)
%% P
ci=-6:0.5:1.5;
cc=[-6 1.5];

figure;
kehi=log10(abs(mean(ppspec(:,:,slicei1),3))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jan'); ylabel('m')

kehi=log10(abs(mean(ppspec(:,:,slicei2),3))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May')

kehi=log10(abs(mean(ppspec(:,:,slicei3),3))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jul');  xlabel('cyc/m'); ylabel('m')

kehi=log10(abs(mean(ppspec(:,:,slicei4),3))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov'); xlabel('cyc/m')
%% N
ci=-2:0.25:6;
cc=[-2 6];

figure;
kehi=log10(abs(mean(nnspec(:,:,slicei1),3))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jan'); ylabel('m')

kehi=log10(abs(mean(nnspec(:,:,slicei2),3))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May')

kehi=log10(abs(mean(nnspec(:,:,slicei3),3))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jul');  xlabel('cyc/m'); ylabel('m')

kehi=log10(abs(mean(nnspec(:,:,slicei4),3))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov'); xlabel('cyc/m')
%% WN
ci=-6:0.5:0;
cc=[-6 0];

figure;
kehi=log10(abs(mean(wnspec(:,:,slicei1),3))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jan'); ylabel('m')

kehi=log10(abs(mean(wnspec(:,:,slicei2),3))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May')

kehi=log10(abs(mean(wnspec(:,:,slicei3),3))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jul');  xlabel('cyc/m'); ylabel('m')

kehi=log10(abs(mean(wnspec(:,:,slicei4),3))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov'); xlabel('cyc/m')
%% WN signed
figure; 
cc=[-4 4];
ci=-6:0.5:6;

wpi=mean(wnspec(:,:,slicei1),3);
kehi=-log10(abs(wpi)).*sign(wpi); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm3)
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jan'); ylabel('m')

wpi=mean(wnspec(:,:,slicei2),3);
kehi=-log10(abs(wpi)).*sign(wpi);  
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm3);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May')

wpi=mean(wnspec(:,:,slicei3),3);
kehi=-log10(abs(wpi)).*sign(wpi); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm3);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Jul');  xlabel('cyc/m'); ylabel('m')

wpi=mean(wnspec(:,:,slicei4),3);
kehi=-log10(abs(wpi)).*sign(wpi); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm3);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov'); xlabel('cyc/m')

cm1=cmocean('balance',24,'pivot',0);
cm3(1:12,1:3)=cm1(12:-1:1,:);
cm3(13:24,:)=cm1(24:-1:13,:);
colormap(cm3)
