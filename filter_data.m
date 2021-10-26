function uf=filter_data(u,hw,nf)

% filter velocity
%
% hw = width of filter
% nf type of filter

if nf == 1 % Butterworth

N=4;
cutoff=hw;
Wn=2/cutoff;
[B,A]=butter(N,Wn);

uf=filtfilt(B,A,u);


elseif nf == 2 % moving average

uf=zeros(size(u));

windowSize=2*hw+1;

[uff zff]=filter(ones(1,windowSize)/windowSize,1,u);

uf(1+hw:end-hw)=uff(1+2*hw:end);

for i=1:hw
uf(i)=mean(u(1:i+hw));
uf(end-i+1)=mean(u(end-i-hw:end));
end

elseif nf == 3 % simple two point average then interpolated back to original grid

uf=zeros(size(u));

windowSize=2;

[uff zff]=filter(ones(1,windowSize)/windowSize,1,u);
uf=u;
uf(2:end-1)=0.5*(uff(2:end-1)+uff(3:end));

end
