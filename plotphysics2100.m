%plot 2000 seasonal cycle physical state ROMS standard vs viscous
load('nprod_10_4km_bipit_del250_2100_v3_64visc_means.mat', 'days')
daysw=days;
load('ts_10_4km_bipit_del250_2100_v3_64visc_means.mat')
Tv=T; Sv=S; Pdenv=Pden; Hsblv=Hsbl; Mldpopv=Mldpop;
load('ts_10_4km_bipit_del250_2100_v3_means.mat')
load('nprod_10_4km_bipit_del250_2100_v3_64visc_means.mat', 'w2')
w2v=w2;
load('nprod_10_4km_bipit_del250_2100_v3_means.mat', 'w2')
%% Plot full column
%figure;  %embiggen this before continuing!
subplot(4,3,1); contourf(days,-varmeans1.z,T,5:0.25:22,'LineStyle','none'); 
hold on; plot(days,Hsbl,'w',days,Mldpop,'m')
datetick('x',3); axis tight; cmocean('thermal'); caxis([6.5 21])
set(gca,'fontsize',12);xlabel('(a)') 
subplot(4,3,2); contourf(days,-varmeans1.z,Tv,5:0.25:22,'LineStyle','none'); colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'m')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('thermal'); caxis([6.5 21])
set(gca,'fontsize',12);xlabel('(b)')
subplot(4,3,3); contourf(days,-varmeans1.z,Tv-T,-1.1:0.025:0.3,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'m',days,Mldpopv,'m-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(c)')

subplot(4,3,4); contourf(days,-varmeans1.z,S,33:0.1:36,'LineStyle','none');
hold on; plot(days,Hsbl,'w',days,Mldpop,'m')
datetick('x',3); axis tight; cmocean('haline'); caxis([33.9 35.9])
set(gca,'fontsize',12);xlabel('(d)')
subplot(4,3,5); contourf(days,-varmeans1.z,Sv,33:0.1:36,'LineStyle','none');  colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'m-.'); caxis([33.9 35.9])
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('haline')
set(gca,'fontsize',12);xlabel('(e)')
subplot(4,3,6); contourf(days,-varmeans1.z,Sv-S,-0.3:0.005:0.1,'LineStyle','none');  colorbar
hold on; plot(days,Mldpop,'m',days,Mldpopv,'m-.'); caxis([-0.25 0])
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(f)')

subplot(4,3,7); contourf(days,-varmeans1.z,Pden,23.4:0.1:27.5,'LineStyle','none'); 
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('matter'); caxis([24 27.5])
set(gca,'fontsize',12);xlabel('(g)')
subplot(4,3,8); contourf(days,-varmeans1.z,Pdenv,23.4:0.1:27.5,'LineStyle','none'); colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('matter'); caxis([24 27.5])
set(gca,'fontsize',12);xlabel('(h)')
subplot(4,3,9); contourf(days,-varmeans1.z,Pdenv-Pden,-0.1:0.005:0.05,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(i)')

subplot(4,3,10); contourf(daysw,-varmeans1.z,w2,0:0.25e-9:2e-8,'LineStyle','none');
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('amp'); caxis([0 1e-8])
set(gca,'fontsize',12);xlabel('(j)')
subplot(4,3,11); contourf(daysw,-varmeans1.z,w2v,0:0.25e-9:2e-8,'LineStyle','none');  colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('amp'); caxis([0 1e-8])
set(gca,'fontsize',12);xlabel('(k)')
subplot(4,3,12); contourf(daysw,-varmeans1.z,w2v-w2,-2e-8:0.05e-9:1e-8,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(l)')
%% Plot top 300m
%figure;  %embiggen this before continuing!
subplot(4,3,1); contourf(days,-varmeans1.z,T,5:0.25:22,'LineStyle','none'); 
hold on; plot(days,Hsbl,'w',days,Mldpop,'m')
datetick('x',3); axis tight; cmocean('thermal'); caxis([10 21])
set(gca,'fontsize',12);xlabel('(a)'); ylim([-200 -5]); ylabel('Temperature')
subplot(4,3,2); contourf(days,-varmeans1.z,Tv,5:0.25:22,'LineStyle','none'); colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'m')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('thermal'); caxis([10 21])
set(gca,'fontsize',12);xlabel('(b)'); ylim([-200 -5])
subplot(4,3,3); contourf(days,-varmeans1.z,Tv-T,-1.1:0.025:0.3,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'m',days,Mldpopv,'m-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(c)'); ylim([-200 -5])

subplot(4,3,4); contourf(days,-varmeans1.z,S,33:0.1:36,'LineStyle','none');
hold on; plot(days,Hsbl,'w',days,Mldpop,'m')
datetick('x',3); axis tight; cmocean('haline'); caxis([33.2 35.5])
set(gca,'fontsize',12);xlabel('(d)'); ylim([-200 -5]); ylabel('Salinity')
subplot(4,3,5); contourf(days,-varmeans1.z,Sv,33:0.1:36,'LineStyle','none');  colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'m-.'); caxis([33.2 35.5])
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('haline')
set(gca,'fontsize',12);xlabel('(e)'); ylim([-200 -5])
subplot(4,3,6); contourf(days,-varmeans1.z,Sv-S,-0.3:0.005:0.1,'LineStyle','none');  colorbar
hold on; plot(days,Mldpop,'m',days,Mldpopv,'m-.'); caxis([-0.25 0])
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(f)'); ylim([-200 -5])

subplot(4,3,7); contourf(days,-varmeans1.z,Pden,23.4:0.1:27.5,'LineStyle','none'); 
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('matter'); caxis([24 27])
set(gca,'fontsize',12);xlabel('(g)'); ylim([-200 -5]); ylabel('\sigma_\theta');
subplot(4,3,8); contourf(days,-varmeans1.z,Pdenv,23.4:0.1:27.5,'LineStyle','none'); colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('matter'); caxis([24 27])
set(gca,'fontsize',12);xlabel('(h)'); ylim([-200 -5])
subplot(4,3,9); contourf(days,-varmeans1.z,Pdenv-Pden,-0.15:0.005:0.05,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(i)'); ylim([-200 -5])

subplot(4,3,10); contourf(daysw,-varmeans1.z,w2,0:1e-10:8e-9,'LineStyle','none');
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('amp'); caxis([0 2e-9])
set(gca,'fontsize',12);xlabel({'months','(j)'}); ylim([-200 -5]); ylabel('w^2')
subplot(4,3,11); contourf(daysw,-varmeans1.z,w2v,0:1e-10:8e-9,'LineStyle','none');  colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('amp'); caxis([0 2e-9])
set(gca,'fontsize',12);xlabel('(k)'); ylim([-200 -5])
subplot(4,3,12); contourf(daysw,-varmeans1.z,w2v-w2,-2e-9:0.25e-10:5e-9,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); caxis([-1.5e-9 0.5e-9]); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(l)'); ylim([-200 -5])
