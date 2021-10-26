%% plot 2000s N,P,Prod
%% load
load('nprod_10_4km_bipit_del250_64visc_means.mat')
nv=n; 
Prodv=Prodn;
load('nprod_10_4km_bipit_del250_means.mat')
load('pset_10_4km_bipit_del250_64visc_means.mat','pvisc')
load('pset_10_4km_bipit_del250_means.mat','p')
load('ts_10_4km_bipit_del250_64visc_means.mat','Mldpop')
Mldpopv=Mldpop;
load('ts_10_4km_bipit_del250_means.mat','Mldpop')
%% plot
%figure %make big
subplot(3,3,1)
contourf(days,-varmeans.z,n,0:0.5:18,'LineStyle','none'); colorbar
datetick('x',3); axis tight; cmocean('amp',20); ylim([-300 -5]); caxis([0 10])
hold on; contour(days,-varmeans.z,n,[3.2 3.2],'w')
hold on; plot(days,Mldpop,'k')
set(gca,'fontsize',12);xlabel('(a)');title('Standard')
subplot(3,3,2)
contourf(days,-varmeans.z,nv,0:0.5:18,'LineStyle','none'); colorbar; caxis([0 10])
hold on; contour(days,-varmeans.z,nv,[3.2 3.2],'Color',[0.5 0.5 0.5])
hold on; plot(days,Mldpopv,'m')
datetick('x',3); axis tight; cmocean('amp',20); ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(b)');title('Viscous');set(gca,'YTickLabel',{})
subplot(3,3,3)
contourf(days,-varmeans.z,nv-n,-1:0.05:1,'LineStyle','none'); colorbar
%hold on; contour(days,-varmeans.z,nv-n,[0 0],'w')
datetick('x',3); axis tight;  ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(c)');title('Difference');set(gca,'YTickLabel',{})
hold on; contour(days,-varmeans.z,nv,[3.2 3.2],'Color',[0.5 0.5 0.5])
hold on; contour(days,-varmeans.z,n,[3.2 3.2],'w')
caxis([-0.5 0.5]);cmocean('balance','pivot',0);
hold on; plot(days,Mldpop,'k',days,Mldpopv,'m')

subplot(3,3,4)
contourf(days,-varmeans.z,p,0:0.005:0.16,'LineStyle','none'); colorbar; caxis([0 0.16])
datetick('x',3); axis tight; ylim([-300 -5])
cmocean('algae',32)
hold on; contour(days,-varmeans.z,p,[0.05 0.05],'w')
hold on; plot(days,Mldpop,'k')
set(gca,'fontsize',12);xlabel('(d)');
subplot(3,3,5)
contourf(days,-varmeans.z,pvisc,0:0.005:0.16,'LineStyle','none'); colorbar; caxis([0 0.16])
cmocean('algae',32)
hold on; contour(days,-varmeans.z,pvisc,[0.05 0.05],'Color',[0.5 0.5 0.5])
hold on; plot(days,Mldpopv,'m')
datetick('x',3); axis tight; ylim([-300 -5]);set(gca,'YTickLabel',{})
set(gca,'fontsize',12);xlabel('(e)');
subplot(3,3,6)
contourf(days,-varmeans.z,pvisc-p,-0.05:0.0025:0.05,'LineStyle','none'); colorbar
datetick('x',3); axis tight; ylim([-300 -5]); cmocean('balance','pivot',0);
%hold on; contour(days,-varmeans.z,pvisc-p,[0 0],'w')
set(gca,'fontsize',12);xlabel('(f)');set(gca,'YTickLabel',{})
hold on; contour(days,-varmeans.z,pvisc,[0.05 0.05],'Color',[0.5 0.5 0.5])
hold on; contour(days,-varmeans.z,p,[0.05 0.05],'w'); caxis([-0.015 0.035]); cmocean('balance','pivot',0);
hold on; plot(days,Mldpop,'k',days,Mldpopv,'m')


subplot(3,3,7)
contourf(days,-varmeans.z,Prodn,0:0.001:0.22,'LineStyle','none'); colorbar; caxis([0 0.22])
cmocean('rain',24)
datetick('x',3); axis tight; ylim([-300 -5])
hold on; contour(days,-varmeans.z,Prodn,[0.001 0.001],'w')
hold on; plot(days,Mldpop,'k')
set(gca,'fontsize',12);xlabel({'month','(g)'});ylabel('depth, m')
subplot(3,3,8)
contourf(days,-varmeans.z,Prodv,0:0.001:0.22,'LineStyle','none'); colorbar; caxis([0 0.22])
cmocean('rain',24)
hold on; contour(days,-varmeans.z,Prodv,[0.001 0.001],'Color',[0.5 0.5 0.5])
hold on; plot(days,Mldpopv,'m')
datetick('x',3); axis tight; ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(h)');set(gca,'YTickLabel',{})
subplot(3,3,9)
contourf(days,-varmeans.z,Prodv-Prodn,-0.010:0.002:0.010,'LineStyle','none'); colorbar
datetick('x',3); axis tight; ylim([-300 -5]); cmocean('balance','pivot',0);
% hold on; contour(days,-varmeans.z,Prodv-Prodn,[0 0],'w')
set(gca,'fontsize',12);xlabel('(i)');set(gca,'YTickLabel',{})
hold on; contour(days,-varmeans.z,Prodv,[0.001 0.001],'Color',[0.5 0.5 0.5])
hold on; contour(days,-varmeans.z,Prodn,[0.001 0.001],'w')
hold on; plot(days,Mldpop,'k',days,Mldpopv,'m')


