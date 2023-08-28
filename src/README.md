# Source Codes

Here are the source codes for "Largest Volume Inscribed Rectangles in Convex Sets Defined by Finite Number of Inequalities".

In some functions cvx is used. You could replace it with any other convex optimization package.

File LIR_param_f.m is the main file. This function finds the Largest Inscibed Rectangle inside a polygon (ellipse or other convex bodies) and returns its volume and its ratio to the volume of the polygon (convex body).

The input to this function is the shape in which we need to find the largest inscribed rectangle, an angle precision, an epsilon error as a measure of accuracy. 

For polygons the shape can be defined by an array of vertices. For ellipses the shape is defined by the coordinates of the foci points and the eccentricity of the ellipse.

The angle precision is the degree of accuracy of the optimal solution regarding the angle it makes with the x-axis.

An example is 

```
Vertices=[3 0; 7 1; 8 3; 6 5; 1.5 4; 0.5 2];
epsErr=1e-5;
anglePercision=0.1;

[D,volLIR,volPercent]= LIR_param_f (Vertices,anglePercision,epsErr)
```

This will return the corners of the largest rectangle in D, it's area in volLIR, and the percentage of that the area of the input polygon in volPercent. It will also return the plot of the solution, a plot of the objective function, and a third plot that shows the results of more detailed search in the neighborhood of the optimal solution.
