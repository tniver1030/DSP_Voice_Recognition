function IdentifySound_v3
global hz 

% *************************************************************************
% Uses data of frequency bands and the energy associated with each band for
% 10 different sounds, to identify a test sound
% *************************************************************************
% load the infor for the frequency bands and their energy, for ten sounds
% The data should be in a text file using Notepad,where each row contains
% three number
%change sound file name
%[y,fs,NBITS]=wavread( 'sounds/Test_One.wav');
[y,fs,NBITS]=wavread( '3.wav');
%y=y(1:88000);
y=y(:, 1)'; %row vector
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
%**********************************************************
%* read each sound, call the funciton ComputeError to compute its distance
%from the test sound, and put the errors in the array 'ErrorArray'.
%**********************************************************

i=1;
Data=importdata('Band1.txt');
f=Data(:,1:2);
E_Data=Data(:,3)';
ErrorArray(i)=ComputeError(f,E_Data,absX1);
i=i+1;
%**********************************************************
Data=importdata('Band2.txt');
f=Data(:,1:2);
E_Data=Data(:,3)';
ErrorArray(i)=ComputeError(f,E_Data,absX1);
i=i+1;
%**********************************************************
Data=importdata('Band3.txt');
f=Data(:,1:2);
E_Data=Data(:,3)';
ErrorArray(i)=ComputeError(f,E_Data,absX1);
i=i+1;
%**********************************************************
Data=importdata('Band4.txt');
f=Data(:,1:2);
E_Data=Data(:,3)';
ErrorArray(i)=ComputeError(f,E_Data,absX1);
i=i+1;
%**********************************************************
Data=importdata('Band5.txt');
f=Data(:,1:2);
E_Data=Data(:,3)';
ErrorArray(i)=ComputeError(f,E_Data,absX1);
i=i+1;
%**********************************************************
Data=importdata('Band6.txt');
f=Data(:,1:2);
E_Data=Data(:,3)';
ErrorArray(i)=ComputeError(f,E_Data,absX1);
i=i+1;
%**********************************************************
Data=importdata('Band7.txt');
f=Data(:,1:2);
E_Data=Data(:,3)';
ErrorArray(i)=ComputeError(f,E_Data,absX1);
i=i+1;
%**********************************************************
Data=importdata('Band8.txt');
f=Data(:,1:2);
E_Data=Data(:,3)';
ErrorArray(i)=ComputeError(f,E_Data,absX1);
i=i+1;
%**********************************************************
Data=importdata('Band9.txt');
f=Data(:,1:2);
E_Data=Data(:,3)';
ErrorArray(i)=ComputeError(f,E_Data,absX1);
i=i+1;
%**********************************************************
Data=importdata('Band10.txt');
f=Data(:,1:2);
E_Data=Data(:,3)';
ErrorArray(i)=ComputeError(f,E_Data,absX1);
%**********************************************************
%now find the index of the lowest error
Ind=find((ErrorArray-min(ErrorArray))==0)
%figure(1);plot(ErrorArray);
bb=1;


%** this function compares Energy vector to the energy vector of the test
%sound and returns the euclidean distance of the two vectors

function EnergyError=ComputeError(f,E_Data,absX1)
global hz
NumberOfFreqBands=size(f,1);
for i=1:NumberOfFreqBands,
    IndexRange=find( hz>f(i,1) & hz<f(i,2) );
    E(i)=sum(absX1(IndexRange).^2);
    %E(i)=sum(absX1(f(i,1):f(i,2)).^2);
end
EnergyError=sum(abs(E_Data-E));

%**********************************************************
%**********************************************************
%**********************************************************

