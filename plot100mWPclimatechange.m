%% load
load('pset_10_4km_bipit_del250_2100_v3_64visc_means.mat','varmeans1')
wsp1v=-5*varmeans1.p(11,:)./86400;
wp1v=varmeans1.wp(11,:);
wppp1v=varmeans1.wppp(11,:);

load('pset_10_4km_bipit_del250_2100_v3_means.mat','varmeans1')
wsp1=-5*varmeans1.p(11,:)./86400;
wp1=varmeans1.wp(11,:);
wppp1=varmeans1.wppp(11,:);

load('pset_10_4km_bipit_del250_means.mat','varmeans1','ocean_day')
wsp0=-5*varmeans1.p(11,:)./86400;
wp0=varmeans1.wp(11,:);
wppp0=varmeans1.wppp(11,:);
day0=ocean_day;
day1=ocean_day(1:840);


load('pset_10_4km_bipit_del250_64visc_means.mat','varmeans1')
wsp0v=-5*varmeans1.p(11,:)./86400;
wp0v=varmeans1.wp(11,:);
wppp0v=varmeans1.wppp(11,:);

%% plot

%figure
subplot(4,1,1)
plot(day0,wsp0+wp0,'LineWidth',2)
hold on; plot(day0,wsp0v+wp0v)
plot(day1,wsp1+wp1,'LineWidth',2)
plot(day1,wsp1v+wp1v)
set(gca,'fontsize',12)
ylabel({'total','mmol P m/s'})
datetick('x',4)
xlim([4052 5310])


subplot(4,1,2)
plot(day0,wsp0,'LineWidth',2)
hold on; plot(day0,wsp0v)
plot(day1,wsp1,'LineWidth',2)
plot(day1,wsp1v)
set(gca,'fontsize',12)
ylabel({'w_sP','mmol P m/s'})
xlim([4052 5310])
datetick('x',4)

subplot(4,1,3)
plot(day0,wp0,'LineWidth',2)
hold on; plot(day0,wp0v)
plot(day1,wp1,'LineWidth',2)
plot(day1,wp1v)
set(gca,'fontsize',12)
ylabel({'wP','mmol P m/s'})
xlim([4052 5310])
datetick('x',4)

subplot(4,1,4)
plot(day0,wppp0,'LineWidth',2)
hold on; plot(day0,wppp0v)
plot(day1,wppp1,'LineWidth',2)
plot(day1,wppp1v)
set(gca,'fontsize',12)
ylabel({'wP','mmol P m/s'})
xlim([4052 5310])
datetick('x',4)
xlabel('simulation month')
legend('2000','2000 visc','2100','2100 visc')