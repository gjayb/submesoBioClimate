function out=save_pset_core_np(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs)
global z
display('start pset core')
fn=strcat(filestart,filemid{fct},fileend)
ocean_time=ncread(strcat(path,fn),'ocean_time');
display('making NaN arrays')
varmeans.p=nan(length(z_edge),length(ocean_time));
varmeans.pr=nan(length(z_edge),length(ocean_time));
varmeans.wp=nan(length(z_edge),length(ocean_time));
varmeans.wpr=nan(length(z_edge),length(ocean_time));
varmeans.wmpm=nan(length(z_edge),length(ocean_time));
varmeans.wmprm=nan(length(z_edge),length(ocean_time));
varmeans.wpp=nan(length(z_edge),length(ocean_time));
varmeans.wppr=nan(length(z_edge),length(ocean_time));
varmeans.wppp=nan(length(z_edge),length(ocean_time));
varmeans.wpprp=nan(length(z_edge),length(ocean_time));
varmeans.wp=nan(length(z_edge),length(ocean_time));
varmeans.wm=nan(length(z_edge),length(ocean_time));
varmeans.w=nan(length(z_edge),length(ocean_time));

varstds.p=nan(length(z_edge),length(ocean_time));
varstds.pr=nan(length(z_edge),length(ocean_time));
varstds.wp=nan(length(z_edge),length(ocean_time));
varstds.wpr=nan(length(z_edge),length(ocean_time));
varstds.wmpm=nan(length(z_edge),length(ocean_time));
varstds.wmprm=nan(length(z_edge),length(ocean_time));
varstds.wpp=nan(length(z_edge),length(ocean_time));
varstds.wppr=nan(length(z_edge),length(ocean_time));
varstds.wppp=nan(length(z_edge),length(ocean_time));
varstds.wpprp=nan(length(z_edge),length(ocean_time));
varstds.wp=nan(length(z_edge),length(ocean_time));
varstds.wm=nan(length(z_edge),length(ocean_time));
varstds.w=nan(length(z_edge),length(ocean_time));

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
phyt=ncread(strcat(path,fn),'phytoplankton'); 
phytr=ncread(strcat(path,fn),'regphyt'); 
z_rho=repmat(z,[1 1 1 size(phyt,4)]);


w=ncread(strcat(path,fn),'w');
w=0.5.*w(2:end-1,2:end-1,1:end-1,:)+0.5.*w(2:end-1,2:end-1,2:end,:);
w=w(:,:,stzidx:end,:);
dsigma=diff(sigma_w,1,1);
dsigma=dsigma(stzidx:end);

display('interp phyt')
phyt_z=var_to_zi(phyt,-z_rho,z_edge);

display('interp phytr')
phytr_z=var_to_zi(phytr,-z_rho,z_edge);

display('interp w')
w_z=var_to_zi(w,-z_rho,z_edge);
z_mid = z_edge+0.5.*abs(z_edge(2)-z_edge(1));
clear w phyt phytr


%% stats
nfilters=8; hf=fspecial('average',[5 5]);
for nt=1:length(ocean_time)
    nt
   for zlev=zlevs 
    pnow=griddata(xg',yg',squeeze(phyt_z(2:end-1,2:end-1,zlev,nt))',xgs,ygs);
     varmeans.p(zlev,nt)=nanmean(pnow(:));
     varstds.p(zlev,nt)=nanstd(pnow(:));
     
     prnow=griddata(xg',yg',squeeze(phytr_z(2:end-1,2:end-1,zlev,nt))',xgs,ygs);
     varmeans.pr(zlev,nt)=nanmean(prnow(:));
     varstds.pr(zlev,nt)=nanstd(prnow(:));
     
     wnow=griddata(xg',yg',squeeze(w_z(2:end-1,2:end-1,zlev,nt))',xgs,ygs);
     varmeans.w(zlev,nt)=nanmean(wnow(:));
     varstds.w(zlev,nt)=nanstd(wnow(:));
     
     varmeans.wp(zlev,nt)=nanmean(wnow(:).*pnow(:));
     varstds.wp(zlev,nt)=nanstd(wnow(:).*pnow(:));
    varmeans.wpr(zlev,nt)=nanmean(wnow(:).*prnow(:));
     varstds.wpr(zlev,nt)=nanstd(wnow(:).*prnow(:));
     
     
      display('filtering')
         pmeso=imfilter(pnow,hf,'replicate','same','corr');
         wmeso=imfilter(wnow,hf,'replicate','same','corr');
         prmeso=imfilter(prnow,hf,'replicate','same','corr');
        for i=2:nfilters
            pmeso=imfilter(pmeso,hf,'replicate','same','corr');
            wmeso=imfilter(wmeso,hf,'replicate','same','corr');
            prmeso=imfilter(prmeso,hf,'replicate','same','corr');
        end

        varmeans.wp=nanmean(wnow(:)-wmeso(:));
        varmeans.wm=nanmean(wmeso(:));
        varstds.wp(zlev,nt)=nanstd(wnow(:)-wmeso(:));
        varstds.wm(zlev,nt)=nanstd(wmeso(:));
        %
        varmeans.wmpm(zlev,nt)=nanmean(wmeso(:).*pmeso(:));
        varmeans.wppp(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(tnow(:)-pmeso(:)));
        varmeans.wpp(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(tnow(:)-nanmean(tnow(:))));
        varstds.wmpm(zlev,nt)=nanstd(wmeso(:).*pmeso(:));
        varstds.wppp(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(tnow(:)-pmeso(:)));
        varstds.wpp(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(tnow(:)-nanmean(tnow(:))));
        
        varmeans.wmprm(zlev,nt)=nanmean(wmeso(:).*prmeso(:));
        varmeans.wpprp(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(trnow(:)-prmeso(:)));
        varmeans.wppr(zlev,nt)=nanmean((wnow(:)-wmeso(:)).*(trnow(:)-nanmean(trnow(:))));
        varstds.wmprm(zlev,nt)=nanstd(wmeso(:).*prmeso(:));
        varstds.wpprp(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(trnow(:)-prmeso(:)));
        varstds.wppr(zlev,nt)=nanstd((wnow(:)-wmeso(:)).*(trnow(:)-nanmean(trnow(:))));
     
    clear pnow prnow wnow *meso
        
   end

end

clear w_z phyt_z phytr_z
%% save
  varmeans.z=z_edge(zlevs);
save(strcat('pset_',res,'_',filemid{fct},'_np.mat'))

out='flag out'
end
