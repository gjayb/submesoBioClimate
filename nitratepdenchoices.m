load('WOA_nsfsubmeso_no3-pden_fit_31_aug_2020.mat');
no3_set(1:41,:)=reshape(shiftdim(no3_west,2),41,[]);
no3_set=cat(2,no3_set,reshape(shiftdim(no3_east,2),41,[]));
no3_set=cat(2,no3_set,reshape(shiftdim(no3_north,2),41,[]));
no3_set=cat(2,no3_set,reshape(shiftdim(no3_south,2),41,[]));

load('CESMLE_NO3_pden_osmosis.mat');
no3_anomLE=interp1(0.5.*[1024 pden_z_edge(1:end-1)]+0.5.*pden_z_edge,squeeze(nanmean(NO3_pden_osmosis(:,end,:)-NO3_pden_osmosis(:,1,:),3)),pdout,'linear',0);
no3_anomLE(pdout<1025)=0;
no3_anomLE(end)=0;

load('sigmanutriOsmosis2.mat');
no3_anomJ=interp1(dcenters+1000,squeeze(nd1-nd),pdout,'linear',0);
no3_anomJ(no3_anomJ<0)=0;
no3_anomJ(pdout<1025)=0;

no3_anomLE(42)=0;
no3_anomJ(42)=0;
no3_set(42,:)=no3_set(41,:);
pdout(42)=1029;

no3woa=nanmean(no3_set,2);
no3woamm=nanmax(no3_set,[],2);
no3woamm(:,2)=nanmin(no3_set,[],2);
%% plot

figure; plot(no3woa,pdout,'k','linewidth',2)
hold on; plot(no3woa+no3_anomLE.',pdout,'b')
plot(no3woa+no3_anomJ.',pdout,'r')

plot(no3woamm,pdout,'k--')

set(gca,'Ydir','reverse')
set(gca,'fontsize',12)
ylabel('\sigma_\theta')
xlabel('mmol N/m^3')
legend('WOA mean','+CESM-LE 2100 anomalies','+CESM timeslice anomalies','WOA range')

%% output
load('npden_10_4km_bipit_del250_2100_v3_a_np.mat', 'filemid')

no3set0=NaN(8,18);
pdenset0=NaN(8,18);
for i=1:8 
    load(strcat('npden_10_4km_bipit_del250_',filemid{i},'_np.mat'), 'meanno3','meanpden');
    no3set0(i,:)=meanno3;pdenset0(i,:)=meanpden; 
end

no3set1=NaN(7,18);
pdenset1=NaN(7,18);
for i=1:7
    load(strcat('npden_10_4km_bipit_del250_2100_',filemid{i},'_np.mat'), 'meanno3','meanpden');
    no3set1(i,:)=meanno3;pdenset1(i,:)=meanpden; 
end

no3set2=NaN(7,18);
pdenset2=NaN(7,18);
for i=1:7 
    load(strcat('npden_10_4km_bipit_del250_2100_v2_',filemid{i},'_np.mat'), 'meanno3','meanpden');
    no3set2(i,:)=meanno3;pdenset2(i,:)=meanpden; 
end

no3set3=NaN(7,18);
pdenset3=NaN(7,18);
for i=1:7 
    load(strcat('npden_10_4km_bipit_del250_2100_v3_',filemid{i},'_np.mat'), 'meanno3','meanpden');
    no3set3(i,:)=meanno3;pdenset3(i,:)=meanpden; 
end
clear meanno3 meanpden
%% plot
figure; plot(no3woa,pdout,'k')
hold on; 
plot(no3woa+no3_anomLE.',pdout,'b')
%plot(no3woa+no3_anomJ.',pdout,'r')

no3set3(:,18)=18;pdenset3(:,18)=28;
no3set1(:,18)=18;pdenset1(:,18)=28;
no3set2(:,18)=18;pdenset2(:,18)=28;
plot([nanmean(no3set0,1) 18],1000+[nanmean(pdenset0,1) 29],'k--','linewidth',2)
plot([nanmean(no3set3,1) 18],1000+[nanmean(pdenset3,1) 29],'k-.','linewidth',2)
plot([nanmean(no3set1,1) 18],1000+[nanmean(pdenset1,1) 29],'b-.','linewidth',2)
plot(no3woamm,pdout,'k--')
%plot([nanmean(no3set2,1) 18],1000+[nanmean(pdenset2,1) 29],'r-.','linewidth',2)


set(gca,'Ydir','reverse')
set(gca,'fontsize',12)
ylabel('\sigma_\theta')
xlabel('mmol N/m^3')
legend('WOA mean','WOA mean +CESM-LE 2100 anomalies','2000s','2100 constant','2100 CESMLE','WOA range') %'+CESM timeslice anomalies', ,'2100 CESM timeslice'
ylim([1024.5 1028.5])