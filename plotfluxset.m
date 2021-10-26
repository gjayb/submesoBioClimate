% load
load('ts_10_4km_bipit_del250_64visc_means.mat','Mldpop')
Mldpopv=Mldpop;
load('ts_10_4km_bipit_del250_2100_v3_64visc_means.mat','Mldpop')
Mldpop1v=Mldpop;
load('ts_10_4km_bipit_del250_2100_v3_means.mat','Mldpop')
Mldpop1=Mldpop;
load('ts_10_4km_bipit_del250_means.mat','Mldpop')

%load wn
load('nprod_10_4km_bipit_del250_2100_v3_64visc_means.mat', 'wpnp')
wpnp1v=wpnp;
load('nprod_10_4km_bipit_del250_2100_v3_means.mat', 'wpnp')
wpnp1=wpnp;
load('nprod_10_4km_bipit_del250_64visc_means.mat', 'wpnp')
wpnpv=wpnp;
load('nprod_10_4km_bipit_del250_means.mat', 'wpnp')
load('nprod_10_4km_bipit_del250_2100_v3_means.mat', 'days')
days1=days;

% load wp
load('pset_10_4km_bipit_del250_64visc_means.mat', 'wpppvisc','varmeans1')
z=-varmeans1.z; clear varmeans1
load('pset_10_4km_bipit_del250_2100_v3_means.mat','wppp')
wppp1=wppp;
load('pset_10_4km_bipit_del250_2100_v3_64visc_means.mat','wppp')
wppp1v=wppp;
load('pset_10_4km_bipit_del250_means.mat', 'wppp','days','time','yeari')
%% plot wn
figure; 
ax1=subplot(2,3,1); contourf(days,z,wpnp,-9e-6:1e-7:9e-6,'LineStyle','none'); 
hold on; plot(days,Mldpop,'k')
 caxis([-7e-6 7e-6]); cmocean('balance',25,'pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,3,2); contourf(days,z,wpnpv,-4e-6:1e-7:4e-6,'LineStyle','none');
hold on; plot(days,Mldpopv,'k')
caxis([-7e-6 7e-6]); cmocean('balance',25,'pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,3,3); contourf(days,z,wpnpv-wpnp,-6e-6:1e-7:6e-6,'LineStyle','none');
hold on; plot(days,Mldpopv,'k')
caxis([-6e-6 6e-6]); cmocean('curl',21,'pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(2,3,4); contourf(days1,z,wpnp1,-1e-6:0.25e-7:1e-6,'LineStyle','none'); 
hold on; plot(days,Mldpop1,'k')
caxis([-3.5e-7 3.5e-7]); cmocean('balance',25,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(2,3,5); contourf(days1,z,wpnp1v,-1e-6:0.25e-7:1e-6,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k')
caxis([-3.5e-7 3.5e-7]); cmocean('balance',25,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('WN','MLD')

ax6=subplot(2,3,6); contourf(days1,z,wpnp1v-wpnp1,-1e-6:0.1e-7:1e-6,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k')
caxis([-2e-7 3e-7]); cmocean('curl',16,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})


%% plot wp

figure; 
ax1=subplot(2,3,1); contourf(days,z,wppp,-6e-7:1e-8:2e-7,'LineStyle','none'); 
hold on; plot(days,Mldpop,'k')
 caxis([-5e-7 1e-8]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,3,2); contourf(days,z,wpppvisc,-4e-7:1e-8:4e-7,'LineStyle','none');
hold on; plot(days,Mldpopv,'k')
caxis([-5e-7 1e-8]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,3,3); contourf(days,z,wpppvisc-wppp,-6e-7:1e-8:6e-7,'LineStyle','none');
hold on; plot(days,Mldpopv,'k')
caxis([-1e-8 4e-7]); cmocean('curl','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(2,3,4); contourf(days,z,wppp1,-1e-8:1e-10:3e-9,'LineStyle','none'); 
hold on; plot(days,Mldpop1,'k')
caxis([-1e-8 1e-10]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(2,3,5); contourf(days,z,wppp1v,-1e-8:1e-10:3e-9,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k')
caxis([-1e-8 1e-10]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('WP','MLD')

ax6=subplot(2,3,6); contourf(days,z,wppp1v-wppp1,-6e-9:0.1e-9:3e-9,'LineStyle','none'); 
hold on; plot(days,Mldpop1v,'k')
caxis([-5e-9 3e-9]); cmocean('curl','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})

