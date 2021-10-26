function out=save_spectra_core_np(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs)
global z
spectra.u=[];
spectra.v=[];
spectra.p=[];
spectra.n=[];
spectra.w=[];
spectra.wn=[];
spectra.wp=[];
spectra.nn=[];
spectra.pp=[];
spectra.uu=[];
spectra.vv=[];
spectra.ww=[];
spectra.wnspec=[];
spectra.wpspec=[];
spectra.nnspec=[];
spectra.ppspec=[];
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
phyt=ncread(strcat(path,fn),'phytoplankton'); 
no3=ncread(strcat(path,fn),'NO3'); 
z_rho=repmat(z,[1 1 1 size(phyt,4)]);

phyt=phyt(2:end-1,2:end-1,stzidx:end,:);
no3=no3(2:end-1,2:end-1,stzidx:end,:);
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

display('interp phyt')
phyt_z=var_to_zi(phyt,-z_rho,z_edge);
display('interp no3')
no3_z=var_to_zi(no3,-z_rho,z_edge);

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
    spectra1.p=[];
    spectra1.n=[];
    spectra1.wp=[];
    spectra1.wn=[];
    spectra1.pp=[];
    spectra1.nn=[];
    spectra1.uu=[];
    spectra1.vv=[];
    spectra1.ww=[];
    spectra1.wpspec=[];
    spectra1.wnspec=[];
    spectra1.ppspec=[];
    spectra1.nnspec=[];
    spectra1.uuspec=[];
    spectra1.vvspec=[];
    spectra1.wwspec=[];
    
    for zlev=zlevs
        
        unow=griddata(xg',yg',squeeze(u_z(:,:,zlev,nt))',xgs,ygs);
        vnow=griddata(xg',yg',squeeze(v_z(:,:,zlev,nt))',xgs,ygs);
        wnow=griddata(xg',yg',squeeze(w_z(:,:,zlev,nt))',xgs,ygs);
        pnow=griddata(xg',yg',squeeze(phyt_z(:,:,zlev,nt))',xgs,ygs);
        nnow=griddata(xg',yg',squeeze(no3_z(:,:,zlev,nt))',xgs,ygs);
        
        spectra1.u=cat(1,spectra1.u,nanmean(unow(:)));
        spectra1.v=cat(1,spectra1.v,nanmean(vnow(:)));
        spectra1.w=cat(1,spectra1.w,nanmean(wnow(:)));
        spectra1.p=cat(1,spectra1.p,nanmean(pnow(:)));
        spectra1.n=cat(1,spectra1.n,nanmean(nnow(:)));
        
        unow=(detrend(detrend(unow-nanmean(unow(:)))'))';
        vnow=(detrend(detrend(vnow-nanmean(vnow(:)))'))';
        wnow=(detrend(detrend(wnow-nanmean(wnow(:)))'))';
        pnow=(detrend(detrend(pnow-nanmean(pnow(:)))'))';
        nnow=(detrend(detrend(nnow-nanmean(nnow(:)))'))';
        
        spectra1.wp=cat(1,spectra1.wp,nanmean(wnow(:).*pnow(:)));
        spectra1.wn=cat(1,spectra1.wn,nanmean(wnow(:).*nnow(:)));
        spectra1.pp=cat(1,spectra1.pp,nanmean(pnow(:).*pnow(:)));
        spectra1.nn=cat(1,spectra1.nn,nanmean(nnow(:).*nnow(:)));
        spectra1.uu=cat(1,spectra1.uu,nanmean(unow(:).*unow(:)));
        spectra1.vv=cat(1,spectra1.vv,nanmean(vnow(:).*vnow(:)));
        spectra1.ww=cat(1,spectra1.ww,nanmean(wnow(:).*wnow(:)));
        
        dx = xgs(3,3)-xgs(3,2);
        
        [phat,wnum]=fftfun2dLES(pnow,dx);
        [nhat,wnum]=fftfun2dLES(nnow,dx);
        [uhat,wnum]=fftfun2dLES(unow,dx);
        [vhat,wnum]=fftfun2dLES(vnow,dx);
        [what,wnum]=fftfun2dLES(wnow,dx);
        clear pnow nnow unow vnow wnow
        
        wpspectrum = what.*conj(phat);
        wnspectrum = what.*conj(nhat);
        ppspectrum = phat.*conj(phat);
        nnspectrum = nhat.*conj(nhat);
        uuspectrum = uhat.*conj(uhat);
        vvspectrum = vhat.*conj(vhat);
        wwspectrum = what.*conj(what);
        
        [wpspec,radialbands]=construct_radial_spectrum(wnum,wpspectrum,dx);
        [wnspec,radialbands]=construct_radial_spectrum(wnum,wnspectrum,dx);
        [ppspec,radialbands]=construct_radial_spectrum(wnum,ppspectrum,dx);
        [nnspec,radialbands]=construct_radial_spectrum(wnum,nnspectrum,dx);
        [uuspec,radialbands]=construct_radial_spectrum(wnum,uuspectrum,dx);
        [vvspec,radialbands]=construct_radial_spectrum(wnum,vvspectrum,dx);
        [wwspec,radialbands]=construct_radial_spectrum(wnum,wwspectrum,dx);
        
        spectra1.wpspec=cat(2,spectra1.wpspec,wpspec);
        spectra1.wnspec=cat(2,spectra1.wnspec,wnspec);
        spectra1.ppspec=cat(2,spectra1.ppspec,ppspec);
        spectra1.nnspec=cat(2,spectra1.nnspec,nnspec);
        spectra1.uuspec=cat(2,spectra1.uuspec,uuspec);
        spectra1.vvspec=cat(2,spectra1.vvspec,vvspec);
        spectra1.wwspec=cat(2,spectra1.wwspec,wwspec);
        clear uuspec uuspectrum uhat
        clear vvspec vvspectrum vhat
        clear wwspec wwspectrum what
        clear ppspec ppspectrum phat
        clear nnspec nnspectrum nhat
        clear wpspec wpspectrum dx
        clear wnspec wnspectrum dx
        
    end
    
    spectra.u=cat(2,spectra.u,spectra1.u);
    spectra.v=cat(2,spectra.v,spectra1.v);
    spectra.w=cat(2,spectra.w,spectra1.w);
    spectra.p=cat(2,spectra.p,spectra1.p);
    spectra.n=cat(2,spectra.n,spectra1.n);
    
    spectra.wp=cat(2,spectra.wp,spectra1.wp);
    spectra.wn=cat(2,spectra.wn,spectra1.wn);
    spectra.pp=cat(2,spectra.pp,spectra1.pp);
    spectra.nn=cat(2,spectra.nn,spectra1.nn);
    spectra.uu=cat(2,spectra.uu,spectra1.uu);
    spectra.vv=cat(2,spectra.vv,spectra1.vv);
    spectra.ww=cat(2,spectra.ww,spectra1.ww);
    
    spectra.wpspec=cat(3,spectra.wpspec,spectra1.wpspec);
    spectra.wnspec=cat(3,spectra.wnspec,spectra1.wnspec);
    spectra.ppspec=cat(3,spectra.ppspec,spectra1.ppspec);
    spectra.nnspec=cat(3,spectra.nnspec,spectra1.nnspec);
    spectra.uuspec=cat(3,spectra.uuspec,spectra1.uuspec);
    spectra.vvspec=cat(3,spectra.vvspec,spectra1.vvspec);
    spectra.wwspec=cat(3,spectra.wwspec,spectra1.wwspec);
    clear spectra1
end
%%
spectra.ocean_time=cat(1,spectra.ocean_time,ocean_time(1:ntskip:end));
spectra.z=z_edge(zlevs);
spectra.radialbands=radialbands;
save(strcat('spectra_',res,'_',filemid{fct},'_np.mat'),'spectra')
clear spectra radialbands z_mid zlevs ocean_time
out='flag out'
end
