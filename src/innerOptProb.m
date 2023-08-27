function [tStar,xStar,yStar,zStar,uStar,vStar,ft,objValue] = innerOptProb(P,b,TT) %for polygons
%                             innerOptProb(a,b,c,alpha,TT) %for ellipses

%  Discussion: This function finds the Largest Inscibed Rectangle of a given 
% direction inside a polygon (or ellipse or other convex bodies) and returns 
% its volume and its ratio to the volume of the polygon (convex body). 
%
%       This function
%
%  Last Modified:   08/25/2023
%
%  Author:      Mehdi Behroozi (m.behroozi@neu.edu)
%
%  Inputs:
%
%       convex inequalities defining the input region.
%       input region could be polygons, ellipses, intersection of ...
%           halfspaces, intersection of parabolas, ... .
%       TT contains all desired orientations of the optimal rectangle. 
%       If theta is the angle between rectangles edge and x-axis, we have
%       t=tan(theta) and TT is the vector of all desired t values.
%
%  Output:
%
%       coordinates of the corners of the optimal solution, and the objective
%       funtction.
              
ct=cputime;
%ft=zeros(90,2);
it=0;
objValue=0;

for t=TT
    it=it+1
    %requires cvx installlation (a free package)
    %any other package of convex optimization would work.
    cvx_begin quiet
        variables u(2) v(2) x(2) y(2) z(2) w(2);

        maximize( log(u(1))+log(v(2)) )
        subject to
            u(2)-t*u(1)==0;
            v(1)+t*v(2)==0;

            u==y-x;
            v==z-x;
            % % for polygons
            P*x<=b;
            P*y<=b;
            P*z<=b;
            P*(y+z-x)<=b; %It is necessary since this is not a 
                            %convex combination of other 3 vertices.

% %   For ellipses
%         w==y+z-x;
%         
%         ((x(1)-c(1))*cos(alpha)+(x(2)-c(2))*sin(alpha))^2/a^2 + ...
%             ((x(1)-c(1))*sin(alpha)-(x(2)-c(2))*cos(alpha))^2/b^2 <= 1;
%         ((y(1)-c(1))*cos(alpha)+(y(2)-c(2))*sin(alpha))^2/a^2 + ...
%             ((y(1)-c(1))*sin(alpha)-(y(2)-c(2))*cos(alpha))^2/b^2 <= 1;
%         ((z(1)-c(1))*cos(alpha)+(z(2)-c(2))*sin(alpha))^2/a^2 + ...
%             ((z(1)-c(1))*sin(alpha)-(z(2)-c(2))*cos(alpha))^2/b^2 <= 1;
%         ((w(1)-c(1))*cos(alpha)+(w(2)-c(2))*sin(alpha))^2/a^2 + ...
%             ((w(1)-c(1))*sin(alpha)-(w(2)-c(2))*cos(alpha))^2/b^2 <= 1; %It is necessary since this is not a 
%                             %convex combination of other 3 vertices.
% %For parabola
%          0.5*(x(1)-3)^2 <= x(2);
%          0.5*(y(1)-3)^2 <= y(2);
%          0.5*(z(1)-3)^2 <= z(2);
%          0.5*(w(1)-3)^2 <= w(2);
%          
% %For halfspace
%          3*x(1)+x(2) <= 21;
%          3*y(1)+y(2) <= 21;
%          3*z(1)+z(2) <= 21;
%          3*w(1)+w(2) <= 21;
%          
            
    cvx_end
%     t
%     x
%     y
%     z
%     u
%     v
     value=log(u(1))+log(v(2));
     tempObjValue=(1+t^2)*exp(value)

    ft(it,:)=[t,tempObjValue];

    %ft'

    if tempObjValue >= objValue
        objValue = tempObjValue;
        tStar=t;
        xStar=x;
        yStar=y;
        zStar=z;
        uStar=u;
        vStar=v;
    end 
   
end

% if sum(sum(isnan(ft)))==size(ft,1)
%     ft(isnan(ft))=-1;
%     tStar=ft(1,1);
%     xStar=[0 0]';
%     yStar=[0 0]';
%     zStar=[0 0]';
%     uStar=[0 0]';
%     vStar=[0 0]';
%     objValue = 0;
%     
% end

fprintf('\n The CPU time for first innerOptProb is: %f seconds',cputime-ct)
return

