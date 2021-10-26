%% load
load('spring_10_4km_bipit_del250_c_np.mat')
varmeans0=varmeans;
varstds0=varstds;
ntimes0=ntimes;
load('spring_10_4km_bipit_del250_64visc_c_np.mat')
varmeans0v=varmeans;
varstds0v=varstds;
ntimes0v=ntimes;
load('spring_10_4km_bipit_del250_2100_v3_64visc_c_np.mat')
varmeans1v=varmeans;
varstds1v=varstds;
ntimes1v=ntimes;
load('spring_10_4km_bipit_del250_2100_v3_c_np.mat')
varmeans1=varmeans;
varstds1=varstds;
ntimes1=ntimes;
z=-varmeans1.z;
days=day;
%% plot MLD
figure; plot(day,varmeans0.mld(ntimes0),day,varmeans0v.mld(ntimes0v),day,varmeans1.mld(ntimes1),day,varmeans1v.mld(ntimes1v))
set(gca,'fontsize',12)
legend('2000','2000 visc','2100','2100 visc')
datetick('x',3)
ylabel('MLD, m')
xlabel('months')
title('MLD for 45.7-50.8N, 12.7-17.1W')

%% plot MLD std
figure; plot(day,varstds0.mld(ntimes0),day,varstds0v.mld(ntimes0v),day,varstds1.mld(ntimes1),day,varstds1v.mld(ntimes1v))
set(gca,'fontsize',12)
legend('2000','2000 visc','2100','2100 visc')
datetick('x',3)
ylabel('MLD, m')
xlabel('months')
title('MLD std for 45.7-50.8N, 12.7-17.1W')
%% plot mldpmstd for 2000s
figure; plot(day,varmeans0.mld(ntimes0),day,varmeans0v.mld(ntimes0v))
hold on; plot(day,varmeans0.mld(ntimes0)+varstds0.mld(ntimes0),'b--',day,varmeans0.mld(ntimes0)-varstds0.mld(ntimes0),'b--')
plot(day,varmeans0v.mld(ntimes0v)+varstds0v.mld(ntimes0v),'--',day,varmeans0v.mld(ntimes0v)-varstds0v.mld(ntimes0v),'--')
%% plot prod
figure; 
ax1=subplot(2,3,1); contourf(days,z,varmeans0.prodn(:,ntimes0),0:0.01:0.4,'LineStyle','none'); 
hold on; plot(days,varmeans0.mld(:,ntimes0),'k')
 caxis([0 0.4]); cmocean('rain',22)
