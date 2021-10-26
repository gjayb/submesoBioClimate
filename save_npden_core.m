function out=save_npden_core(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs)
global z
fn=strcat(filestart,filemid{fct},fileend)
ocean_time=ncread(strcat(path,fn),'ocean_time');

% 
% display('read data')
% lat_rho=ncread(strcat(path,fn),'lat_rho');
% lon_rho=ncread(strcat(path,fn),'lon_rho');

display('read big data')
pden=ncread(strcat(path,fn),'pden'); 
no3=ncread(strcat(path,fn),'NO3'); 
pden=pden(:);
no3=no3(:);
%dsigma=diff(sigma_w,1,1);
%dsigma=dsigma(stzidx:end);

pdout=1024:0.1:1028;
pdedge=[0 pdout-1000 40];
%% make N(pden)
for i=1:length(pdedge)-1
    wanti=(pdedge(i)<pden)&(pdedge(i+1)>=pden);
    meanpden(i)=nanmean(pden(wanti));
    meanno3(i)=nanmean(no3(wanti));
end
no3out=interp1(meanpden,meanno3,pdout);
%% save
clear pden no3
save(strcat('npden_',res,'_',filemid{fct},'_np.mat'))

out='flag out'
end
