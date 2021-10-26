 function out=save_spring_core_np(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs)
global z
display('start nprod core')
fn=strcat(filestart,filemid{fct},fileend)
ocean_time=ncread(strcat(path,fn),'ocean_time');
% display('making NaN arrays')
% varmeans.n=nan(length(z_edge),length(ocean_time));
% varmeans.pden=nan(length(z_edge),length(ocean_time));
% varmeans.mld=nan(1,length(ocean_time));
% varmeans.Q=nan(length(z_edge),length(ocean_time));
% varmeans.hsbl=nan(1,length(ocean_time));
% varmeans.L=nan(length(z_edge),length(ocean_time));
% varmeans.swrad=nan(1,length(ocean_time));
% varmeans.prodn=nan(length(z_edge),length(ocean_time));
% varmeans.wp=nan(length(z_edge),length(ocean_time));
% varmeans.wn=nan(length(z_edge),length(ocean_time));
% varmeans.p=nan(length(z_edge),length(ocean_time));
% varmeans.wpnp=nan(length(z_edge),length(ocean_time));
% varmeans.wppp=nan(length(z_edge),length(ocean_time));
% varmeans.w2=nan(length(z_edge),length(ocean_time));
% varmeans.w=nan(length(z_edge),length(ocean_time));
% 
% varstds.n=nan(length(z_edge),length(ocean_time));
% varstds.pden=nan(length(z_edge),length(ocean_time));
% varstds.mld=nan(1,length(ocean_time));
% varstds.Q=nan(length(z_edge),length(ocean_time));
% varstds.hsbl=nan(1,length(ocean_time));
% varstds.L=nan(length(z_edge),length(ocean_time));
% varstds.swrad=nan(1,length(ocean_time));
% varstds.prodn=nan(length(z_edge),length(ocean_time));
% varstds.wp=nan(length(z_edge),length(ocean_time));
% varstds.wn=nan(length(z_edge),length(ocean_time));
% varstds.p=nan(length(z_edge),length(ocean_time));
% varstds.wpnp=nan(length(z_edge),length(ocean_time));
% varstds.wppp=nan(length(z_edge),length(ocean_time));
% varstds.w=nan(length(z_edge),length(ocean_time));
% varstds.w2=nan(length(z_edge),length(ocean_time));

display('making grid')
sigma_w=ncread(strcat(path,fn),'s_w');
sigma_w=reshape(sigma_w,[length(sigma_w) 1]);
%hc=ncread(strcat(path,fn),'hc');
%h=ncread(strcat(path,fn),'h');
%thetab=ncread(strcat(path,fn),'theta_b');
%thetas=ncread(strcat(path,fn),'theta_s');
pm=ncread(strcat(path,fn),'pm');
pn=ncread(strcat(path,fn),'pn');
dxrho=1./pm(2:end-1,2:end-1);
dyrho=1./pn(2:end-1,2:end-1);
xg=cumsum(dxrho,1)-dxrho./2;
yg=cumsum(dyrho,2)-dyrho./2;
xg=xg(2:150,198:298);% GRABBING NE CORNER
yg=yg(2:150,198:298);
dx= nanmean(dxrho(:));
xmin=min(xg(:));
xmax=max(xg(:));
ymax=max(yg(:));
ymin=min(yg(:));
xs=xmin:dx:xmax;
ys=ymin:dx:ymax;
% xmax=min(min(xg(end,:)),min(yg(:,end)));
% width=1.5e5;
% xs=width:dx:xmax-width;
% ys=width:dx:xmax-width;
%display('xs:')
%xs(1)
%xs(end)

if mod(length(xs),2)~=0
    xs=xs(2:end);
    ys=ys(2:end);
end

[xgs,ygs]=meshgrid(xs,ys);

display('read data')
lat_rho=ncread(strcat(path,fn),'lat_rho');
lon_rho=ncread(strcat(path,fn),'lon_rho');
swrad=ncread(strcat(path,fn),'swrad');
swrad=swrad(2:150,198:298,:);
hsbl=ncread(strcat(path,fn),'Hsbl');
mldpop=ncread(strcat(path,fn),'mldpopmxl');
hsbl=hsbl(2:150,198:298,stzidx:end,:);
mldpop=mldpop(2:150,198:298,stzidx:end,:);

