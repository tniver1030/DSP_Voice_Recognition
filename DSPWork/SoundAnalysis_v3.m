function SoundAnalysis_v3
% Displays the normalized freq spectrum of a sound in wave form
% Provides two graphs. one in the range 0-11khz, the other 0-2.5khz

n = 1;
avgX1 = 0;
avghz = 0;
taylordoesntwanttorunthis = false;
numberofsamples= 5;

for mmm=1:numberofsamples,
    
if mmm == 1,
    name = 'n10-1.wav';
end
if (mmm == 2),
    name = 'n10-2.wav';
end
if (mmm == 3),
    name = 'n10-3.wav';
end
if (mmm == 4),
    name = 'n10-4.wav';
end
if (mmm == 5),
    name = 'n10-5.wav';
end

[y,fs,NBITS]=wavread(name);
y=y(:,1); %y=y(:,1) if 2 channels
y=y'; %row vector
N=size(y,2); %number of points
%if number of points is odd, truncate one element to make it even
x=y;
if mod(N,2)==1,     %if N= odd
    x=y(1:N-1);     %x will contain even number of elements
    N=N-1;
end
TimeVector=0:1/fs:(N-1)/fs;
hz=(fs/2)*(0:N/2)/(N/2); 
X=fft(x);
absX=abs(X)';

angleX=angle(X)';
absX(N/2+2:N)=[];
angleX(N/2+2:N)=[];
absX1=absX/sqrt(sum(absX.^2)); %normalize so that total energy is 1
%figure(1)
if (mmm == 1),
    avgX1 = absX1;
    avghz = hz;
end
%plot(TimeVector,x)
%title('time domain signal');
%xlabel (' time , ( units: 1/fs second)')
%ylabel('amplitude')
%figure(n)
%plot(hz,absX1)
%title('normalized frequency spectrum for the range 0 hz to 11khz')
%xlabel('frequency in Hz')
figure(n)
plot(hz(1:5000),absX1(1:5000))
title('normalized frequency spectrum for the range 0 hz to 2.5khz')
xlabel('frequency in Hz')

avgX1 = (absX1(1:40000) + avgX1(1:40000))/2;
avghz = (hz(1:40000) + avghz(1:40000))/2;
n = n +1;


end


figure(n)
plot(avghz(1:5000),avgX1(1:5000))
title('AVG normalized frequency spectrum for the range 0 hz to 2.5khz')
xlabel('frequency in Hz')
%plot(avhhz, avgX1);
%title('normalized frequency spectrum for the range 0 hz to 11khz')
%figure(n+1);


b=1;%breakpoint
end