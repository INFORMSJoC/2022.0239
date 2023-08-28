function [ P , b , vol ] = polyVert2Linq( V )

%% Description 
% polyVert2Linq converts the vertices of the polygon to the set of 
% linear inequalities determining the polygon
%   Details
%       The complexity of this algorithm is O(n), assuming that the 
%       convex hull is given.
%
%  Last Modified:   08/25/2023 
%
%  Author:      Mehdi Behroozi (m.behroozi@neu.edu)
%
%  Inputs:
%
%       real matrix V(n,2) of the vertices of the polygon.
%
%  Output:
%
%       the coefficient matrix P.
%       the right hand side vector b.
%       the area of the polygon.
%

%%
ct=cputime;
% [K,vol] = convhulln(V);
% c = mean(V(unique(K),:));
[K,vol] = convhull(V);
I=K(1:end-1);
c = mean(V(I,:));


P  = NaN(size(I,1),size(V,2));

for j=1:size(I,1)
    T(j,:)=[K(j),K(j+1)];
end

for i = 1:size(I,1)
    %-(y2-y1)*x+(x2-x1)*y=-(y2-y1)*x1+(x2-x1)*y1
    L = V(T(i,2),:)-V(T(i,1),:);
    P(i,:)=[-L(2) L(1)];
    b(i)=-L(2)*V(T(i,1),1)+L(1)*V(T(i,1),2);
    
    if P(i,:)*c' > b(i)
        P(i,:) = -P(i,:);
        b(i) = -b(i);
    end


end

b=b';

fprintf('\n The CPU time for polyVert2Linq is: %f seconds',cputime-ct)
return

