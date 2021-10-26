 function out=save_nprod_core_np(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs)
global z
display('start nprod core')
fn=strcat(filestart,filemid{fct},fileend)
ocean_time=ncread(strcat(path,fn),'ocean_time');
display('making NaN arrays')
varmeans.n=nan(length(z_edge),length(ocean_time));
varmeans.nr=nan(length(z_edge),length(ocean_time));
varmeans.I=nan(length(z_edge),length(ocean_time));
varmeans.Q=nan(length(z_edge),length(ocean_time));
varmeans.Qr=nan(length(z_edge),length(ocean_time));
varmeans.L=nan(length(z_edge),length(ocean_time));
varmeans.swrad=nan(1,length(ocean_time));
varmeans.prodn=nan(length(z_edge),length(ocean_time));
varmeans.prodr=nan(length(z_edge),length(ocean_time));
varmeans.wn=nan(length(z_edge),length(ocean_time));
varmeans.wnr=nan(length(z_edge),length(ocean_time));
varmeans.wmnm=nan(length(z_edge),length(ocean_time));
varmeans.wmnrm=nan(length(z_edge),length(ocean_time));
varmeans.wpn=nan(length(z_edge),length(ocean_time));
varmeans.wpnr=nan(length(z_edge),length(ocean_time));
varmeans.wpnp=nan(length(z_edge),length(ocean_time));
varmeans.wpnrp=nan(length(z_edge),length(ocean_time));
varmeans.w2=nan(length(z_edge),length(ocean_time));
varmeans.w=nan(length(z_edge),length(ocean_time));

varstds.n=nan(length(z_edge),length(ocean_time));
varstds.nr=nan(length(z_edge),length(ocean_time));
varstds.I=nan(length(z_edge),length(ocean_time));
varstds.Q=nan(length(z_edge),length(ocean_time));
varstds.Qr=nan(length(z_edge),length(ocean_time));
varstds.L=nan(length(z_edge),length(ocean_time));
varstds.swrad=nan(1,length(ocean_time));
varstds.prodn=nan(length(z_edge),length(ocean_time));
varstds.prodr=nan(length(z_edge),length(ocean_time));
varstds.wn=nan(length(z_edge),length(ocean_time));
varstds.wnr=nan(length(z_edge),length(ocean_time));
varstds.wmnm=nan(length(z_edge),length(ocean_time));
varstds.wmnrm=nan(length(z_edge),length(ocean_time));
varstds.wpn=nan(length(z_edge),length(ocean_time));
varstds.wpnr=nan(length(z_edge),length(ocean_time));
varstds.wpnp=nan(length(z_edge),length(ocean_time));
varstds.wpnrp=nan(length(z_edge),length(ocean_time));
varstds.w=nan(length(z_edge),length(ocean_time));
varstds.w2=nan(length(z_edge),length(ocean_time));

display('making grid')
sigma_w=ncread(strcat(path,fn),'s_w');
sigma_w=reshape(sigma_w,[length(sigma_w) 1]);
hc=ncread(strcat(path,fn),'hc');
h=ncread(strcat(path,fn),'h');
thetab=ncread(strcat(path,fn),'theta_b');
thetas=ncread(strcat(path,fn),'theta_s');
pm=ncread(strcat(path,fn),'pm');
pn=ncread(strcat(path,fn),'pn');
dxrho=1./pm(2:end-1,2:end-1);
dyrho=1./pn(2:end-1,2:end-1);
xg=cumsum(dxrho,1)-dxrho./2;
yg=cumsum(dyrho,2)-dyrho./2;
dx= nanmean(dxrho(:));
xmax=min(min(xg(end,:)),min(yg(:,end)));
width=1.5e5;
xs=width:dx:xmax-width;
ys=width:dx:xmax-width;
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
sizeswrad=size(swrad)
swrad=swrad(2:end-1,2:end-1,:);
sizeswrad=size(swrad)

no3r=ncread(strcat(path,fn),'regNO3'); 
no3=ncread(strcat(path,fn),'NO3'); 
z_rho=repmat(z,[1 1 1 size(no3,4)]);

no3r=no3r(2:end-1,2:end-1,stzidx:end,:);
no3=no3(2:end-1,2:end-1,stzidx:end,:);
z_rho=z_rho(2:end-1,2:end-1,stzidx:end,:);


% u=ncread(strcat(path,fn),'u');
% u=0.5.*u(1:end-1,2:end-1,stzidx:end,:)+0.5.*u(2:end,2:end-1,stzidx:end,:);
% v=ncread(strcat(path,fn),'v');
% v=0.5.*v(2:end-1,1:end-1,stzidx:end,:)+0.5.*v(2:end-1,2:end,stzidx:end,:);
w=ncread(strcat(path,fn),'w');
w=0.5.*w(2:end-1,2:end-1,1:end-1,:)+0.5.*w(2:end-1,2:end-1,2:end,:);
w=w(:,:,stzidx:end,:);
dsigma=diff(sigma_w,1,1);
dsigma=dsigma(stzidx:end);

display('interp no3r')
no3r_z=var_to_zi(no3r,-z_rho,z_edge);

display('interp no3')
no3_z=var_to_zi(no3,-z_rho,z_edge);

