function [signal_corr]=BleachingFit(signal)

xax_= [1:1:length(signal)];
signal_offsetsub=signal-min(signal);
ft_ = fittype('exp2');
st_ = ([.2 -.5 .2 -0.1]);
cf_ = fit(xax_',signal_offsetsub,ft_,'Startpoint',st_);
signal_corr =signal-cf_(xax_) ;
 figure;hold;plot(signal_offsetsub,'b');plot(cf_(xax_),'r');