%% load
load('ts_10_4km_bipit_del250_64visc_means.mat','Mldpop')
Mldpopv=Mldpop;
load('ts_10_4km_bipit_del250_2100_v3_64visc_means.mat','Mldpop')
Mldpop1v=Mldpop;
load('ts_10_4km_bipit_del250_2100_v3_means.mat','Mldpop')
Mldpop1=Mldpop;
load('ts_10_4km_bipit_del250_means.mat','Mldpop')

load('nprod_10_4km_bipit_del250_64visc_means.mat','n','Prodn')
nv=n; 
Prodv=Prodn;
load('nprod_10_4km_bipit_del250_2100_v3_64visc_means.mat','n','Prodn')
n1v=n; 
Prod1v=Prodn;
load('nprod_10_4km_bipit_del250_2100_v3_means.mat','n','Prodn')
n1=n; 
Prod1=Prodn;
load('nprod_10_4km_bipit_del250_2100_v3_means.mat', 'days')
days1=days;
load('nprod_10_4km_bipit_del250_means.mat','n','Prodn','days')
load('pset_10_4km_bipit_del250_64visc_means.mat','pvisc')
load('pset_10_4km_bipit_del250_means.mat','p')

load('pset_10_4km_bipit_del250_2100_v3_means.mat','varmeans1','yeari','time')
[~,p1]=make_seasonal_fields(time,yeari(1:3,1),yeari(1:3,end),varmeans1.p);
load('pset_10_4km_bipit_del250_2100_v3_64visc_means.mat','varmeans1','yeari')
[~,p1visc]=make_seasonal_fields(time,yeari(1:3,1),yeari(1:3,end),varmeans1.p);

z=-varmeans1.z;
%% plot prod
figure; 
ax1=subplot(2,3,1); contourf(days,z,Prodn,0:0.01:0.22,'LineStyle','none'); 
hold on; plot(days,Mldpop,'k')
 caxis([0 0.22]); cmocean('rain',22)
datetick('x',3); axis tight; ylim([-100 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,3,2); contourf(days,z,Prodv,0:0.01:0.22,'LineStyle','none');
hold on; plot(days,Mldpopv,'k')
caxis([0 0.22]); cmocean('rain',22)
datetick('x',3); axis tight; ylim([-100 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,3,3); contourf(days,z,Prodv-Prodn,-0.02:0.001:0.02,'LineStyle','none');
hold on; plot(days,Mldpopv,'k')
caxis([-0.01 0.016]); cmocean('curl',27,'pivot',0)
datetick('x',3); axis tight; ylim([-100 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(2,3,4); contourf(days1,z,Prod1,0:0.001:0.02,'LineStyle','none'); 
hold on; plot(days,Mldpop1,'k')
caxis([0 0.02]); cmocean('rain',20)
datetick('x',3); axis tight; ylim([-60 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(2,3,5); contourf(days1,z,Prod1v,0:0.001:0.02,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k')
caxis([0 0.02]); cmocean('rain',20)
datetick('x',3); axis tight; ylim([-60 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('Prod','MLD')

ax6=subplot(2,3,6); contourf(days1,z,Prod1v-Prod1,-0.002:0.0001:0.002,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k')
caxis([-0.002 0.0002]); cmocean('curl',23,'pivot',0)
datetick('x',3); axis tight; ylim([-60 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})

%% plot N
figure; 
ax1=subplot(3,3,1); contourf(days,z,n,0:0.32:10,'LineStyle','none'); 
hold on; contour(days,z,n,[0.08 0.08],'r')
hold on; plot(days,Mldpop,'k')
 caxis([0 6.4]); cmocean('amp',21)
datetick('x',3); axis tight; ylim([-300 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(3,3,2); contourf(days,z,nv,0:0.32:10,'LineStyle','none');
hold on; contour(days,z,nv,[0.08 0.08],'r')
hold on; plot(days,Mldpopv,'k')
caxis([0 6.4]); cmocean('amp',21)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(3,3,3); contourf(days,z,nv-n,-3.2:0.04:3.2,'LineStyle','none');
hold on; plot(days,Mldpopv,'k')
caxis([-0.5 0.5]); cmocean('curl',9,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(3,3,4); contourf(days1,z,n1,0:0.08:10,'LineStyle','none'); 
hold on; contour(days1,z,n1,[0.08 0.08],'r')
hold on; plot(days,Mldpop1,'k')
caxis([0 6.4]); cmocean('amp',21)
datetick('x',3); axis tight; ylim([-300 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(3,3,5); contourf(days1,z,n1v,0:0.08:10,'LineStyle','none'); 
hold on; contour(days1,z,n1v,[0.08 0.08],'r')
hold on; plot(days,Mldpop1v,'k')
caxis([0 6.4]); cmocean('amp',21)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('N','N=0.08','MLD')

ax6=subplot(3,3,6); contourf(days1,z,n1v-n1,-3.2:0.02:3.2,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k')
caxis([-0.5 1.25]); cmocean('curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})

ax7=subplot(3,3,7); contourf(days,z,n1(:,1:end-1)-n,-3.2:0.02:3.2,'LineStyle','none'); 
hold on; plot(days,Mldpop1,'k',days,Mldpop,'k')
caxis([-2.5 1]); cmocean('curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel({'months','(g)'}); ylabel({'2100-2000','depth, m'})

ax8=subplot(3,3,8); contourf(days,z,n1v(:,1:end-1)-nv,-3.2:0.02:3.2,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k',days,Mldpopv,'k')
caxis([-2.5 1]); cmocean('curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(h)'); set(gca,'YTickLabel',{})

%% plot P

figure; 
ax1=subplot(2,3,1); contourf(days,z,p,0:0.01:0.16,'LineStyle','none'); 
hold on; plot(days,Mldpop,'k')
 caxis([0 0.22]); cmocean('-curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,3,2); contourf(days,z,pvisc,0:0.01:0.16,'LineStyle','none');
hold on; plot(days,Mldpopv,'k')
caxis([0 0.22]); cmocean('-curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,3,3); contourf(days,z,pvisc-p,-0.02:0.001:0.02,'LineStyle','none');
hold on; plot(days,Mldpopv,'k')
caxis([-0.01 0.02]); cmocean('-curl',26,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(2,3,4); contourf(days,z,p1,0:0.001:0.016,'LineStyle','none'); 
hold on; plot(days,Mldpop1,'k')
caxis([0 0.016]); cmocean('-curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(2,3,5); contourf(days,z,p1visc,0:0.001:0.016,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k')
caxis([0 0.016]); cmocean('-curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('P','MLD')

ax6=subplot(2,3,6); contourf(days,z,p1visc-p1,-0.002:0.0001:0.002,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k')
caxis([-0.0012 0.001]); cmocean('-curl',23,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})
