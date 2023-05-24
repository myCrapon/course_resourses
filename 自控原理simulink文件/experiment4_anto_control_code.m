clc%clear all command line window's content
%first question&answer
%define transfer function
num1=[0.05 1];
h1=[0.2 1];
h2=[0.1 1];
den1=conv(h1,h2);
Htf=tf(num1,den1);
%continuous-time zero-pole model
Hzpk=zpk(Htf)
%continuous-time state space model
[A,B,C,D]=tf2ss(num1,den1);
Hss=ss(A,B,C,D)
%Second question&answer
%define transfer function
num2=[1 5];
h21=[1 0];
h22=[1 1];
h23=[1 2];
den2=conv(h21,conv(h22,h23));
num3=1;
den3=[1 1];
Htf1=tf(num2,den2);
Htf2=tf(num3,den3);
%question1
Hs=series(Htf1,Htf2)
%question2
Hp=parallel(Htf1,Htf2)
%question3
Hfb1=feedback(Htf1,Htf2)
Hfb2=feedback(Htf2,Htf1)
%Third question&answer
margin(Hs);
%forth question&answer
%define transfer function
Gnum=1;
g1=[1 2];
g2=[1 2 5];
Gden=conv(g1,g2);
Gtf=tf(Gnum,Gden);
%draw root trajectory diagram
rlocus(Gtf);
[K1,p1]=rlocfind(Gtf)
%draw nyquist diagram
nyquist(Gtf);
axis([-0.1 0.15 -0.12 0.12]);
