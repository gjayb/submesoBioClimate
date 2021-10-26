function [outtimes,seasonalfield] = make_seasonal_fields(times,yearstarti,yearendi,field)
%plot_seasonal_fields averages over the years
%   input spectrum should be depthxtime
%   returns year-1 times, seasonalfield

nyear=length(yearstarti);

for i=1:nyear
   timeset(i,:)=times(yearstarti(i):yearendi(i)); 
   specset(i,:,:)=field(:,yearstarti(i):yearendi(i)); 
end

outtimes=squeeze(timeset(1,:));
seasonalfield=squeeze(mean(specset,1));
end

