function [outtimes,seasonalspectrum] = make_seasonal_spectra(times,yearstarti,yearendi,spectrum)
%plot_seasonal_spectra filters the input spectrum then averages over the years
%   input spectrum should be radialbandsxtime
%   returns averaged times, seasonalspectrum

nyear=length(yearstarti);
[na,~]=size(spectrum);
hw=6;
nf=2;
for j=1:na
    spec(j,:)=filter_data(spectrum(j,:),hw,nf);
end


for i=1:nyear
   timeset(i,:)=times(yearstarti(i):yearendi(i)); 
   specset(i,:,:)=spec(:,yearstarti(i):yearendi(i)); 
end

outtimes=squeeze(mean(timeset,1));
seasonalspectrum=squeeze(mean(specset,1));
end

