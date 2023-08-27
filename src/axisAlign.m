function [V]=axisAlign ( Vertices,diam )

%% Description
% axisAlign rotates the polygon clockwise to make its diameter aligned with
%x-axis. 
%   Details:
%       Given the vertices of the polygon and its diameter it will fix 
%       the left or bottom point of the diameter on the origin and then 
%       rotates every other vertex such that the second point of the 
%       diameter lies on the x-axis. 
%       Then it will shift everything up to make all coordinates 
%       nonnegative.
%       It will assume that diam is given in a sorted order such that
%       diam(1)<=diam(2) coordinate-wise.
%       
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
%       the indices of the two end points of the diameter of the polygon.
%
%  Output:
%
%       the new coordinates for the vertices in the same order.
%
%% rotate
ct=cputime;

K=convhull(Vertices);
I=K(1:end-1);

%assumed that diam is ordered.

% if Vertices(diam(2),1) <= Vertices(diam(1),1)
%     if Vertices(diam(1),1) == Vertices(diam(2),1)
%         if Vertices(diam(2),2) < Vertices(diam(1),2)
%             diam=flip(diam);
%         end
%     else
%         diam=flip(diam);
%     end
% end



v = Vertices(diam(2),:)' - Vertices(diam(1),:)';
for i=I'
%     dist = sqrt ( ( Vertices(i,1) - Vertices(diam(1),1) )^2 +  ...
%             ( Vertices(i,2) - Vertices(diam(1),2) )^2 );
    u = Vertices(i,:)' - Vertices(diam(1),:)';
    %theta = acos (u'*v/(norm(u)*norm(v)) );
    c1=u'*v/(norm(v));  % Scalar projection of u on v
    w = u - ((u'*v)/(v'*v))*v;  %equal to: w=u-c1*v'norm(v);
    c2=norm( w );
    z=cross([u',0]',[v',0]'); %sign(z(3)) is the negative for sign of V(i,2)
%    V(i,:)=[c1,c2*sign(w(2))]; %wrong if w(2)=0
    V(i,:)=[c1,c2*(-sign(z(3)))];
        
end

V=V(I,:);

%% shift

[minY,i]=min(V(:,2));

if minY < 0
    for i=1:size(V,1)
        V(i,2)=V(i,2)+ (-1*minY);
    end
end

%% plot
% k1=convhull(V);
% figure
% scatter(V(:,1),V(:,2),'fill');
% hold on
% plot(V(k1,1),V(k1,2),'-b');

%%
fprintf('\n The CPU time for axisAlign is: %f seconds',cputime-ct)
end