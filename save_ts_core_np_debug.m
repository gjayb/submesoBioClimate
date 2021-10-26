function out=save_ts_core_np(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs)
global z
fn=strcat(filestart,filemid{fct},fileend)
ocean_time=ncread(strcat(path,fn),'ocean_time');

varmeans.t=nan(length(z_edge),length(ocean_time));
varmeans.s=nan(length(z_edge),length(ocean_time));
varmeans.pden=nan(length(z_edge),length(ocean_time));
varmeans.hsbl=nan(1,length(ocean_time));
varmeans.mldpop=nan(1,length(ocean_time));
varmeans.mld03=nan(1,length(ocean_time));
varmeans.mld005=nan(1,length(ocean_time));

varmins.t=nan(length(z_edge),length(ocean_time));
varmins.s=nan(length(z_edge),length(ocean_time));
varmins.pden=nan(length(z_edge),length(ocean_time));
varmins.hsbl=nan(1,length(ocean_time));
varmins.mldpop=nan(1,length(ocean_time));
varmins.mld03=nan(1,length(ocean_time));
varmins.mld005=nan(1,length(ocean_time));

varmaxs.t=nan(length(z_edge),length(ocean_time));
varmaxs.s=nan(length(z_edge),length(ocean_time));
varmaxs.pden=nan(length(z_edge),length(ocean_time));
varmaxs.hsbl=nan(1,length(ocean_time));
varmaxs.mldpop=nan(1,length(ocean_time));
varmaxs.mld03=nan(1,length(ocean_time));
varmaxs.mld005=nan(1,length(ocean_time));

varstds.t=nan(length(z_edge),length(ocean_time));
varstds.s=nan(length(z_edge),length(ocean_time));
varstds.pden=nan(length(z_edge),length(ocean_time));
varstds.hsbl=nan(1,length(ocean_time));
varstds.mldpop=nan(1,length(ocean_time));
varstds.mld03=nan(1,length(ocean_time));
varstds.mld005=nan(1,length(ocean_time));

sigma_w=ncread(strcat(path,fn),'s_w');
sigma_w=reshape(sigma_w,[length(sigma_w) 1]);
%hc=ncread(strcat(path,fn),'hc');
h=ncread(strcat(path,fn),'h');
%thetab=ncread(strcat(path,fn),'theta_b');
%thetas=ncread(strcat(path,fn),'theta_s');
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

[xgs,ygs]=meshgrid(xs,ys); clear xs ys pm pn

display('read data')
lat_rho=ncread(strcat(path,fn),'lat_rho');
hsbl=ncread(strcat(path,fn),'Hsbl');
size(hsbl)
mld03=ncread(strcat(path,fn),'mldda03');
size(mld03)
mld005=ncread(strcat(path,fn),'mldda005');
size(mld005)
mldpop=ncread(strcat(path,fn),'mldpopmxl');
size(mldpop)
hsbl=hsbl(2:end-1,2:end-1,stzidx:end);
mld03=mld03(2:end-1,2:end-1,stzidx:end);
mld005=mld005(2:end-1,2:end-1,stzidx:end);
mldpop=mldpop(2:end-1,2:end-1,stzidx:end);

display('read bigger data')
salt=ncread(strcat(path,fn),'salt'); 
temp=ncread(strcat(path,fn),'temp'); 
pden=ncread(strcat(path,fn),'pden'); 
z_rho=repmat(z,[1 1 1 size(salt,4)]);

salt=salt(2:end-1,2:end-1,stzidx:end,:);
temp=temp(2:end-1,2:end-1,stzidx:end,:);
pden=pden(2:end-1,2:end-1,stzidx:end,:);
z_rho=z_rho(2:end-1,2:end-1,stzidx:end,:);

%dsigma=diff(sigma_w,1,1);
%dsigma=dsigma(stzidx:end);

display('interp temp')
temp_z=var_to_zi(temp,-z_rho,z_edge);
display('interp salt')
salt_z=var_to_zi(salt,-z_rho,z_edge);

display('interp pden')
pden_z=var_to_zi(pden,-z_rho,z_edge);

clear salt temp pden


%% regrid and stats

for nt=1:length(ocean_time)
    nt
   for zlev=zlevs 
    tnow=griddata(xg',yg',squeeze(temp_z(:,:,zlev,nt))',xgs,ygs);
     varmeans.t(zlev,nt)=nanmean(tnow(:));
     varmins.t(zlev,nt)=nanmin(tnow(:));
     varmaxs.t(zlev,nt)=nanmax(tnow(:));
     varstds.t(zlev,nt)=nanstd(tnow(:));
     
     tnow=griddata(xg',yg',squeeze(salt_z(:,:,zlev,nt))',xgs,ygs);
     varmeans.s(zlev,nt)=nanmean(tnow(:));
     varmins.s(zlev,nt)=nanmin(tnow(:));
     varmaxs.s(zlev,nt)=nanmax(tnow(:));
     varstds.s(zlev,nt)=nanstd(tnow(:));
     
     tnow=griddata(xg',yg',squeeze(pden_z(:,:,zlev,nt))',xgs,ygs);
     varmeans.pden(zlev,nt)=nanmean(tnow(:));
     varmins.pden(zlev,nt)=nanmin(tnow(:));
     varmaxs.pden(zlev,nt)=nanmax(tnow(:));
     varstds.pden(zlev,nt)=nanstd(tnow(:));
    clear tnow 
   end
   hnow=griddata(xg',yg',squeeze(hsbl(:,:,nt))',xgs,ygs);
     varmeans.hsbl(nt)=nanmean(hnow(:));
     varmins.hsbl(nt)=nanmin(hnow(:));
     varmaxs.hsbl(nt)=nanmax(hnow(:));
     varstds.hsbl(nt)=nanstd(hnow(:));
     
        hnow=griddata(xg',yg',squeeze(mld03(:,:,nt))',xgs,ygs);
     varmeans.mld03(nt)=nanmean(hnow(:));
     varmins.mld03(nt)=nanmin(hnow(:));
     varmaxs.mld03(nt)=nanmax(hnow(:));
     varstds.mld03(nt)=nanstd(hnow(:));
     
        hnow=griddata(xg',yg',squeeze(mld005(:,:,nt))',xgs,ygs);
     varmeans.mld005(nt)=nanmean(hnow(:));
     varmins.mld005(nt)=nanmin(hnow(:));
     varmaxs.mld005(nt)=nanmax(hnow(:));
     varstds.mld005(nt)=nanstd(hnow(:));
     
        hnow=griddata(xg',yg',squeeze(mldpop(:,:,nt))',xgs,ygs);
     varmeans.mldpop(nt)=nanmean(hnow(:));
     varmins.mldpop(nt)=nanmin(hnow(:));
     varmaxs.mldpop(nt)=nanmax(hnow(:));
     varstds.mldpop(nt)=nanstd(hnow(:));
clear hnow
end

clear salt_z temp_z pden_z hsbl mld03 mld005 mldpop
%% save
varmeans.ocean_time=ocean_time;
varmeans.z=z_edge(zlevs);
save(strcat('ts_',res,'_',filemid{fct},'_np.mat'))

out='flag out'
end
