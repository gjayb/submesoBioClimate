function out=save_spectra_core_v3(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs)
global z
spectra.u=[];
spectra.v=[];
spectra.b=[];
spectra.w=[];
spectra.wb=[];
spectra.bb=[];
spectra.uu=[];
spectra.vv=[];
spectra.ww=[];
spectra.wbspec=[];
spectra.bbspec=[];
spectra.uuspec=[];
spectra.vvspec=[];
spectra.wwspec=[];
spectra.ocean_time=[];
fn=strcat(filestart,filemid{fct},fileend)
ocean_time=ncread(strcat(path,fn),'ocean_time');
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
pden=ncread(strcat(path,fn),'pden'); 
z_rho=repmat(z,[1 1 1 size(pden,4)]);

pden=pden(2:end-1,2:end-1,stzidx:end,:);
z_rho=z_rho(2:end-1,2:end-1,stzidx:end,:);


u=ncread(strcat(path,fn),'u');
u=0.5.*u(1:end-1,2:end-1,stzidx:end,:)+0.5.*u(2:end,2:end-1,stzidx:end,:);
v=ncread(strcat(path,fn),'v');
v=0.5.*v(2:end-1,1:end-1,stzidx:end,:)+0.5.*v(2:end-1,2:end,stzidx:end,:);
w=ncread(strcat(path,fn),'w');
w=0.5.*w(2:end-1,2:end-1,1:end-1,:)+0.5.*w(2:end-1,2:end-1,2:end,:);
w=w(:,:,stzidx:end,:);
dsigma=diff(sigma_w,1,1);
dsigma=dsigma(stzidx:end);

display('interp pden')
pden_z=var_to_zi(pden,-z_rho,z_edge);

display('interp u')
u_z=var_to_zi(u,-z_rho,z_edge);

display('interp v')
v_z=var_to_zi(v,-z_rho,z_edge);

display('interp w')
w_z=var_to_zi(w,-z_rho,z_edge);
z_mid = z_edge+0.5.*abs(z_edge(2)-z_edge(1));
%clear u v w pden z_rho 
%%
ntskip =1;
display('calc spectra')
length(ocean_time)
for nt=1:ntskip:length(ocean_time)
nt

    spectra1.u=[];
    spectra1.v=[];
    spectra1.w=[];
    spectra1.b=[];
    spectra1.wb=[];
    spectra1.bb=[];
    spectra1.uu=[];
    spectra1.vv=[];
    spectra1.ww=[];
    spectra1.wbspec=[];
    spectra1.bbspec=[];
    spectra1.uuspec=[];
    spectra1.vvspec=[];
    spectra1.wwspec=[];
    
    for zlev=zlevs
        
        unow=griddata(xg',yg',squeeze(u_z(:,:,zlev,nt))',xgs,ygs);
        vnow=griddata(xg',yg',squeeze(v_z(:,:,zlev,nt))',xgs,ygs);
        wnow=griddata(xg',yg',squeeze(w_z(:,:,zlev,nt))',xgs,ygs);
        bnow=-9.81./1026.*griddata(xg',yg',squeeze(pden_z(:,:,zlev,nt))',xgs,ygs);
        
        spectra1.u=cat(1,spectra1.u,nanmean(unow(:)));
        spectra1.v=cat(1,spectra1.v,nanmean(vnow(:)));
        spectra1.w=cat(1,spectra1.w,nanmean(wnow(:)));
        spectra1.b=cat(1,spectra1.b,nanmean(bnow(:)));
        
        unow=(detrend(detrend(unow-nanmean(unow(:)))'))';
        vnow=(detrend(detrend(vnow-nanmean(vnow(:)))'))';
        wnow=(detrend(detrend(wnow-nanmean(wnow(:)))'))';
        bnow=(detrend(detrend(bnow-nanmean(bnow(:)))'))';
        
        spectra1.wb=cat(1,spectra1.wb,nanmean(wnow(:).*bnow(:)));
        spectra1.bb=cat(1,spectra1.bb,nanmean(bnow(:).*bnow(:)));
        spectra1.uu=cat(1,spectra1.uu,nanmean(unow(:).*unow(:)));
        spectra1.vv=cat(1,spectra1.vv,nanmean(vnow(:).*vnow(:)));
        spectra1.ww=cat(1,spectra1.ww,nanmean(wnow(:).*wnow(:)));
        
        dx = xgs(3,3)-xgs(3,2);
        
        [bhat,wnum]=fftfun2dLES(bnow,dx);
        [uhat,wnum]=fftfun2dLES(unow,dx);
        [vhat,wnum]=fftfun2dLES(vnow,dx);
        [what,wnum]=fftfun2dLES(wnow,dx);
        clear bnow unow vnow wnow
        
        wbspectrum = what.*conj(bhat);
        bbspectrum = bhat.*conj(bhat);
        uuspectrum = uhat.*conj(uhat);
        vvspectrum = vhat.*conj(vhat);
        wwspectrum = what.*conj(what);
        
        [wbspec,radialbands]=construct_radial_spectrum(wnum,wbspectrum,dx);
        [bbspec,radialbands]=construct_radial_spectrum(wnum,bbspectrum,dx);
        [uuspec,radialbands]=construct_radial_spectrum(wnum,uuspectrum,dx);
        [vvspec,radialbands]=construct_radial_spectrum(wnum,vvspectrum,dx);
        [wwspec,radialbands]=construct_radial_spectrum(wnum,wwspectrum,dx);
        
        spectra1.wbspec=cat(2,spectra1.wbspec,wbspec);
        spectra1.bbspec=cat(2,spectra1.bbspec,bbspec);
        spectra1.uuspec=cat(2,spectra1.uuspec,uuspec);
        spectra1.vvspec=cat(2,spectra1.vvspec,vvspec);
        spectra1.wwspec=cat(2,spectra1.wwspec,wwspec);
        clear uuspec uuspectrum uhat
        clear vvspec vvspectrum vhat
        clear wwspec wwspectrum what
        clear bbspec bbspectrum bhat
        clear wbspec wbspectrum dx
        
    end
    
    spectra.u=cat(2,spectra.u,spectra1.u);
    spectra.v=cat(2,spectra.v,spectra1.v);
    spectra.w=cat(2,spectra.w,spectra1.w);
    spectra.b=cat(2,spectra.b,spectra1.b);
    
    spectra.wb=cat(2,spectra.wb,spectra1.wb);
    spectra.bb=cat(2,spectra.bb,spectra1.bb);
    spectra.uu=cat(2,spectra.uu,spectra1.uu);
    spectra.vv=cat(2,spectra.vv,spectra1.vv);
    spectra.ww=cat(2,spectra.ww,spectra1.ww);
    
    spectra.wbspec=cat(3,spectra.wbspec,spectra1.wbspec);
    spectra.bbspec=cat(3,spectra.bbspec,spectra1.bbspec);
    spectra.uuspec=cat(3,spectra.uuspec,spectra1.uuspec);
    spectra.vvspec=cat(3,spectra.vvspec,spectra1.vvspec);
    spectra.wwspec=cat(3,spectra.wwspec,spectra1.wwspec);
    clear spectra1
end
%%
spectra.ocean_time=cat(1,spectra.ocean_time,ocean_time(1:ntskip:end));
spectra.z=z_edge(zlevs);
spectra.radialbands=radialbands;
save(strcat('spectra_',res,'_',filemid{fct},'.mat'),'spectra')
clear spectra radialbands z_mid zlevs ocean_time
out='flag out'
end
