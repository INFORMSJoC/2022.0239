function [diam,vert,diameter] = polygon_diameter_2d_brute (Vertices)

%% POLYGON_DIAMETER_2D computes the diameter of a polygon in 2D.
%
%  Discussion:
%
%       This algorithm finds the distance between all pairs of vertices.
%       This gives us an O(n^2) algorithm.  
%       There is an algorithm by Shamos which can compute the ...
%       diameter using the rotating calipers in O(n), assuming that 
%       the convex hull is given.
%
%  Last Modified:   08/25/2023
%
%  Author:      Mehdi Behroozi (m.behroozi@neu.edu)
%
%  Inputs:
%
%       real matrix V(n,2) of the vertices of the polygon.
%       integer n, the number of vertices of the polygon.
%
%  Output:
%
%       the indices of the vertices of the diameter in convex hull.
%       the coordinates of the vertices of the diameter.
%       the length of the diameter.
%

ct=cputime;

n=size(Vertices,1);

K=convhull(Vertices);
I=K(1:end-1);

diameter = 0.0;
k=0;

for i = I'
    k=k+1;
    J=I(k+1:end);
    for j = J'
        tmp = sqrt ( ( Vertices(i,1) - Vertices(j,1) )^2 +  ...
            ( Vertices(i,2) - Vertices(j,2) )^2 );
        if tmp > diameter
            diameter = tmp;
            diam=[i,j]';
        end       
    end

end

if Vertices(diam(2),1) < Vertices(diam(1),1)
    diam=flip(diam);
end
if Vertices(diam(1),1) == Vertices(diam(2),1)
    if Vertices(diam(2),2) < Vertices(diam(1),2)
        diam=flip(diam);
    end
end

vert=[Vertices(diam(1),:);Vertices(diam(2),:)];


fprintf('The CPU time is: %f seconds',cputime-ct)

end
