clc;
close all;
clear all;

%%
I = double(imread('cameraman.tif'));
subplot(2,2,1);
imshow((I),[]);

N=256;
h1=getHadamardTransform(I,N);
h1=h1/256;%% Apply SVD
[Uw,Sw,Vw] = svd(h1);

%% Embed the watermarks in

S = imread('rice.png');
S1=double(S);
[uu ss vv]=svd(S1);
subplot(2,2,2);
imshow((S1),[]);

S2 = Sw+(0.001*ss);

nll2=Uw*S2*Vw';
wd=getInvHadamardTransform(nll2,256);
subplot(2,2,3);
imshow((wd),[]);
%%
h2=getHadamardTransform(wd,N);
% h2=h2/256;%% Apply SVD
[u s v]=svd(h2);
we1=(s-Sw)/(0.001);
we=uu*we1*vv';
subplot(2,2,4);
imshow((we),[]);
