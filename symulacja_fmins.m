% clear all
% clc
% 
% horyzont = 6; %horyzont czasowy
% dT = 0.01;
% Lo = [1];
% Mo = [1 4 2];
% T = 0:dT:horyzont;
% 
% 
% 
% 
%fminsearch
clear all;
clc;
global Lo T Mo z
Lo=1;
Mo=[1 4 2];
T=0:0.01:6;

r=roots(Mo);
z=(min(-r));
%sterownik
% Ls=[k*z k]= [X(1) X(1)]
%Ms=[b 1]= [X(2) 1]

Xo=[1 1];
[X]=fminsearch('mpmin',Xo);
Ls=[X(1)*z X(1)];
Ms=[X(2) 1];
[Lc, Mc]=series(Ls, Ms, Lo, Mo);
%Lc=conv(Ls, Lo);
%Mc=conv(Ms, Mo);
[Yo]=step(Lo, Mo, T);
[Lz, Mz]=cloop(Lc, Mc, -1);
Y=step(Lz, Mz, T);
[Lu,Mu]=feedback(Ls, Ms, Lo, Mo,-1);
U=step(Lu, Mu, T);
disp(X(1));
disp(X(2));
disp(max(Y));
disp(T(Y==max(Y)));
disp(Yo(T==max(T)));
plot(T, Y,'r', T, 0.1*U, 'g');
grid on;