datetick('x',3); axis tight; ylim([-150 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,3,2); contourf(days,z,varmeans0v.prodn(:,ntimes0v),0:0.01:0.4,'LineStyle','none');
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
caxis([0 0.4]); cmocean('rain',22)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,3,3); contourf(days,z,varmeans0v.prodn(:,ntimes0v)-varmeans0.prodn(:,ntimes0),-0.2:0.002:0.1,'LineStyle','none');
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
caxis([-0.01 0.1]); cmocean('-curl',11,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(2,3,4); contourf(days,z,varmeans1.prodn(:,ntimes1),0:0.002:0.02,'LineStyle','none'); 
hold on; plot(days,varmeans1.mld(:,ntimes1),'k')
caxis([0 0.02]); cmocean('rain',20)
datetick('x',3); axis tight; ylim([-60 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(2,3,5); contourf(days,z,varmeans1v.prodn(:,ntimes1v),0:0.002:0.02,'LineStyle','none'); 
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
caxis([0 0.02]); cmocean('rain',20)
datetick('x',3); axis tight; ylim([-60 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('Prod','MLD')

ax6=subplot(2,3,6); contourf(days,z,varmeans1v.prodn(:,ntimes1v)-varmeans1.prodn(:,ntimes1),-0.02:0.0002:0.02,'LineStyle','none'); 
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
caxis([-0.01 0.001]); cmocean('-curl',23,'pivot',0)
datetick('x',3); axis tight; ylim([-60 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})

%% plot N
figure; 
ax1=subplot(3,3,1); contourf(days,z,varmeans0.n(:,ntimes0),0:0.32:10,'LineStyle','none'); 
%hold on; contour(days,z,n,[0.08 0.08],'r')
hold on; plot(days,varmeans0.mld(:,ntimes0),'k')
 caxis([0 6.4]); cmocean('amp',21)
datetick('x',3); axis tight; ylim([-300 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(3,3,2); contourf(days,z,varmeans0v.n(:,ntimes0v),0:0.32:10,'LineStyle','none');
%hold on; contour(days,z,nv,[0.08 0.08],'r')
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
caxis([0 6.4]); cmocean('amp',21)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(3,3,3); contourf(days,z,varmeans0v.n(:,ntimes0v)-varmeans0.n(:,ntimes0),-3.2:0.04:3.2,'LineStyle','none');
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
caxis([-0.8 0.8]); cmocean('curl',9,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(3,3,4); contourf(days,z,varmeans1.n(:,ntimes1),0:0.08:10,'LineStyle','none'); 
%hold on; contour(days1,z,n1,[0.08 0.08],'r')
hold on; plot(days,varmeans1.mld(:,ntimes1),'k')
caxis([0 6.4]); cmocean('amp',21)
datetick('x',3); axis tight; ylim([-300 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(3,3,5); contourf(days,z,varmeans1v.n(:,ntimes1v),0:0.08:10,'LineStyle','none'); 
%hold on; contour(days1,z,n1v,[0.08 0.08],'r')
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
caxis([0 6.4]); cmocean('amp',21)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('N','N=0.08','MLD')

ax6=subplot(3,3,6); contourf(days,z,varmeans1v.n(:,ntimes1v)-varmeans1.n(:,ntimes1),-3.2:0.02:3.2,'LineStyle','none'); 
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
caxis([-0.5 1.25]); cmocean('curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})

ax7=subplot(3,3,7); contourf(days,z,varmeans1.n(:,ntimes1)-varmeans0.n(:,ntimes0),-6.4:0.02:3.2,'LineStyle','none'); 
%hold on; plot(days,varmeans1.mld(:,ntimes1),'k',days,Mldpop,'k')
caxis([-4 1]); cmocean('curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel({'months','(g)'}); ylabel({'2100-2000','depth, m'})

ax8=subplot(3,3,8); contourf(days,z,varmeans1v.n(:,ntimes1v)-varmeans0v.n(:,ntimes0v),-6.4:0.02:3.2,'LineStyle','none'); 
%hold on; plot(days,Mldpop1v,'k',days,Mldpopv,'k')
caxis([-4 1]); cmocean('curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(h)'); set(gca,'YTickLabel',{})

%% plot P

figure; 
ax1=subplot(2,3,1); contourf(days,z,varmeans0.p(:,ntimes0),0:0.01:0.3,'LineStyle','none'); 
hold on; plot(days,varmeans0.mld(:,ntimes0),'k')
 caxis([0 0.27]); cmocean('-curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,3,2); contourf(days,z,varmeans0v.p(:,ntimes0v),0:0.01:0.3,'LineStyle','none');
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
caxis([0 0.27]); cmocean('-curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,3,3); contourf(days,z,varmeans0v.p(:,ntimes0v)-varmeans0.p(:,ntimes0),-0.02:0.001:0.055,'LineStyle','none');
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
caxis([-0.015 0.05]); cmocean('-curl',26,'pivot',0)
datetick('x',3); axis tight; ylim([-300 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(2,3,4); contourf(days,z,varmeans1.p(:,ntimes1),0:0.001:0.026,'LineStyle','none'); 
hold on; plot(days,varmeans1.mld(:,ntimes1),'k')
caxis([0 0.021]); cmocean('-curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(2,3,5); contourf(days,z,varmeans1v.p(:,ntimes1v),0:0.001:0.026,'LineStyle','none'); 
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
caxis([0 0.021]); cmocean('-curl',15,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('P','MLD')

ax6=subplot(2,3,6); contourf(days,z,varmeans1v.p(:,ntimes1v)-varmeans1.p(:,ntimes1),-0.01:0.0001:0.005,'LineStyle','none'); 
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
caxis([-0.008 0.002]); cmocean('-curl',23,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})
%% load all 3 springs wppp
wppp0=varmeans0.wppp;
wppp1=varmeans1.wppp;
wppp0v=varmeans0v.wppp;
wppp1v=varmeans1v.wppp;
load('spring_10_4km_bipit_del250_e_np.mat')
wppp0=cat(3,wppp0,varmeans.wppp);
load('spring_10_4km_bipit_del250_64visc_e_np.mat')
wppp0v=cat(3,wppp0v,varmeans.wppp);
load('spring_10_4km_bipit_del250_2100_v3_64visc_e_np.mat')
wppp1v=cat(3,wppp1v,varmeans.wppp);
load('spring_10_4km_bipit_del250_2100_v3_e_np.mat')
wppp1=cat(3,wppp1,varmeans.wppp);
load('spring_10_4km_bipit_del250_g_np.mat')
wppp0=cat(3,wppp0,varmeans.wppp);
load('spring_10_4km_bipit_del250_64visc_g_np.mat')
wppp0v=cat(3,wppp0v,varmeans.wppp);
load('spring_10_4km_bipit_del250_2100_v3_64visc_g_np.mat')
wppp1v=cat(3,wppp1v,varmeans.wppp);
load('spring_10_4km_bipit_del250_2100_v3_g_np.mat')
wppp1=cat(3,wppp1,varmeans.wppp);

wppp0=wppp0(:,13:end,:);
wppp0v=wppp0v(:,13:end,:);
wppp1=wppp1(:,16:end,:);
wppp1v=wppp1v(:,13:end,:);
%% plot wp submeso spring means
figure; 
ax1=subplot(2,3,1); pcolor(days,z,mean(wppp0,3)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans0.mld(:,ntimes0),'k')
caxis([-11.5e-7 0.5e-7]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,3,2); pcolor(days,z,mean(wppp0v,3)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
caxis([-11.5e-7 0.5e-7]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,3,3); pcolor(days,z,mean(wppp0v,3)-mean(wppp0,3)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
caxis([-1.5e-7 5.5e-7]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(2,3,4); pcolor(days,z,mean(wppp1,3)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans1.mld(:,ntimes1),'k')
caxis([-2.5e-8 0.5e-8]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(2,3,5); pcolor(days,z,mean(wppp1v,3)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
caxis([-2.5e-8 0.5e-8]); cmocean('balance','pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('WP','MLD')

ax6=subplot(2,3,6); pcolor(days,z,mean(wppp1v,3)-mean(wppp1,3)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
caxis([-0.5e-8 2e-8]); cmocean('balance','pivot',0)  
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})
%% plot wp submeso just c
figure; 
ax1=subplot(2,3,1); pcolor(days,z,varmeans0.wppp(:,ntimes0)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans0.mld(:,ntimes0),'k')
% caxis([0 0.4]); cmocean('algae',22)
datetick('x',3); axis tight; ylim([-350 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,3,2); pcolor(days,z,varmeans0v.wppp(:,ntimes0v)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
%caxis([0 0.4]); cmocean('rain',22)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,3,3); pcolor(days,z,varmeans0v.wppp(:,ntimes0v)-varmeans0.wppp(:,ntimes0)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
%caxis([-0.01 0.1]); cmocean('curl',11,'pivot',0)
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(c)');title('Difference'); set(gca,'YTickLabel',{})

ax4=subplot(2,3,4); pcolor(days,z,varmeans1.wppp(:,ntimes1)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans1.mld(:,ntimes1),'k')
%caxis([0 0.02]); cmocean('rain',20)
datetick('x',3); axis tight; ylim([-150 -5]); %colorbar
set(gca,'fontsize',12);xlabel({'months','(d)'});ylabel({'2100','depth, m'});

ax5=subplot(2,3,5); pcolor(days,z,varmeans1v.wppp(:,ntimes1v)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
%caxis([0 0.02]); cmocean('rain',20)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(e)'); set(gca,'YTickLabel',{})
legend('WP','MLD')

ax6=subplot(2,3,6); pcolor(days,z,varmeans1v.wppp(:,ntimes1v)-varmeans1.wppp(:,ntimes1)); shading 'flat'; cmocean('balance','pivot',0)
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
%caxis([-0.01 0.001]); cmocean('curl',23,'pivot',0)
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(f)'); set(gca,'YTickLabel',{})

%% plot w2
figure; 
ax1=subplot(2,2,1); pcolor(days,z,varmeans0.w2(:,ntimes0)); shading 'flat'; cmocean('speed')
hold on; plot(days,varmeans0.mld(:,ntimes0),'k')
 caxis([0 1e-7]); 
datetick('x',3); axis tight; ylim([-350 -5]); %colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,2,2); pcolor(days,z,varmeans0v.w2(:,ntimes0v)); shading 'flat'; cmocean('speed')
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
caxis([0 1e-7]); 
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,2,3); pcolor(days,z,varmeans1.w2(:,ntimes1)); shading 'flat'; cmocean('speed')
hold on; plot(days,varmeans1.mld(:,ntimes1),'k')
caxis([0 5e-9]); 
datetick('x',3); axis tight; ylim([-150 -5]); 
set(gca,'fontsize',12);xlabel({'months','(c)'}); ylabel({'2100','depth, m'});

ax4=subplot(2,2,4); pcolor(days,z,varmeans1v.w2(:,ntimes1v)); shading 'flat'; cmocean('speed')
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
caxis([0 5e-9]); 
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(d)'); set(gca,'YTickLabel',{})
legend('rms w')

%% plot rms w, m/day
figure; 
ax1=subplot(2,2,1); pcolor(days,z,86400*sqrt(varmeans0.w2(:,ntimes0))); shading 'flat'; cmocean('speed')
hold on; plot(days,varmeans0.mld(:,ntimes0),'k')
% caxis([0 1e-7]); 
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(a)');title('Standard'); ylabel('2000')

ax2=subplot(2,2,2); pcolor(days,z,86400*sqrt(varmeans0v.w2(:,ntimes0v))); shading 'flat'; cmocean('speed')
hold on; plot(days,varmeans0v.mld(:,ntimes0v),'k')
% caxis([0 1e-7]); 
datetick('x',3); axis tight; ylim([-350 -5]); colorbar
set(gca,'fontsize',12);xlabel('(b)');title('Viscous'); set(gca,'YTickLabel',{})

ax3=subplot(2,2,3); pcolor(days,z,86400*sqrt(varmeans1.w2(:,ntimes1))); shading 'flat'; cmocean('speed')
hold on; plot(days,varmeans1.mld(:,ntimes1),'k')
% caxis([0 5e-9]); 
datetick('x',3); axis tight; ylim([-150 -5]); 
set(gca,'fontsize',12);xlabel({'months','(c)'}); ylabel({'2100','depth, m'});

ax4=subplot(2,2,4); pcolor(days,z,86400*sqrt(varmeans1v.w2(:,ntimes1v))); shading 'flat'; cmocean('speed')
hold on; plot(days,varmeans1v.mld(:,ntimes1v),'k')
% caxis([0 5e-9]); 
datetick('x',3); axis tight; ylim([-150 -5]); colorbar
set(gca,'fontsize',12);xlabel('(d)'); set(gca,'YTickLabel',{})
legend('rms w')
