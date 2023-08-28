# Script for sample replication

Here are the script and source codes needed to replicate the fat polygon of Figure 12 and the 500-gon ill-behaved example of Figure 13 in the paper "Largest Volume Inscribed Rectangles in Convex Sets Defined by Finite Number of Inequalities". A third random example of a 10-gon is also provided.

To replicate the first example make sure the following line is uncommneted and the other examples are commented:
<br />
<br />
```
%% Example1
% % this gives the fat polygon in Figure 12 of the paper.
Vertices = [0 2.60473; 3.34894 0; 7.31805 0.496139; 8.06226 2.60473; 5.7056 5.33349; 1.73649 4.83735];
```
<br />
This will give you
<br />
<img width="576" alt="LIR-new-6-9-c" src="https://github.com/behroozim/2022.0239/assets/50671703/5735e4f5-ec81-49ef-9de2-9c3159b9172d">
<img width="576" alt="ft-new-6-9-1" src="https://github.com/behroozim/2022.0239/assets/50671703/24619e98-529b-4325-94cc-7184d91f1ffd">
<img width="576" alt="ft-new-6-9-2" src="https://github.com/behroozim/2022.0239/assets/50671703/8b904bbd-a10e-45a9-b31e-acade813727e">

<br />
<br />
To replicate the first example make sure the following line is uncommneted and the other examples are commented:
<br />
<br />
```
%% Example2
% % this gives an ill-behaved function that makes the problem harder to solve.
% % the results are shown in Figure 13 of the paper.
Vertices=importdata('500gonExample.dat'); 
```
<br />
This will give you
<br />
![500gonExample-MAIR](https://github.com/behroozim/2022.0239/assets/50671703/120261f7-5ca0-430f-8257-521e3a8bc76d)
![500gonExample-ft-1](https://github.com/behroozim/2022.0239/assets/50671703/b99b9a73-3e04-407c-a9c8-b3b88a29b2d2)
![500gonExample-ft-2](https://github.com/behroozim/2022.0239/assets/50671703/80b3aa02-a319-47b6-a10b-1660229a1b84)

In some functions cvx is used. The package is free to use and can be found here: https://github.com/cvxr/cvx .
You could also replace it with any other convex optimization package.
