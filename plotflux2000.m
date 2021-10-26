%load wn
load('nprod_10_4km_bipit_del250_64visc_means.mat', 'wpnp')
wpnpv=wpnp;
load('nprod_10_4km_bipit_del250_means.mat', 'wpnp')

%load wp
load('pset_10_4km_bipit_del250_64visc_means.mat', 'wpppvisc','varmeans1')
z=varmeans1.z; clear varmeans1
load('pset_10_4km_bipit_del250_means.mat', 'wppp','days')

%% plot 2000s wn, wp, diff viscous-standard
%ylim([-300 -5]) is fine
%figure %make big
subplot(2,3,1)
contourf(days,-z,wpnp,-9e-6:0.25e-6:7e-6,'LineStyle','none'); colorbar
datetick('x',3); axis tight; cmocean('balance','pivot',0); ylim([-300 -5]); %caxis([0 10])
%hold on; contour(days,-varmeans.z,n,[3.2 3.2],'w')
hold on; plot(days,Mldpop,'k')
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('submesoscale WN')
caxis([-7e-6 7e-6])
subplot(2,3,2)
contourf(days,-z,wpnpv,-9e-6:0.25e-6:7e-6,'LineStyle','none'); colorbar; %caxis([0 10])
%hold on; contour(days,-varmeans.z,nv,[3.2 3.2],'Color',[0.5 0.5 0.5])
hold on; plot(days,Mldpopv,'m')
datetick('x',3); axis tight;  ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(b)');title('Viscous');set(gca,'YTickLabel',{})
caxis([-7e-6 7e-6]);cmocean('balance','pivot',0);
subplot(2,3,3)
contourf(days,-z,wpnpv-wpnp,-5e-6:0.1e-6:3e-6,'LineStyle','none'); colorbar
%hold on; contour(days,-varmeans.z,nv-n,[0 0],'w')
datetick('x',3); axis tight;  ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(c)');title('Difference');set(gca,'YTickLabel',{}); cmocean('balance','pivot',0);
%hold on; contour(days,-varmeans.z,nv,[3.2 3.2],'Color',[0.5 0.5 0.5])
%hold on; contour(days,-varmeans.z,n,[3.2 3.2],'w')
%caxis([-0.5 0.5]);
hold on; plot(days,Mldpop,'k',days,Mldpopv,'m')

subplot(2,3,4)
contourf(days,-z,wppp,-5.5e-7:0.25e-7:1e-7,'LineStyle','none'); colorbar; %caxis([0 0.22])
datetick('x',3); axis tight; ylim([-300 -5])
%hold on; contour(days,-z,Prodn,[0.001 0.001],'w')
hold on; plot(days,Mldpop,'k'); caxis([-5e-7 0]); cmocean('balance','pivot',0)
set(gca,'fontsize',12);xlabel({'month','(d)'});ylabel({'submesoscale WP','depth, m'})
subplot(2,3,5)
contourf(days,-z,wpppvisc,-5e-7:0.25e-7:1e-7,'LineStyle','none'); colorbar; %caxis([0 0.22])
caxis([-5e-7 0]); cmocean('balance','pivot',0)
%hold on; contour(days,-z,Prodv,[0.001 0.001],'Color',[0.5 0.5 0.5])
hold on; plot(days,Mldpopv,'m')
datetick('x',3); axis tight; ylim([-300 -5])
set(gca,'fontsize',12);xlabel('(e)');set(gca,'YTickLabel',{})
subplot(2,3,6)
contourf(days,-z,wpppvisc-wppp,-1e-7:0.125e-7:3.5e-7,'LineStyle','none'); colorbar
datetick('x',3); axis tight; ylim([-300 -5]); cmocean('balance','pivot',0);
% hold on; contour(days,-varmeans.z,Prodv-Prodn,[0 0],'w')
set(gca,'fontsize',12);xlabel('(f)');set(gca,'YTickLabel',{})
%hold on; contour(days,-z,Prodv,[0.001 0.001],'Color',[0.5 0.5 0.5])
%hold on; contour(days,-z,Prodn,[0.001 0.001],'w')
hold on; plot(days,Mldpop,'k',days,Mldpopv,'m')

%% 