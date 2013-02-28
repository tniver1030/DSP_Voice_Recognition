function ComputeEnergyBands_v3
% **** this program takes as input a set of frequency bands,and a sound file associated with it
% **** , then it computes the enegy for each band and prints the results in the command window
%*******************************************************************

%enter frequency band in the following format, where f1 is the lower freq
%and f2 is the higher frequency for each band
%f=[f1 f2; f1 f2;...]
%ex: f =[50 90; 120 160; 190 250];
%change f to your data. It is recommended to have at least 10 frequency bands
f=[50	80;
80	140;
140	175;
175 210;
210	260;
400	445;
450	550;
550	650];
%change sound file name
[y,fs,NBITS]=wavread( 'n10-4');
y=y(:,1)'; %row vector
N=size(y,2); %number of points
x=y;
if mod(N,2)==1,     %if N= odd
    x=y(1:N-1);     %x will contain even number of elements
    N=N-1;
end
%TimeVector=0:1/fs:(N-1)/fs;
hz=(fs/2)*(0:N/2)/(N/2);
X=fft(x);
absX=abs(X)';

%angleX=angle(X)';
absX(N/2+2:N)=[];
%angleX(N/2+2:N)=[];
absX1=absX/sqrt(sum(absX.^2)); %normalize so that total energy is 1

NumberOfFreqBands=size(f,1);
for i=1:NumberOfFreqBands,
    IndexRange=find( hz>f(i,1) & hz<f(i,2) );
    E(i)=sum(absX1(IndexRange).^2);
    %E(i)=sum(absX1(f(i,1):f(i,2)).^2);
end
figure(1)
plot(hz,absX1)
%print energy values in command window
E
bb=1;
    