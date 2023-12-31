# Source Codes

Here are the source codes for the paper "Largest Volume Inscribed Rectangles in Convex Sets Defined by Finite Number of Inequalities".

In some functions cvx is used. You could replace it with any other convex optimization package.

The function plygon_diamter_2d_caliper.m finds the diameter of the polygon. Function plygon_diamter_2d_brute.m provides an alternative method for doing this. The former is more efficient.

The function axisAlign.m makes the diamtere of the given shape aligned with the x-axis and returns the updated shape data.

The function polyVert2Linq takes vertices of a polygon and returns the coefficients of the linear inequalities defining the polygon.

The function innerOptProb.m solves the inner optimiation problem as described in the paper. It takes the coefficients of the convex inequalities defining the input shape and a vector of directions given in form of tangent of angle theta. It finds the optimal rectangle aligned to rotated axes for each of those angles.

<br />
<br />
The function LIR_param_f.m is the main function. This function finds the Largest Inscibed Rectangle inside a polygon (ellipse or other convex bodies) and returns its volume and its ratio to the volume of the polygon (convex body). Its axis-aligned version is presented in LIAR_param.m.

The input to this function is the shape in which we need to find the largest inscribed rectangle, an angle precision, an epsilon error as a measure of accuracy. 

For polygons the shape can be defined by an array of vertices. For ellipses the shape is defined by the coordinates of the foci points and the eccentricity of the ellipse.

The angle precision is the degree of accuracy of the optimal solution regarding the angle it makes with the x-axis.

<br />
<br />
Here is a test example:
<br />
<br />

```
Vertices=[3 0; 7 1; 8 3; 6 5; 1.5 4; 0.5 2];
epsErr=1e-5;
anglePercision=0.1;

[D,volLIR,volPercent]= LIR_param_f (Vertices,anglePercision,epsErr)
```

<br />
<br />
This will return the corners of the largest rectangle in D, it's area in volLIR, and the percentage of that the area of the input polygon in volPercent. It will also return the plot of the solution, a plot of the objective function, and a third plot that shows the results of more detailed search in the neighborhood of the optimal solution. These plots for the example above are as follows
<br />
<br />

<img width="700" alt="testExample-LIR" src="https://github.com/behroozim/2022.0239/assets/50671703/7fc3df09-b977-446a-a352-820cd7cd82db">
<img width="700" alt="testExample-ft-1" src="https://github.com/behroozim/2022.0239/assets/50671703/e313cfe2-6d75-4d39-a5f9-c3991961d8f3">
<img width="700" alt="testExample-ft-2" src="https://github.com/behroozim/2022.0239/assets/50671703/6a5ed4a0-6c61-46e5-a3cc-c149c5c2e42c">

<br />
<br />
The second example uses a data set provided in the data folder in this repository:
<br />
<br />

```
V = load('10gonExample.mat'); % from folder data
Vertices = V.Vertices;
epsErr=1e-5;
anglePercision=0.1;

[D,volLIR,volPercent]= LIR_param_f (Vertices,anglePercision,epsErr)
```

<br />
<br />
This will return
<br />
<br />

<img width="700" alt="10gonExample-MAIR" src="https://github.com/behroozim/2022.0239/assets/50671703/0a73131c-15d9-468e-9936-585ca735fe00">
<img width="700" alt="10gonExample-ft-1" src="https://github.com/behroozim/2022.0239/assets/50671703/813d5354-8080-41b1-b16b-9a2c8e357d42">
<img width="700" alt="10gonExample-ft-2" src="https://github.com/behroozim/2022.0239/assets/50671703/44450bdd-4a73-4d6f-b833-f6b232a31dc5">


<br />
<br />
In some functions cvx is used. The package is free to use and can be found here: https://github.com/cvxr/cvx .
You could also replace it with any other convex optimization package.

For more information about the functions, please read the description inside each function.
