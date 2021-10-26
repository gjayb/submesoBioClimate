% clear all
% res='05_1.25km';
%res='05_1.25km_2100';

%load(strcat('spectra_',res,'_all.mat'),'spectra');

%ods=spectra.ocean_time(1);

% load(strcat('spectra_36hr_',res,'_all.mat'),'spectra');
% ocean_day=(spectra.ocean_time)/(24*3600)+5; % plus 5 to correct datevec
logrb=log10(spectra.radialbands);
% 
% z=spectra.z;

if length(res)==14
z1=6;
else
z1=11;
end

keh=0.5*(spectra.uuspec+spectra.vvspec)*spectra.radialbands(1);
%%
kehm=nanmean(nanmean(keh(:,:,:),3),2);
kehp=squeeze(keh(:,z1,:));
[na nb]=size(kehp);
hw=6;
nf=2;
for j=1:na
    kehpf(j,:)=filter_data(kehp(j,:),hw,nf);
end

figure
logkehp=log10(kehpf);
%logkehp=log10(kehp);
ci=[-0.5:0.1:3.5];
cc=[-0.5 3.5];
logkehp(logkehp<min(ci))=min(ci);
contourf(ocean_day,logrb,logkehp,ci)
hold on
contour(ocean_day,logrb,logkehp,ci)
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
set(gca,'YDir','reverse','FontSize',18)
%axis([ocean_day(end)-600 ocean_day(end) logrb(2) logrb(end)])
%gregaxm_noyear(ocean_day,1)
%xlabel('Day','FontSize',18)
ylabel('cyc/m','FontSize',18)
%title(['log_{10}(Horz. KE (m^2s^{-2}(cyc/m)^{-1}): z=',num2str(z(z1)),'m'],'FontSize',18)
orient('LandScape')

figure

%logkezp=log10(squeeze(spectra.wwspec(:,z1,:))*spectra.radialbands(1));
%kev=spectra.wwspec*spectra.radialbands(1);
kevp=squeeze(kev(:,z1,:));
[na nb]=size(kevp);
hw=3;
nf=2;
for j=1:na
    kevpf(j,:)=filter_data(kevp(j,:),hw,nf);
end

%wbp=squeeze(real(spectra.wbspec(:,z1,:)))*spectra.radialbands(1);
%wbp(wbp<=0)=1e-10;
%logkezp=log10(kevpf);
logkezp=log10(kevp);
ci=[-8:0.2:-3];
cc=[-8 -3];
logkezp(logkezp<min(ci))=min(ci);
figure; contourf(ocean_day,logrb,logkezp,ci)
hold on
contour(ocean_day,logrb,logkezp,ci)
caxis(cc)
colormap(jet(length(ci)-1));
colorbar
set(gca,'YDir','reverse','FontSize',18)
%axis([ocean_day(end)-600 ocean_day(end) logrb(2) logrb(end)])
ylim([logrb(2) logrb(end)])
%gregaxm_noyear(ocean_day,1)
%xlabel('Day','FontSize',18)
ylabel('cyc/m','FontSize',18)
%title(['log_{10}(Vert. KE (m^2s^{-2}(cyc/m)^{-1}): z=',num2str(z(z1)),'m'],'FontSize',18)
orient('LandScape')

% wbspec=real(spectra.wbspec)*spectra.radialbands(1);
% wbp=squeeze(wbspec(:,z1,:));
% [na nb]=size(wbp);
% hw=3;
% nf=2;
% for j=1:na
%     wbpf(j,:)=filter_data(wbp(j,:),hw,nf);
% end


%% N

%wnspec=real(spectra.wnspec)*spectra.radialbands(1);
wnp=real(squeeze(wnspec(:,z1,:)));
[na nb]=size(wnp);
hw=6;
nf=2;
for j=1:na
    wnpf(j,:)=filter_data(wnp(j,:),hw,nf);
end
signwnp=sign(wnpf);
logwnp=log10(abs(wnpf));
logwnp(logwnp>0)=0; %max was -1.8 in section A 2100; max -0.05 for 2000 @100m
logwnpfs=-signwnp.*logwnp;%since logwnp<0
figure;
pcolor(ocean_day,logrb,logwnpfs); shading 'flat'
colorbar
set(gca,'YDir','reverse','FontSize',18)
ylim([logrb(2) logrb(end)])

