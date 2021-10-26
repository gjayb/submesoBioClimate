%% load
load('ts_10_4km_bipit_del250_64visc_means.mat','Mldpop')
Mldpopv=Mldpop;
load('ts_10_4km_bipit_del250_2100_v3_64visc_means.mat','Mldpop')
Mldpop1v=Mldpop;
load('ts_10_4km_bipit_del250_2100_v3_means.mat','Mldpop')
Mldpop1=Mldpop;
load('ts_10_4km_bipit_del250_means.mat','Mldpop')

load('nprod_10_4km_bipit_del250_2100_v3_means.mat', 'days')
days1=days(1:end-1); %matches MLD length

filemid={'a','b','c','d','e','f','g'};
filestart0='wpwb_10_4km_bipit_del250_';
filestart0v='wpwb_10_4km_bipit_del250_64visc_';
filestart1='wpwb_10_4km_bipit_del250_2100_v3_';
filestart1v='wpwb_10_4km_bipit_del250_2100_v3_64visc_';
fileend='_np.mat';

fct=1;
fn=strcat(filestart1v,filemid{fct},fileend);
load(fn,'varmeans','ocean_time')
time=ocean_time;
z=varmeans.z;
varmeans1v.wbd=varmeans.wbd;
varmeans1v.wpd=varmeans.wpd;
varmeans1v.wpbp=varmeans.wpbp;
varmeans1v.wppp=varmeans.wppp;
fn=strcat(filestart1,filemid{fct},fileend);
load(fn,'varmeans')
varmeans1.wbd=varmeans.wbd;
varmeans1.wpd=varmeans.wpd;
varmeans1.wpbp=varmeans.wpbp;
varmeans1.wppp=varmeans.wppp;
fn=strcat(filestart0,filemid{fct},fileend);
load(fn,'varmeans')
varmeans0.wbd=varmeans.wbd;
varmeans0.wpd=varmeans.wpd;
varmeans0.wpbp=varmeans.wpbp;
varmeans0.wppp=varmeans.wppp;
fn=strcat(filestart0v,filemid{fct},fileend);
load(fn,'varmeans')
varmeans0v.wbd=varmeans.wbd;
varmeans0v.wpd=varmeans.wpd;
varmeans0v.wpbp=varmeans.wpbp;
varmeans0v.wppp=varmeans.wppp;


for fct=2:7
fn=strcat(filestart1v,filemid{fct},fileend);
load(fn,'varmeans','ocean_time')
time=cat(1,time,ocean_time);
varmeans1v.wbd=cat(2,varmeans1v.wbd,varmeans.wbd);
varmeans1v.wpd=cat(2,varmeans1v.wpd,varmeans.wpd);
varmeans1v.wpbp=cat(2,varmeans1v.wpbp,varmeans.wpbp);
varmeans1v.wppp=cat(2,varmeans1v.wppp,varmeans.wppp);

fn=strcat(filestart1,filemid{fct},fileend);
load(fn,'varmeans')
varmeans1.wbd=cat(2,varmeans1.wbd,varmeans.wbd);
varmeans1.wpd=cat(2,varmeans1.wpd,varmeans.wpd);
varmeans1.wpbp=cat(2,varmeans1.wpbp,varmeans.wpbp);
varmeans1.wppp=cat(2,varmeans1.wppp,varmeans.wppp);
fn=strcat(filestart0v,filemid{fct},fileend);
load(fn,'varmeans')
varmeans0v.wbd=cat(2,varmeans0v.wbd,varmeans.wbd);
varmeans0v.wpd=cat(2,varmeans0v.wpd,varmeans.wpd);
varmeans0v.wpbp=cat(2,varmeans0v.wpbp,varmeans.wpbp);
varmeans0v.wppp=cat(2,varmeans0v.wppp,varmeans.wppp);
fn=strcat(filestart0,filemid{fct},fileend);
load(fn,'varmeans')
varmeans0.wbd=cat(2,varmeans0.wbd,varmeans.wbd);
varmeans0.wpd=cat(2,varmeans0.wpd,varmeans.wpd);
varmeans0.wpbp=cat(2,varmeans0.wpbp,varmeans.wpbp);
varmeans0.wppp=cat(2,varmeans0.wppp,varmeans.wppp);
end

%% seasonal cycle
load('nprod_10_4km_bipit_del250_2100_v3_means.mat', 'yeari','days')

holdvar=varmeans1v.wbd;
[days,wbd1v]=make_seasonal_fields(5+time/86400,yeari(:,1),yeari(:,end),holdvar);
[~,wpd1v]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans1v.wpd);
[~,wpbp1v]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans1v.wpbp);
[~,wppp1v]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans1v.wppp);

[~,wbd1]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans1.wbd);
[~,wpd1]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans1.wpd);
[~,wpbp1]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans1.wpbp);
[~,wppp1]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans1.wppp);

[~,wbd0]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans0.wbd);
[~,wpd0]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans0.wpd);
[~,wpbp0]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans0.wpbp);
[~,wppp0]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans0.wppp);

