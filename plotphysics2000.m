%plot 2000 seasonal cycle physical state ROMS standard vs viscous

load('ts_10_4km_bipit_del250_64visc_means.mat')
Tv=T; Sv=S; Pdenv=Pden; Hsblv=Hsbl; Mldpopv=Mldpop;
load('ts_10_4km_bipit_del250_means.mat')
load('nprod_10_4km_bipit_del250_64visc_means.mat', 'w2')
w2v=w2;
load('nprod_10_4km_bipit_del250_means.mat', 'w2')
%% Plot full column
%figure;  %embiggen this before continuing!
subplot(4,3,1); contourf(days,-varmean1.z,T,5:0.25:19,'LineStyle','none'); 
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('thermal'); caxis([6 18])
set(gca,'fontsize',12);xlabel('(a)') 
subplot(4,3,2); contourf(days,-varmean1.z,Tv,5:0.25:19,'LineStyle','none'); colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('thermal'); caxis([6 18])
set(gca,'fontsize',12);xlabel('(b)')
subplot(4,3,3); contourf(days,-varmean1.z,Tv-T,-0.5:0.025:0.2,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(c)')

subplot(4,3,4); contourf(days,-varmean1.z,S,34:0.1:36,'LineStyle','none');
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('haline'); caxis([34.9 35.6])
set(gca,'fontsize',12);xlabel('(d)')
subplot(4,3,5); contourf(days,-varmean1.z,Sv,34:0.1:36,'LineStyle','none');  colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k-.'); caxis([34.9 35.6])
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('haline')
set(gca,'fontsize',12);xlabel('(e)')
subplot(4,3,6); contourf(days,-varmean1.z,Sv-S,-0.1:0.005:0.1,'LineStyle','none');  colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(f)')

subplot(4,3,7); contourf(days,-varmean1.z,Pden,24.8:0.1:28.2,'LineStyle','none'); 
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('matter'); caxis([25 27.5])
set(gca,'fontsize',12);xlabel('(g)')
subplot(4,3,8); contourf(days,-varmean1.z,Pdenv,24.8:0.1:28.2,'LineStyle','none'); colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('matter'); caxis([25 27.5])
set(gca,'fontsize',12);xlabel('(h)')
subplot(4,3,9); contourf(days,-varmean1.z,Pdenv-Pden,-0.05:0.005:0.05,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(i)')

subplot(4,3,10); contourf(days,-varmean1.z,w2,0:0.5e-9:3e-8,'LineStyle','none');
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('amp'); caxis([1e-9 2.25e-8])
set(gca,'fontsize',12);xlabel('(j)')
subplot(4,3,11); contourf(days,-varmean1.z,w2v,0:0.5e-9:3e-8,'LineStyle','none');  colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('amp'); caxis([1e-9 2.25e-8])
set(gca,'fontsize',12);xlabel('(k)')
subplot(4,3,12); contourf(days,-varmean1.z,w2v-w2,-2e-8:0.05e-9:1e-8,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel('(l)')
%% Plot top 300m
%figure;  %embiggen this before continuing!
subplot(4,3,1); contourf(days,-varmean1.z,T,5:0.25:19,'LineStyle','none'); 
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('thermal'); caxis([10 18]); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(a)');title('Standard')
subplot(4,3,2); contourf(days,-varmean1.z,Tv,5:0.25:19,'LineStyle','none'); colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('thermal'); caxis([10 18]); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(b)'); title('Viscous')
subplot(4,3,3); contourf(days,-varmean1.z,Tv-T,-0.5:0.025:0.2,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(c)'); title('Difference')

subplot(4,3,4); contourf(days,-varmean1.z,S,34:0.1:36,'LineStyle','none');
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('haline'); caxis([34.9 35.6]); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(d)')
subplot(4,3,5); contourf(days,-varmean1.z,Sv,34:0.1:36,'LineStyle','none');  colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k-.'); caxis([34.9 35.6])
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('haline'); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(e)')
subplot(4,3,6); contourf(days,-varmean1.z,Sv-S,-0.1:0.005:0.1,'LineStyle','none');  colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(f)')

subplot(4,3,7); contourf(days,-varmean1.z,Pden,24.8:0.1:28.2,'LineStyle','none'); 
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('matter'); caxis([25 27]); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(g)')
subplot(4,3,8); contourf(days,-varmean1.z,Pdenv,24.8:0.1:28.2,'LineStyle','none'); colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('matter'); caxis([25 27]); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(h)')
subplot(4,3,9); contourf(days,-varmean1.z,Pdenv-Pden,-0.05:0.005:0.05,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(i)')

subplot(4,3,10); contourf(days,-varmean1.z,w2,0:0.5e-9:3e-8,'LineStyle','none');
hold on; plot(days,Hsbl,'w',days,Mldpop,'k')
datetick('x',3); axis tight; cmocean('amp'); caxis([1e-9 2.25e-8]); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(j)')
subplot(4,3,11); contourf(days,-varmean1.z,w2v,0:0.5e-9:3e-8,'LineStyle','none');  colorbar
hold on; plot(days,Hsblv,'w',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('amp'); caxis([1e-9 2.25e-8]); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(k)')
subplot(4,3,12); contourf(days,-varmean1.z,w2v-w2,-2e-8:0.05e-9:1e-8,'LineStyle','none'); colorbar
hold on; plot(days,Mldpop,'k',days,Mldpopv,'k-.')
datetick('x',3); axis tight; set(gca,'YTickLabels',{}); cmocean('balance','pivot',0); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(l)')