no3=ncread(strcat(path,fn),'NO3'); 
z_rho=repmat(z,[1 1 1 size(no3,4)]);

phyt=ncread(strcat(path,fn),'phytoplankton'); 
phyt=phyt(2:150,198:298,stzidx:end,:);
no3=no3(2:150,198:298,stzidx:end,:);
z_rho=z_rho(2:150,198:298,stzidx:end,:);    

pden=ncread(strcat(path,fn),'pden'); 
pden=pden(2:150,198:298,stzidx:end,:);

% u=ncread(strcat(path,fn),'u');
% u=0.5.*u(1:end-1,2:end-1,stzidx:end,:)+0.5.*u(2:end,2:end-1,stzidx:end,:);
% v=ncread(strcat(path,fn),'v');
% v=0.5.*v(2:end-1,1:end-1,stzidx:end,:)+0.5.*v(2:end-1,2:end,stzidx:end,:);
w=ncread(strcat(path,fn),'w');
w=0.5.*w(2:150,198:298,1:end-1,:)+0.5.*w(2:150,198:298,2:end,:);
w=w(:,:,stzidx:end,:);
dsigma=diff(sigma_w,1,1);
dsigma=dsigma(stzidx:end);

display('interp no3')
no3_z=var_to_zi(no3,-z_rho,z_edge);

display('interp phyt')
phyt_z=var_to_zi(phyt,-z_rho,z_edge);

display('interp w')
w_z=var_to_zi(w,-z_rho,z_edge);
z_mid = z_edge+0.5.*abs(z_edge(2)-z_edge(1));

display('interp pden')
pden_z=var_to_zi(pden,-z_rho,z_edge);
clear pden

clear u v w pden z_rho no3 phyt
%% stats
nfilters=8; hf=fspecial('average',[5 5]);
switch filemid{1}
    case 'c'
        ntimes=13:73;
    case 'e'
        ntimes=16:76;
    case 'g'
        ntimes=19:79;