[~,wbd0v]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans0v.wbd);
[~,wpd0v]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans0v.wpd);
[~,wpbp0v]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans0v.wpbp);
[~,wppp0v]=make_seasonal_fields(time,yeari(:,1),yeari(:,end),varmeans0v.wppp);
days1=5+days1/86400;
%% plot wb
figure; 
subplot(2,3,1)
contourf(days,-z,wpbp0,-2.2e-9:1e-10:1.4e-8,'LineStyle','none'); 
caxis([-2.2e-9 1.4e-8]); cmocean('balance','pivot',0);  %-2.21e-9:1.3e-8
hold on; plot(days1,Mldpop,'k')
datetick('x',3); axis tight; ylim([-350 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

subplot(2,3,2)
contourf(days,-z,wpbp0v,-2.2e-9:1e-10:1.4e-8,'LineStyle','none');
caxis([-2.2e-9 1.4e-8]); cmocean('balance','pivot',0); colorbar %-2.01e-9:1.33e-9
hold on; plot(days1,Mldpopv,'k')
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

subplot(2,3,3)
contourf(days,-z,wpbp0v-wpbp0,-8.6e-9:1e-10:2.1e-9,'LineStyle','none');
cmocean('balance','pivot',0); colorbar %-8.57e-9:2.08e-9
hold on; plot(days1,Mldpop,'k')
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

subplot(2,3,4)
contourf(days,-z,wpbp1,-4.7e-10:1e-11:6.7e-9,'LineStyle','none'); 
cmocean('balance','pivot',0); colorbar %-4.666e-10:6.6e-9
hold on; plot(days1,Mldpop1,'k')
datetick('x',3); axis tight; ylim([-150 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

subplot(2,3,5)
contourf(days,-z,wpbp1v,-4.7e-10:1e-11:6.7e-9,'LineStyle','none'); 
cmocean('balance','pivot',0); colorbar %-1.59e-9:6.45e-9
hold on; plot(days1,Mldpop1v,'k')
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('WP','MLD')

subplot(2,3,6)
contourf(days,-z,wpbp1v-wpbp1,-3.3e-9:1e-11:8.5e-10,'LineStyle','none'); 
cmocean('balance','pivot',0); colorbar %-3.27e-9:8.415e-10
hold on; plot(days1,Mldpop1,'k')
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})
%%

figure; 
subplot(2,3,1)
pcolor(days,-z,wbd0); shading 'flat'; colorbar 
hold on; plot(days1,Mldpop,'k')
subplot(2,3,2)
pcolor(days,-z,wbd0v); shading 'flat'; colorbar 
hold on; plot(days1,Mldpopv,'k')
subplot(2,3,3)
pcolor(days,-z,wbd0v-wbd0); shading 'flat'; colorbar 
hold on; plot(days1,Mldpop,'k')
subplot(2,3,4)
pcolor(days,-z,wbd1); shading 'flat'; colorbar 
hold on; plot(days1,Mldpop1,'k')
subplot(2,3,5)
pcolor(days,-z,wbd1v); shading 'flat'; colorbar 
hold on; plot(days1,Mldpop1v,'k')
subplot(2,3,6)
pcolor(days,-z,wbd1v-wbd1); shading 'flat'; colorbar 
hold on; plot(days1,Mldpop1,'k')
%% plot wp

figure; 
ax1=subplot(2,3,1); contourf(days,-z,wppp0,-6e-7:1e-8:2e-7,'LineStyle','none'); %-5.1e-7:4.74e-9
hold on; plot(days1,Mldpop,'k')
 caxis([-5e-7 1e-8]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,3,2); contourf(days,-z,wppp0v,-4e-7:1e-8:2e-7,'LineStyle','none'); %-2.44e-7:4.86e-10
hold on; plot(days1,Mldpopv,'k')
caxis([-5e-7 1e-8]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,3,3); contourf(days,-z,wppp0v-wppp0,-6e-7:1e-8:4e-7,'LineStyle','none'); %-1.54e-8:3.14e-7
hold on; plot(days1,Mldpopv,'k')
caxis([-1e-8 4e-7]); cmocean('curl','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(2,3,4); contourf(days,-z,wppp1,-1.1e-8:1e-10:2e-9,'LineStyle','none'); %-1.02e-8:8.67e-10
hold on; plot(days1,Mldpop1,'k')
caxis([-1e-8 1e-10]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(2,3,5); contourf(days,-z,wppp1v,-1.1e-8:1e-10:2e-9,'LineStyle','none'); %-9.02e-9:2.95e-10
hold on; plot(days1,Mldpop1v,'k')
caxis([-1e-8 1e-10]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('WP','MLD')

ax6=subplot(2,3,6); contourf(days,-z,wppp1v-wppp1,-6e-9:0.1e-9:6e-9,'LineStyle','none'); %-3.96e-9:6.34e-9
hold on; plot(days1,Mldpop1v,'k')
caxis([-5e-9 5e-9]); cmocean('curl','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})

%%
figure; 
ax1=subplot(2,3,1); contourf(days,-z,wpd0,-6e-7:1e-8:2e-7,'LineStyle','none'); 
hold on; plot(days1,Mldpop,'k')
 caxis([-5e-7 3e-8]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,3,2); contourf(days,-z,wpd0v,-4e-7:1e-8:4e-7,'LineStyle','none');
hold on; plot(days1,Mldpopv,'k')
caxis([-5e-7 3e-8]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,3,3); contourf(days,-z,wpd0v-wpd0,-2e-7:1e-8:4e-7,'LineStyle','none');
hold on; plot(days1,Mldpopv,'k')
caxis([-1e-8 4e-7]); cmocean('curl','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(2,3,4); contourf(days,-z,wpd1,-1.5e-8:1e-10:3e-9,'LineStyle','none'); 
hold on; plot(days1,Mldpop1,'k')
caxis([-1.5e-8 1e-9]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(2,3,5); contourf(days,-z,wpd1v,-1.5e-8:1e-10:3e-9,'LineStyle','none'); 
hold on; plot(days1,Mldpop1v,'k')
caxis([-1.5e-8 1e-9]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('WP','MLD')

ax6=subplot(2,3,6); contourf(days,-z,wpd1v-wpd1,-8e-9:0.1e-9:10e-9,'LineStyle','none'); 
hold on; plot(days1,Mldpop1v,'k')
caxis([-5e-9 5e-9]); cmocean('curl','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})




