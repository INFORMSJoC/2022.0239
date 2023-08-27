function [AP,diam,vert,diameter] = polygon_diameter_2d_caliper (Vertices)

%*******************************************
%
%% POLYGON_DIAMETER_2D computes the diameter of a polygon in 2D.
%
%  Discussion:
% 
%       This is an algorithm by Shamos which can compute the ...
%       diameter using the rotating calipers in O(n), assuming that 
%       the convex hull is given.
%       It finds all antipodal (diametrically opposite) pairs of ...  
%       vertices in O(n) time.
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
%       the Anti-Podal pairs
%       the indices of the vertices of the diameter in convex hull.
%       the coordinates of the vertices of the diameter.
%       the length of the diameter.
%

ct=cputime;

diameter = 0.0;
diam=[];
AP=[]; %stores all antipodal pairs.
n=size(Vertices,1);

K=convhull(Vertices); %the order of vertices in K is ccw
CH=K(1:end-1);
%Finding initial antipodal pair
[ymin,i] = min(Vertices(CH,2));
[ymax,j] = max(Vertices(CH,2));
% Vertices(i,:) and Vertices(j,:) are initial antipodal pairs.
init1 = CH(i);
init2 = CH(j);
AP = [AP;CH(i),CH(j)];

%Finding all other antipodal pairs
I = [CH(i); flip( CH(1:find(CH==CH(i))-1) ); ...
            flip( CH(find(CH==CH(i))+1:end) )]; %flip makes it cw.
        
i=1;
j=find(I==CH(j));

Caliper1 = [Vertices(I(i),1)-1, Vertices(I(i),2)]'-Vertices(I(i),:)';
Caliper2 = [Vertices(I(j),1)+1, Vertices(I(j),2)]'-Vertices(I(j),:)';

if i == length(I)
    u = Vertices(I(1),:)' - Vertices(I(i),:)';
else
    u = Vertices(I(i+1),:)' - Vertices(I(i),:)';
end

if j == length(I)
    v = Vertices(I(1),:)' - Vertices(I(j),:)';
else
    v = Vertices(I(j+1),:)' - Vertices(I(j),:)';
end

while j <= length(I)

    cosTheta1=Caliper1'*u/(norm(Caliper1)*norm(u));
    angle1=acos(cosTheta1);

    cosTheta2=Caliper2'*v/(norm(Caliper2)*norm(v));
    angle2=acos(cosTheta2);

    if angle1 < angle2        
        i = i+1;    
        Caliper1 = Vertices(I(i),:)' - Vertices(I(i-1),:)';
        if i == j
            i = i;
        end
        u = Vertices(I(i+1),:)' - Vertices(I(i),:)';
        Caliper2 = -Caliper1;
        AP = [AP;I(i),I(j)];
        
    elseif angle1 > angle2        
        j = j+1;        
        if j == length(I)+1
            Caliper2 = Vertices(I(1),:)' - Vertices(I(j-1),:)';
            AP = [AP;I(i),I(1)];
        elseif j == length(I)
            Caliper2 = Vertices(I(j),:)' - Vertices(I(j-1),:)';
            v = Vertices(I(1),:)' - Vertices(I(j),:)';
            AP = [AP;I(i),I(j)];
        else
            Caliper2 = Vertices(I(j),:)' - Vertices(I(j-1),:)';
            v = Vertices(I(j+1),:)' - Vertices(I(j),:)';
            AP = [AP;I(i),I(j)];
        end
        Caliper1 = -Caliper2;
                
    elseif angle1 == angle2
        i = i+1;
        j = j+1;
        Caliper1 = Vertices(I(i),:)' - Vertices(I(i-1),:)';
        u = Vertices(I(i+1),:)' - Vertices(I(i),:)';
        if j == length(I)+1
            Caliper2 = Vertices(I(1),:)' - Vertices(I(j-1),:)';
            AP = [AP;I(i-1),I(1)];
            AP = [AP;I(i),I(j-1)];        
            AP = [AP;I(i),I(1)]; 
        elseif j == length(I)
            Caliper2 = Vertices(I(j),:)' - Vertices(I(j-1),:)';
            v = Vertices(I(1),:)' - Vertices(I(j),:)';
            AP = [AP;I(i-1),I(j)];
            AP = [AP;I(i),I(j-1)];        
            AP = [AP;I(i),I(j)]; 
        else
            Caliper2 = Vertices(I(j),:)' - Vertices(I(j-1),:)';
            v = Vertices(I(j+1),:)' - Vertices(I(j),:)';
            AP = [AP;I(i-1),I(j)];
            AP = [AP;I(i),I(j-1)];        
            AP = [AP;I(i),I(j)]; 
        end
      
    end
    
end %end while

for k=1:size(AP,1)
    i = AP(k,1);
    j = AP(k,2);
    tmp = sqrt ( ( Vertices(i,1) - Vertices(j,1) )^2 +  ...
        ( Vertices(i,2) - Vertices(j,2) )^2 );
    if tmp > diameter
        diameter = tmp;
        diam=[i,j]';
    end 
end

% order diam
if Vertices(diam(2),1) < Vertices(diam(1),1)
    diam=flip(diam);
end
if Vertices(diam(1),1) == Vertices(diam(2),1)
    if Vertices(diam(2),2) < Vertices(diam(1),2)
        diam=flip(diam);
    end
end

vert=[Vertices(diam(1),:);Vertices(diam(2),:)];

fprintf('\n The CPU time for diameter is: %f seconds',cputime-ct)

end
