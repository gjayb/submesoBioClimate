% load
load('nprod_10_4km_bipit_del250_means.mat', 'w2')
rmsw0=sqrt(w2).*86400;
load('nprod_10_4km_bipit_del250_64visc_means.mat', 'w2')
rmsw0v=sqrt(w2).*86400;
load('nprod_10_4km_bipit_del250_2100_v3_64visc_means.mat', 'w2')
rmsw1v=sqrt(w2).*86400;
load('nprod_10_4km_bipit_del250_2100_v3_means.mat', 'w2')
rmsw1=sqrt(w2).*86400;
load('nprod_10_4km_bipit_del250_2100_v3_means.mat', 'days')
days1=days;
load('nprod_10_4km_bipit_del250_means.mat', 'days')
load('nprod_10_4km_bipit_del250_64visc_means.mat', 'varmeans')
z=-varmeans.z;
clear varmeans

load('ts_10_4km_bipit_del250_64visc_means.mat','Mldpop')
Mldpopv=Mldpop;
load('ts_10_4km_bipit_del250_2100_v3_64visc_means.mat','Mldpop')
Mldpop1v=Mldpop;
load('ts_10_4km_bipit_del250_2100_v3_means.mat','Mldpop')
Mldpop1=Mldpop;
load('ts_10_4km_bipit_del250_means.mat','Mldpop')
%% colorbars
clear cmap*
cmap1=cmocean('speed',17);
cmap2=zeros(26,3);
cmap2(1:8,:)=cmap1(1:8,:);
cmap2(9:2:end,:)=cmap1(9:end,:);
cmap2(10:2:end,:)=cmap1(9:end,:);
cmap3=cmap1(1:8,:);
%% plot rms w

figure; 
ax1=subplot(2,2,1); contourf(days,z,rmsw0,0:0.5:12,'LineStyle','none'); 
hold on; plot(days,Mldpop,'k')
 caxis([0 13]); colormap(ax1,cmap2)
datetick('x',3); axis tight; ylim([-400 -5]); 
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,2,2); contourf(days,z,rmsw0v,0:0.5:12,'LineStyle','none');
hold on; plot(days,Mldpopv,'k')
 caxis([0 13]); colormap(ax2,cmap2)
datetick('x',3); axis tight; ylim([-400 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,2,3); contourf(days1,z,rmsw1,0:0.5:4,'LineStyle','none'); 
hold on; plot(days,Mldpop1,'k')
 caxis([0 4]); colormap(ax3,cmap3)
datetick('x',3); axis tight; ylim([-200 -5]);
set(gca,'fontsize',12);xlabel({'months','(c)'});ylabel({'2100','depth, m'});

ax4=subplot(2,2,4); contourf(days1,z,rmsw1v,0:0.5:4,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k')
 caxis([0 4]); colormap(ax4,cmap3)
datetick('x',3); axis tight; ylim([-200 -5]); colorbar
set(gca,'fontsize',12);xlabel('(d)'); set(gca,'YTickLabel',{})
legend('rms W','MLD')