ci=-6:0.5:-1.5;
cc=[-6 6];
cm1=cmocean('balance',24,'pivot',0);
cm4(1:9,:)=cm1(12:-1:4,:);
cm4(16:24,:)=cm1(21:-1:13,:);
cm4(10:15,:)=0;

cm3(1:11,:)=cm1(12:-1:2,:);
cm3(14:24,:)=cm1(23:-1:13,:);
cm3(12:13,:)=0;
caxis(cc)
colormap(cm4)
title('WN, sign and magnitude'); ylabel('cyc/m','FontSize',18)

ci2=-6:0.25:0;

figure;
logwnpplot=logwnp; logwnpplot(logwnpplot<ci2(1))=ci2(1);
contourf(ocean_day,logrb,logwnpplot,ci2,'LineStyle','none'); 
colorbar
caxis([-6 -1.5])
set(gca,'YDir','reverse','FontSize',18)
ylim([logrb(2) logrb(end)])
colormap(jet(18))
%datetick('x',4)
ylabel('cyc/m','FontSize',18)

%
nnp=real(squeeze(nnspec(:,z1,:)));
[na nb]=size(nnp);
hw=6;
nf=2;
for j=1:na
    nnpf(j,:)=filter_data(nnp(j,:),hw,nf);
end
signnnp=sign(nnpf);
lognnp=log10(abs(nnpf));
ci=-1:0.25:6;%-2:0.25:4;%

figure;
lognnpplot=lognnp; lognnpplot(lognnpplot<ci(1))=ci(1);
contourf(ocean_day,logrb,lognnpplot,ci,'LineStyle','none'); 
%pcolor(ocean_day,logrb,lognnpplot); shading 'flat'
colorbar
%caxis([-6 -1.5])
set(gca,'YDir','reverse','FontSize',18)
ylim([logrb(2) logrb(end)]); ylabel('cyc/m','FontSize',18)
colormap(jet(18))
%datetick('x',4)
%% P

%wpspec=real(spectra.wpspec)*spectra.radialbands(1);
wpp=squeeze(real(wpspec(:,z1,:)));
[na nb]=size(wpp);
hw=6;
nf=2;
for j=1:na
    wppf(j,:)=filter_data(wpp(j,:),hw,nf);
end
signwpp=sign(wppf);
logwpp=log10(abs(wppf));
logwpp(logwpp>0)=0; %max was -2.8 in section A, -1.4 for 2000 visc @100m
logwppfs=-signwpp.*logwpp;%since logwnp<0


figure;
pcolor(ocean_day,logrb,logwppfs); shading 'flat'
colorbar
set(gca,'YDir','reverse','FontSize',18)
ylim([logrb(2) logrb(end)])

ci=-8:0.25:-2;%-8:0.5:-2.5;
cc=[-8 8];
cm1=cmocean('balance',32,'pivot',0);
cm2(1:11,:)=cm1(16:-1:6,:);
cm2(22:32,:)=cm1(27:-1:17,:);
cm2(12:21,:)=0;
cm2=cm2(1:32,:);
caxis(cc)
colormap(cm2)
title('WP, sign and magnitude')

figure;
logwppplot=logwpp; logwppplot(logwppplot<ci(1))=ci(1);
contourf(ocean_day,logrb,logwppplot,ci,'LineStyle','none'); 
colorbar
caxis([-8 -2.5])
set(gca,'YDir','reverse','FontSize',18)
ylim([logrb(2) logrb(end)])
colormap(jet(18))
title('WP')

%
ppp=real(squeeze(ppspec(:,z1,:)));
[na nb]=size(ppp);
hw=6;
nf=2;
for j=1:na
    pppf(j,:)=filter_data(ppp(j,:),hw,nf);
end
signppp=sign(pppf);
logppp=log10(abs(pppf));
ci=-6:0.5:1.5;

figure;
lognppplot=logppp; lognppplot(lognppplot<ci(1))=ci(1);
contourf(ocean_day,logrb,lognppplot,ci,'LineStyle','none'); 
%pcolor(ocean_day,logrb,lognppplot); shading 'flat'
colorbar
caxis([-6 1.5])
set(gca,'YDir','reverse','FontSize',18)
ylim([logrb(2) logrb(end)])
colormap(jet(15))
title('P')
%datetick('x',4)

