load('spectra_10_4km_bipit_del250.mat')
ocean_day=(time)/(24*3600)+5;
logrb=log10(radialbands);

sliceis=[243 312 364 435]; %Feb 1 May 14/15 Jul 31/Aug 1 Nov 15 %WSSF
%% KE_H
figure; 
ci=[-0.5:0.1:3.5];
cc=[-0.5 3.5];

kehi=log10(keh(:,:,sliceis(1))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Feb 1')

kehi=log10(keh(:,:,sliceis(2))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May 15')

kehi=log10(keh(:,:,sliceis(3))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Aug 1')

kehi=log10(keh(:,:,sliceis(4))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov 15')

%% WW
figure; 
ci=[-8:0.2:-3];
cc=[-8 -3];

kehi=log10(kev(:,:,sliceis(1))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Feb 1'); ylabel('m')

kehi=log10(kev(:,:,sliceis(2))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May 15')

kehi=log10(kev(:,:,sliceis(3))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Aug 1');  xlabel('cyc/m'); ylabel('m')

kehi=log10(kev(:,:,sliceis(4))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov 15'); xlabel('cyc/m')

%% WP
figure; 
ci=[-8:0.25:-2];
cc=[-8 -2];

kehi=log10(abs(wpspec(:,:,sliceis(1)))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Feb 1'); ylabel('m')

kehi=log10(abs(wpspec(:,:,sliceis(2)))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May 15')

kehi=log10(abs(wpspec(:,:,sliceis(3)))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Aug 1');  xlabel('cyc/m'); ylabel('m')

kehi=log10(abs(wpspec(:,:,sliceis(4)))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov 15'); xlabel('cyc/m')
%
figure; 
cc=[-6 6];
ci=-6:0.5:6;

kehi=-log10(abs(wpspec(:,:,sliceis(1)))).*sign(wpspec(:,:,sliceis(1))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm2)
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Feb 1'); ylabel('m')

kehi=-log10(abs(wpspec(:,:,sliceis(2)))).*sign(wpspec(:,:,sliceis(2))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm2);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May 15')

kehi=-log10(abs(wpspec(:,:,sliceis(3)))).*sign(wpspec(:,:,sliceis(3))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm2);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Aug 1');  xlabel('cyc/m'); ylabel('m')

kehi=-log10(abs(wpspec(:,:,sliceis(4)))).*sign(wpspec(:,:,sliceis(4))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm2);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov 15'); xlabel('cyc/m')
cm1=cmocean('balance',32,'pivot',0);
cm2(1:14,:)=cm1(16:-1:3,:);
cm2(19:32,:)=cm1(30:-1:17,:);
cm2(15:18,:)=0;
colormap(cm2)
%% P
ci=-6:0.5:1.5;
cc=[-6 1.5];

figure;
kehi=log10(abs(ppspec(:,:,sliceis(1)))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Feb 1'); ylabel('m')

kehi=log10(abs(ppspec(:,:,sliceis(2)))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May 15')

kehi=log10(abs(ppspec(:,:,sliceis(3)))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Aug 1');  xlabel('cyc/m'); ylabel('m')

kehi=log10(abs(ppspec(:,:,sliceis(4)))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov 15'); xlabel('cyc/m')
%% N
ci=-2:0.25:6;
cc=[-2 6];

figure;
kehi=log10(abs(nnspec(:,:,sliceis(1)))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Feb 1'); ylabel('m')

kehi=log10(abs(nnspec(:,:,sliceis(2)))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May 15')

kehi=log10(abs(nnspec(:,:,sliceis(3)))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Aug 1');  xlabel('cyc/m'); ylabel('m')

kehi=log10(abs(nnspec(:,:,sliceis(4)))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov 15'); xlabel('cyc/m')
%% WN
ci=-6:0.5:0;
cc=[-6 0];

figure;
kehi=log10(abs(wnspec(:,:,sliceis(1)))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Feb 1'); ylabel('m')

kehi=log10(abs(wnspec(:,:,sliceis(2)))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May 15')

kehi=log10(abs(wnspec(:,:,sliceis(3)))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Aug 1');  xlabel('cyc/m'); ylabel('m')

kehi=log10(abs(wnspec(:,:,sliceis(4)))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
colormap(jet(length(ci)-1));
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov 15'); xlabel('cyc/m')
%
figure; 
cc=[-4 4];
ci=-6:0.5:6;

kehi=-log10(abs(wnspec(:,:,sliceis(1)))).*sign(wnspec(:,:,sliceis(1))); 
subplot(2,2,1)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm3)
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Feb 1'); ylabel('m')

kehi=-log10(abs(wnspec(:,:,sliceis(2)))).*sign(wnspec(:,:,sliceis(2))); 
subplot(2,2,2)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm3);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('May 15')

kehi=-log10(abs(wnspec(:,:,sliceis(3)))).*sign(wnspec(:,:,sliceis(3))); 
subplot(2,2,3)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm3);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Aug 1');  xlabel('cyc/m'); ylabel('m')

kehi=-log10(abs(wnspec(:,:,sliceis(4)))).*sign(wnspec(:,:,sliceis(4))); 
subplot(2,2,4)
kehp=kehi; kehp(kehp<min(ci))=min(ci); kehp(kehp>max(ci))=max(ci);
contourf(logrb,-z,kehp.',ci,'LineStyle','none')
caxis(cc)
%colormap(cm3);
colorbar; xlim([logrb(2) logrb(end)]); ylim([-1000 -5])
set(gca,'FontSize',18)
title('Nov 15'); xlabel('cyc/m')

cm1=cmocean('balance',24,'pivot',0);
cm3(1:12,1:3)=cm1(12:-1:1,:);
cm3(13:24,:)=cm1(24:-1:13,:);
colormap(cm3)
