# Description of Results 

As an example to clarify the results and figures in the paper "Largest Volume Inscribed Rectangles in Convex Sets Defined by Finite Number of Inequalities", the results of the ill-behaved 500-gon example are exaplained here. 



<br />
<br />

![500gonExample-MAIR](https://github.com/behroozim/2022.0239/assets/50671703/120261f7-5ca0-430f-8257-521e3a8bc76d)

<br />
The picture 500gonExample-ft-1 shows the objective function value for the whole range of tangent of theta. Theta is the angle of the optimal rectangel with respect to the x-axis. 
<br />

![500gonExample-ft-1](https://github.com/behroozim/2022.0239/assets/50671703/b99b9a73-3e04-407c-a9c8-b3b88a29b2d2)

<br />
You can increase the granularity of theta in the 500gonExample to see more details of this ill-behaved objective function with the same details as in the paper. In this code, the granularity is set to 39. You can increase that number and run it again.
<br />

```
theta = linspace(-pi/4,pi/4,39);
```

<br />
The picture 500gonExample-ft-2 shows the objective fucntion value for a targeted range with more precision in the neighborhood of the optimal solution.
<br />

![500gonExample-ft-2](https://github.com/behroozim/2022.0239/assets/50671703/80b3aa02-a319-47b6-a10b-1660229a1b84)


<br />
<br />
For other convex shapes please comment the polygonal commands in the LIR_param_f.m and innerOptProb.m and uncomment the commands related to that convex shape (ellipse, parabola, halfspaces, etc)

![LIR-ellipse-2](https://github.com/behroozim/2022.0239/assets/50671703/c63bdd29-a0e6-4d3f-869a-47d697c59334)
![LIR-ellipse-4](https://github.com/behroozim/2022.0239/assets/50671703/744f6d76-2793-47f9-9bbd-7cb84c728a77)


Other results from the paper are also provided. For further discussion on the results please see the paper .
