%% load
filemid={'a','b','c','d','e','f','g'};
filestart0='pset_10_4km_bipit_del250_';
filestart0v='pset_10_4km_bipit_del250_64visc_';
filestart1='pset_10_4km_bipit_del250_2100_v3_';
filestart1v='pset_10_4km_bipit_del250_2100_v3_64visc_';
fileend='_his.mat';

fct=1;
fn=strcat(filestart1v,filemid{fct},fileend);
load(fn,'varmeans','ocean_time')
time=ocean_time;
wsp1v=-5*varmeans.p(11,:)./86400;
wp1v=varmeans.wp(11,:);
wppp1v=varmeans.wppp(11,:);
fn=strcat(filestart1,filemid{fct},fileend);
load(fn,'varmeans')
wsp1=-5*varmeans.p(11,:)./86400;
wp1=varmeans.wp(11,:);
wppp1=varmeans.wppp(11,:);
fn=strcat(filestart0,filemid{fct},fileend);
load(fn,'varmeans')
wsp0=-5*varmeans.p(11,:)./86400;
wp0=varmeans.wp(11,:);
wppp0=varmeans.wppp(11,:);
fn=strcat(filestart0v,filemid{fct},fileend);
load(fn,'varmeans')
wsp0v=-5*varmeans.p(11,:)./86400;
wp0v=varmeans.wp(11,:);
wppp0v=varmeans.wppp(11,:);


for fct=2:7
fn=strcat(filestart1v,filemid{fct},fileend);
load(fn,'varmeans','ocean_time')
time=cat(1,time,ocean_time);
wsp1v=cat(2,wsp1v,-5*varmeans.p(11,:)./86400);
wp1v=cat(2,wp1v,varmeans.wp(11,:));
wppp1v=cat(2,wppp1v,varmeans.wppp(11,:));
fn=strcat(filestart1,filemid{fct},fileend);
load(fn,'varmeans')
wsp1=cat(2,wsp1,-5*varmeans.p(11,:)./86400);
wp1=cat(2,wp1,varmeans.wp(11,:));
wppp1=cat(2,wppp1,varmeans.wppp(11,:));
fn=strcat(filestart0v,filemid{fct},fileend);
load(fn,'varmeans')
wsp0v=cat(2,wsp0v,-5*varmeans.p(11,:)./86400);
wp0v=cat(2,wp0v,varmeans.wp(11,:));
wppp0v=cat(2,wppp0v,varmeans.wppp(11,:));
fn=strcat(filestart0,filemid{fct},fileend);
load(fn,'varmeans')
wsp0=cat(2,wsp0,-5*varmeans.p(11,:)./86400);
wp0=cat(2,wp0,varmeans.wp(11,:));
wppp0=cat(2,wppp0,varmeans.wppp(11,:));
end



%% plot
day0=5+time/86400;
day1=day0;
%figure
subplot(4,1,1)
plot(day0,wsp0+wp0,'LineWidth',2)
hold on; plot(day0,wsp0v+wp0v)
plot(day1,wsp1+wp1,'LineWidth',2)
plot(day1,wsp1v+wp1v)
set(gca,'fontsize',12)
ylabel({'total','mmol P m/s'})
datetick('x',3)
xlim([4052 5310])


subplot(4,1,2)
plot(day0,wsp0,'LineWidth',2)
hold on; plot(day0,wsp0v)
plot(day1,wsp1,'LineWidth',2)
plot(day1,wsp1v)
set(gca,'fontsize',12)
ylabel({'w_sP','mmol P m/s'})
datetick('x',4)
xlim([4052 5310])

subplot(4,1,3)
plot(day0,wp0,'LineWidth',2)
hold on; plot(day0,wp0v)
plot(day1,wp1,'LineWidth',2)
plot(day1,wp1v)
set(gca,'fontsize',12)
ylabel({'wP','mmol P m/s'})
datetick('x',3)
xlim([4052 5310])

subplot(4,1,4)
plot(day0,wppp0,'LineWidth',2)
hold on; plot(day0,wppp0v)
plot(day1,wppp1,'LineWidth',2)
plot(day1,wppp1v)
set(gca,'fontsize',12)
ylabel({'wP','mmol P m/s'})
datetick('x',4)
xlim([4052 5310])
xlabel('simulation month')
legend('2000','2000 visc','2100','2100 visc')

