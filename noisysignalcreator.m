clear all
close all

out=sim('noisysignal',10);
t=out.noisysignal.time;
vi=out.noisysignal.signals.values;
data=[t vi];
csvwrite('noisysignalfile.csv',data)

fc=1e3;
RC=1/(2*pi*fc);
T=1e-5;
vo=zeros(1,length(vi));
for k=2:length(vi)
   vo(k)=(T/RC)*vi(k-1)+(1-T/RC)*vo(k-1); 
end

plot(t,vi,'r')
hold on
plot(t,vo,'k','LineWidth',2)