
%% 
clear all
global z

res='10_4km_bipit_del250';
%res='10_4km_2100';
path=['/glade/p/univ/uhah0025/archive_roms/0011-02to0014-' res '/']
filestart='osmosis_avg';

filemid={'a'};%,'b','c','d','e','f','g','h'};

fileend='.nc';
filect=length(filemid);
%addpath /glade/u/home/dwhitt/ML_diagnostics/matlabfunctions/seawater
stct=1;
z_edge = linspace(0,300,31);
z_edge(1)=5;
z_edge2=linspace(50,1000,20);
z_edge=cat(2,z_edge,z_edge2(7:end));

stzidx=1;
zlevs=1:length(z_edge);

load /glade/scratch/gbrett/romsbipit/grid_4km
for fct=1:filect
    display('ts:')
    filemid(fct)
    out=save_ts_core_np(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs);
end

% for fct=1:filect
%     display('pset:')
%     filemid(fct)
%     out=save_pset_core_np(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs);
% end
% 
% for fct=1:filect
%     display('nprod:')
%     filemid(fct)
%     out=save_nprod_core_np(fct,filestart,filemid,fileend,path,res,z_edge,stzidx,zlevs);
% end