end
day=ocean_time(ntimes)./86400+5;
for nt=ntimes
    nt
     hnow=griddata(xg',yg',squeeze(hsbl(:,:,nt))',xgs,ygs);
     varmeans.hsbl(nt)=nanmean(hnow(:));
     varstds.hsbl(nt)=nanstd(hnow(:));
     hnow=griddata(xg',yg',squeeze(mldpop(:,:,nt))',xgs,ygs);
     varmeans.mld(nt)=nanmean(hnow(:));
     varstds.mld(nt)=nanstd(hnow(:));
     hnow=griddata(xg',yg',squeeze(swrad(:,:,nt))',xgs,ygs);
     varmeans.swrad(nt)=nanmean(hnow(:));
     varstds.swrad(nt)=nanstd(hnow(:));
   display('entering zloop')
   for zlev=zlevs 
       Inow=0.4.*hnow.*exp(-0.1*z_edge(zlev));
       Lnow=1-exp(-0.035.*Inow); clear Inow
       varmeans.L(zlev,nt)=nanmean(Lnow(:));
       varstds.L(zlev,nt)=nanstd(Lnow(:));
%      display('ILdone') 
        tnow=griddata(xg',yg',squeeze(no3_z(:,:,zlev,nt))',xgs,ygs);
         varmeans.n(zlev,nt)=nanmean(tnow(:));
         varstds.n(zlev,nt)=nanstd(tnow(:));
         trnow=griddata(xg',yg',squeeze(pden_z(:,:,zlev,nt))',xgs,ygs);
         varmeans.pden(zlev,nt)=nanmean(trnow(:));
         varstds.pden(zlev,nt)=nanstd(trnow(:)); clear trnow
         Qnow=tnow./(tnow+3.2);
         varmeans.Q(zlev,nt)=nanmean(Qnow(:));
         varstds.Q(zlev,nt)=nanstd(Qnow(:));
         Pc=Qnow.*Lnow;
         varmeans.prodn(zlev,nt)=nanmean(Pc(:));
         varstds.prodn(zlev,nt)=nanstd(Pc(:)); clear Qnow Lnow Pc
%	display('Nprodn done')
          pnow=griddata(xg',yg',squeeze(phyt_z(:,:,zlev,nt))',xgs,ygs);
          varmeans.p(zlev,nt)=nanmean(pnow(:));
          varstds.p(zlev,nt)=nanstd(pnow(:));
%          Qrnow=trnow./(tnow+trnow+3.2);
%          varmeans.Qr(zlev,nt)=nanmean(Qrnow(:));
%          varstds.Qr(zlev,nt)=nanstd(Qrnow(:));
%          Pcr=(1-Qnow).*Qrnow.*Lnow;
%          varmeans.prodr(zlev,nt)=nanmean(Pcr(:));
%          varstds.prodr(zlev,nt)=nanstd(Pcr(:));
%	display('Nr prodr done')
         wnow=griddata(xg',yg',squeeze(w_z(:,:,zlev,nt))',xgs,ygs);
         varmeans.w(zlev,nt)=nanmean(wnow(:));
         varstds.w(zlev,nt)=nanstd(wnow(:));
         varmeans.w2(zlev,nt)=nanmean(wnow(:).^2);
         varstds.w2(zlev,nt)=nanstd(wnow(:).^2);
         varmeans.wn(zlev,nt)=nanmean(wnow(:).*tnow(:));
         varstds.wn(zlev,nt)=nanstd(wnow(:).*tnow(:));
         varmeans.wp(zlev,nt)=nanmean(wnow(:).*pnow(:));
         varstds.wp(zlev,nt)=nanstd(wnow(:).*pnow(:));

%         display('filtering')
         pmeso=imfilter(pnow,hf,'replicate','same','corr');
         wmeso=imfilter(wnow,hf,'replicate','same','corr');
         nmeso=imfilter(tnow,hf,'replicate','same','corr');
        for i=2:nfilters
            pmeso=imfilter(pmeso,hf,'replicate','same','corr');
            wmeso=imfilter(wmeso,hf,'replicate','same','corr');
            nmeso=imfilter(nmeso,hf,'replicate','same','corr');
        end
        %
        varmeans.wmnm(zlev,nt)=nanmean(wmeso(:).*nmeso(:));
        varmeans.wpnp(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(tnow(:)-nmeso(:)));
        varmeans.wpn(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(tnow(:)-nanmean(tnow(:))));
        varstds.wmnm(zlev,nt)=nanstd(wmeso(:).*nmeso(:));
        varstds.wpnp(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(tnow(:)-nmeso(:)));
        varstds.wpn(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(tnow(:)-nanmean(tnow(:))));
        
        varmeans.wmpm(zlev,nt)=nanmean(wmeso(:).*pmeso(:));
        varmeans.wppp(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(tnow(:)-pmeso(:)));%WRONG!! FIX!!
        varmeans.wpp(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(pnow(:)-nanmean(pnow(:))));
        varstds.wmpm(zlev,nt)=nanstd(wmeso(:).*pmeso(:));
        varstds.wppp(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(pnow(:)-pmeso(:)));
        varstds.wpp(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(pnow(:)-nanmean(pnow(:))));
     
    clear tnow pnow wnow *meso
   end


     

clear *now 
end

whos
clear z h w_z no3_z phyt_z swrad *now Pc* hsbl mldpop pden_z
%% save
whos
display('save')
%save('nprodbackup.mat','varmeans','varstds')
%varmeans.ocean_time=cat(1,varmeans.ocean_time,ocean_time(1:ntskip:end));
varmeans.z=z_edge(zlevs);
whos

save(strcat('spring_',res,'_',filemid{fct},'_np.mat'))
%save('nprodbackup.mat','-v7.3')
clear spectra radialbands z_mid zlevs ocean_time
whos

out='flag out'
end