display('interp w')
w_z=var_to_zi(w,-z_rho,z_edge);
z_mid = z_edge+0.5.*abs(z_edge(2)-z_edge(1));
%clear u v w pden z_rho 
%% stats
nfilters=8; hf=fspecial('average',[5 5]);
for nt=1:length(ocean_time)
    nt
    sizexg=size(xg)
    sizeyg=size(yg)
       hnow=griddata(xg',yg',squeeze(swrad(:,:,nt))',xgs,ygs);
     sizehnow=size(hnow)
     varmeans.swrad(nt)=nanmean(hnow(:));
     varstds.swrad(nt)=nanstd(hnow(:));
   display('entering zloop')
   for zlev=zlevs 
       Inow=0.4.*hnow.*exp(-0.1*z_edge(zlev));
       varmeans.I(zlev,nt)=nanmean(Inow(:));
       varstds.I(zlev,nt)=nanstd(Inow(:));
       Lnow=1-exp(-0.035.*Inow); clear Inow
       varmeans.L(zlev,nt)=nanmean(Lnow(:));
       varstds.L(zlev,nt)=nanstd(Lnow(:));
%      display('ILdone') 
        tnow=griddata(xg',yg',squeeze(no3_z(:,:,zlev,nt))',xgs,ygs);
         varmeans.n(zlev,nt)=nanmean(tnow(:));
         varstds.n(zlev,nt)=nanstd(tnow(:));
         Qnow=tnow./(tnow+3.2);
         varmeans.Q(zlev,nt)=nanmean(Qnow(:));
         varstds.Q(zlev,nt)=nanstd(Qnow(:));
         Pc=Qnow.*Lnow;
         varmeans.prodn(zlev,nt)=nanmean(Pc(:));
         varstds.prodn(zlev,nt)=nanstd(Pc(:));
%	display('Nprodn done')
         trnow=griddata(xg',yg',squeeze(no3r_z(:,:,zlev,nt))',xgs,ygs);
         varmeans.nr(zlev,nt)=nanmean(trnow(:));
         varstds.nr(zlev,nt)=nanstd(trnow(:));
         Qrnow=trnow./(tnow+trnow+3.2);
         varmeans.Qr(zlev,nt)=nanmean(Qrnow(:));
         varstds.Qr(zlev,nt)=nanstd(Qrnow(:));
         Pcr=(1-Qnow).*Qrnow.*Lnow;
         varmeans.prodr(zlev,nt)=nanmean(Pcr(:));
         varstds.prodr(zlev,nt)=nanstd(Pcr(:));
%	display('Nr prodr done')
         wnow=griddata(xg',yg',squeeze(w_z(:,:,zlev,nt))',xgs,ygs);
         varmeans.w(zlev,nt)=nanmean(wnow(:));
         varstds.w(zlev,nt)=nanstd(wnow(:));
         varmeans.w2(zlev,nt)=nanmean(wnow(:).^2);
         varstds.w2(zlev,nt)=nanstd(wnow(:).^2);
         varmeans.wn(zlev,nt)=nanmean(wnow(:).*tnow(:));
         varstds.wn(zlev,nt)=nanstd(wnow(:).*tnow(:));
         varmeans.wnr(zlev,nt)=nanmean(wnow(:).*trnow(:));
         varstds.wnr(zlev,nt)=nanstd(wnow(:).*trnow(:));

%         display('filtering')
         pmeso=imfilter(tnow,hf,'replicate','same','corr');
         wmeso=imfilter(wnow,hf,'replicate','same','corr');
         prmeso=imfilter(trnow,hf,'replicate','same','corr');
        for i=2:nfilters
            pmeso=imfilter(pmeso,hf,'replicate','same','corr');
            wmeso=imfilter(wmeso,hf,'replicate','same','corr');
            prmeso=imfilter(prmeso,hf,'replicate','same','corr');
        end
        %
        varmeans.wmnm(zlev,nt)=nanmean(wmeso(:).*pmeso(:));
        varmeans.wpnp(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(tnow(:)-pmeso(:)));
        varmeans.wpn(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(tnow(:)-nanmean(tnow(:))));
        varstds.wmnm(zlev,nt)=nanstd(wmeso(:).*pmeso(:));
        varstds.wpnp(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(tnow(:)-pmeso(:)));
        varstds.wpn(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(tnow(:)-nanmean(tnow(:))));
        varmeans.wmnrm(zlev,nt)=nanmean(wmeso(:).*prmeso(:));
        varmeans.wpnrp(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(trnow(:)-prmeso(:)));
        varmeans.wpnr(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(trnow(:)-nanmean(trnow(:))));
        varstds.wmnrm(zlev,nt)=nanstd(wmeso(:).*prmeso(:));
        varstds.wpnrp(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(trnow(:)-prmeso(:)));
        varstds.wpnr(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(trnow(:)-nanmean(trnow(:))));
     
    clear tnow trnow wnow *meso
   end


     

clear hnow
end

whos
clear z h w_z no3_z no3r_z swrad *now Pc* 
%% save
display('save')
%save('nprodbackup.mat','varmeans','varstds')
%varmeans.ocean_time=cat(1,varmeans.ocean_time,ocean_time(1:ntskip:end));
varmeans.z=z_edge(zlevs);
whos

save(strcat('nprod_',res,'_',filemid{fct},'_np.mat'))
%save('nprodbackup.mat','-v7.3')
clear spectra radialbands z_mid zlevs ocean_time
whos

out='flag out'
end
