%% Paper: "Largest Volume Inscribed Rectangles in Convex Sets Defined by Finite Number of Inequalities"

%% Sample replication of results of the ill-behaved 500-gon example presented in Figure 13

%  Last Modified:   08/27/2023
%
%  Author:      Mehdi Behroozi

clear all;

epsErr=1e-5;
anglePercision=0.1;

%this gives the fat polygon in Figure 12 of the paper.
Vertices = [0 2.60473; 3.34894 0; 7.31805 0.496139; 8.06226 2.60473; 5.7056 5.33349; 1.73649 4.83735];

%this gives an ill-behaved function that makes the problem harder to solve.
%the results are shown in Figure 13 of the paper.
%Vertices=importdata('500gonExample.dat'); 

%this gives an ordinary example
%
% V = load('10gonExample.mat');
% Vertices = V.Vertices;

%to find the maximum area inscribed axis-aligned rectangle (MAAIR)
[volLIR,volPercent]= LIR_param_f (Vertices,anglePercision,epsErr)
%
%you can decrease the granularity of theta with linspace inside the
%function to make it faster or increase the granularity to see all local
%maxima (and potentially get a better solution in other examples).
