 function out=save_vs_core_np(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs)
global z
display('start vs core')
fn=strcat(filestart,filemid{fct},fileend)
fn2=strcat(filestart,filemid{fct});
ocean_time=ncread(strcat(path,fn),'ocean_time');

display('making grid')
sigma_w=ncread(strcat(path,fn),'s_w');
sigma_w=reshape(sigma_w,[length(sigma_w) 1]);

pm=ncread(strcat(path,fn),'pm');
pn=ncread(strcat(path,fn),'pn');
size(pm)
size(pn)
dxrho=1./pm;%(2:end-1,2:end-1);
dyrho=1./pn;%(2:end-1,2:end-1);
xg=cumsum(dxrho,1)-dxrho./2;
yg=cumsum(dyrho,2)-dyrho./2;

xv=cumsum(dxrho,1);
yv=cumsum(dyrho,2);

dx= nanmean(dxrho(:));

xmax=min(min(xg(end,:)),min(yg(:,end)));
width=1.5e5;
xs=width:dx:xmax-width;
ys=width:dx:xmax-width;

if mod(length(xs),2)~=0
    xs=xs(2:end);
    ys=ys(2:end);
end

[xgs,ygs]=meshgrid(xs,ys);

display('read data')
lat_rho=ncread(strcat(path,fn),'lat_rho');
lon_rho=ncread(strcat(path,fn),'lon_rho');

% no3=ncread(strcat(path,fn),'NO3'); 
z_rho=ncread(strcat(path,fn),'z_rho');
z_w=ncread(strcat(path,fn),'z_w');
z_u=ncread(strcat(path,fn),'z_u');
z_v=ncread(strcat(path,fn),'z_v');

phyt=ncread(strcat(path,fn),'phytoplankton'); 
%phyt=phyt(2:end-1,2:end-1,stzidx:end,:);
% no3=no3(2:150,198:298,stzidx:end,:);
%z_rho=z_rho(2:150,198:298,stzidx:end,:);    

% pden=ncread(strcat(path,fn),'pden'); 
% pden=pden(2:end-1,2:end-1,stzidx:end,:);

 u=ncread(strcat(path,fn),'u');
% u=0.5.*u(1:end-1,2:end-1,stzidx:end,:)+0.5.*u(2:end,2:end-1,stzidx:end,:);
v=ncread(strcat(path,fn),'v');
% v=0.5.*v(2:end-1,1:end-1,stzidx:end,:)+0.5.*v(2:end-1,2:end,stzidx:end,:);
w=ncread(strcat(path,fn),'w');
%w=0.5.*w(2:end-1,2:end-1,1:end-1,:)+0.5.*w(2:end-1,2:end-1,2:end,:);
%w=w(:,:,stzidx:end,:);
dsigma=diff(sigma_w,1,1);
dsigma=dsigma(stzidx:end);

% display('interp no3')
% no3_z=var_to_zi(no3,-z_rho,z_edge);

display('interp phyt')
phyt_z=var_to_zi(phyt,-z_rho,z_edge);

display('interp w')
w_z=var_to_zi(w,-z_w,z_edge);


display('interp u')
u_z=var_to_zi(u,-z_u,z_edge);

display('interp v')
v_z=var_to_zi(v,-z_v,z_edge);

clear u v w z_rho z_u z_v z_w phyt

[nx,ny,nz,nt1]=size(w_z) %300 300 3 37

display('calc vort strain')
size(v_z) %300 299 3 37
size(dxrho) %300 300
size(u_z) %299 300 3 37
size(dyrho) %300 300
vort=squeeze((v_z(2:end,:,:,:)-v_z(1:end-1,:,:,:))./repmat(0.5*(dxrho(2:end,2:end)+dxrho(1:end-1,1:end-1)),[1 1 nz nt1]))...
    -squeeze((u_z(:,2:end,:,:)-u_z(:,1:end-1,:,:))./repmat(0.5*(dyrho(2:end,2:end)+dyrho(1:end-1,1:end-1)),[1 1 nz nt1]));
strain=sqrt(2.*squeeze((v_z(2:end-1,2:end,:,:)-v_z(2:end-1,1:end-1,:,:)).*repmat(pm(2:end-1,2:end-1),[1 1 nz nt1])).^2 ...
    +2.*squeeze((u_z(2:end,2:end-1,:,:)-u_z(1:end-1,2:end-1,:,:)).*repmat(pn(2:end-1,2:end-1),[1 1 nz nt1])).^2);

clear u_z v_z
%save(strcat('/glade/scratch/gbrett/',fn2,'.mat'),'vort','strain','-v7.3')
%% stats
nfilters=8; hf=fspecial('average',[5 5]);
vortedge=-5e-4:1e-5:1e-3; %
strainedge=0:1e-5:5e-4; 
day=ocean_time./86400+5;
size(xg) %300 300
size(yg) %300 300
size(xv) %300 300
size(yv) %300 300
size(phyt_z) %300 300 3 37
size(vort) %299 299 3 37
size(strain) %298 298 3 37
for nt=1:nt1
    nt

   display('entering zloop')
   for zlev=zlevs 

         pnow=griddata(xg',yg',squeeze(phyt_z(:,:,zlev,nt))',xgs,ygs);
         wnow=griddata(xg',yg',squeeze(w_z(:,:,zlev,nt))',xgs,ygs);
         vortg=griddata(xv(2:end,2:end)',yv(2:end,2:end)',squeeze(vort(:,:,zlev,nt))',xgs,ygs);
         straing=griddata(xg(2:end-1,2:end-1)',yg(2:end-1,2:end-1)',squeeze(strain(:,:,zlev,nt))',xgs,ygs);

         display('filtering')
         pmeso=imfilter(pnow,hf,'replicate','same','corr');
         wmeso=imfilter(wnow,hf,'replicate','same','corr');
        for i=2:nfilters
            pmeso=imfilter(pmeso,hf,'replicate','same','corr');
            wmeso=imfilter(wmeso,hf,'replicate','same','corr');
        end
        %
         submesowp=(wnow-wmeso).*(pnow-pmeso);
         wp=wnow.*pnow;
         mesowp=wmeso.*pmeso;
    clear *meso
        display('grid vort strain')
        for i=1:length(vortedge)-1
            for j=1:length(strainedge)-1
            wanti=(vortg<=vortedge(i+1) & vortg>vortedge(i) & straing<=strainedge(j+1) & straing>strainedge(j));
            npoints(i,j,zlev,nt)=sum(wanti(:));
            if sum(wanti(:))>0
                mvort(i,j,zlev,nt)=nanmean(vortg(wanti));
                mstrain(i,j,zlev,nt)=nanmean(straing(wanti));
                mw(i,j,zlev,nt)=nanmean(wnow(wanti));
                mp(i,j,zlev,nt)=nanmean(pnow(wanti));
                mwp(i,j,zlev,nt)=nanmean(wp(wanti));
                msub(i,j,zlev,nt)=nanmean(submesowp(wanti));
                mmes(i,j,zlev,nt)=nanmean(mesowp(wanti));
            end
            end
        end
     clear *now   
   end


end

whos
clear vort strain phyt_z w_z vortg straing


%% save
whos
display('save')
%save('nprodbackup.mat','varmeans','varstds')
%varmeans.ocean_time=cat(1,varmeans.ocean_time,ocean_time(1:ntskip:end));
%varmeans.z=z_edge(zlevs);
whos

save(strcat('vs_',res,'_',filemid{fct},'_np.mat','-v7.3'))
%save('nprodbackup.mat','-v7.3')
clear spectra radialbands z_mid zlevs ocean_time
whos

out='flag out'
end
