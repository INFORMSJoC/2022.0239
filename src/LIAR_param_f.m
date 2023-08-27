function [volLIR,volPercent]= LIAR_param_f (Vertices)

%% Parametric approach for LIAR in a convex polygon
% This function finds the Largest Inscibed Axis-aligned Rectangle inside
% a polygon (or ellipse or other convex bodies) and returns 
% its volume and its ratio to the volume of the polygon (convex body).
% It can also do the same for rotated axes by changing theta.

% Details:
%       The complexity of this algorithm is O(n) if the vertices (the 
%       convex hull) is given in a sorted order.

%
%  Last Modified:   08/25/2023
%
%  Author:      Mehdi Behroozi
%
%  Inputs:
%
%       real matrix V(n,2) of the vertices of the polygon.
%
%  Output:
%
%       The largest inscribed axis-aligned rectangle.
%

%============Examples =============================================
%V is a n x 2 matrix containing the vertices of the polygon in each row.
%Example of V are:
%V1=[0 0; 2 0; 2 1; 0 1];
%V2=[1 0; 3 0; 4 1; 2 2; 0 1];
%V3=[1 0; 7 0.5; 8 2; 6.5 5; 0.5 5; 0 3];
%V4=[0 0; 1 0; 3 2; 4 3; 1 2; 0 1];
%V5=[0 0; 1 0; 3 2; 4 4; 1 3; 0 1];
%V6=[3 0; 7 0; 8 2; 6 5; 2 5; 0 3];
%V7=[0 0; 1 0; 11 10; 11 11; 10 11; 0 1];
%V8=[0 0; 1 0; 1 1; 0 1];
%V9=[2 0; 7 0; 8 2; 6 5; 2 5; 0 3];
%V10=[3 0; 7 0; 8 2; 6 5; 2 5; 0 3];

%tilted parallelograms
%V-test-1=[ 0 0; 5.5 -0.5; 5 3; -0.5 3.5]; 
%V-test-2=[ 0 0; 5.1 -0.6; 5 3; -0.1 3.3];


%Random vertices
%b=randi(80,1,1)
%a=-randi(70,1,1)
%Vertices = a + (b-a).*rand(45,2);


%Random vertices on a circle
%theta=2*pi.*rand(500,1); or % theta=linspace(0,2*pi,501)'; 
%r=4;
%Vertices=[r+r.*cos(theta), r+r.*sin(theta)];
%figure
%scatter(Vertices(:,1),Vertices(:,2),'fill');
%axis equal

%======================================================

%% 
tct=cputime; %total cpu time

n=size(Vertices,1);

% %[diam,vert,diameter] = polygon_diameter_2d_brute (Vertices); % O(n^2)
% %[AP,diam,vert,diameter] = polygon_diameter_2d_caliper (Vertices);
[~,diam,vert,diameter] = polygon_diameter_2d_caliper (Vertices); 
    % O(n) if vertices are given in a sorted order.

V=axisAlign(Vertices,diam); % O(n)
% V=Vertices; % if we dont need the polygon itself to be axis-aligned.
[P,b,vol]=polyVert2Linq(V); % O(n) if vertices are given in a sorted order.


%theta = linspace(-pi/2,pi/2,181); 
%theta = linspace(0,89*pi/180,90);
%theta = theta(2:end-1);
%theta = linspace(-pi/4,pi/4,50);

theta = 0;
% theta = -pi/7; %It can be any direction.
TT = tan(theta);

[~,xStar,yStar,zStar,uStar,vStar,~,objValue]=innerOptProb(P,b,TT);


%tStar
uStar
vStar
xStar
yStar
zStar
wStar = yStar+zStar-xStar

vol
objValue
volLIR=abs(det([uStar,vStar]));
uv=uStar'*vStar % Shows how perpendicular are uStar and vStar.
cosAlpha=uStar'*vStar/(norm(uStar)*norm(vStar));
angleDif=acos(cosAlpha)-pi/2
%dif is the error due to approximations in computing natural log and
%other stuff.
%dif=abs(volLIR-objValue) 
volPercent=volLIR/vol*100;

D=[xStar'; yStar'; zStar'; wStar']

k1=convhull(V);
center = mean(D);

fprintf('\n The total CPU time is: %f seconds',cputime-tct)

figure
%scatter(Vertices(:,1),Vertices(:,2),'fill');
scatter(V(:,1),V(:,2),'fill');
hold on
plot(V(k1,1),V(k1,2),'-b');

k2=convhull(D);

plot(D(:,1),D(:,2),'*r');
plot(D(k2,1),D(k2,2),'-r');

title('Largest Inscribed Polygon','fontweight','bold')
xlabel('x','fontweight','bold')
ylabel('y','fontweight','bold')
xmin=min(min(V(:,1)),min(V(:,2)));
xmax=max(max(V(:,1)),max(V(:,2)));
ymin=min(min(V(:,1)),min(V(:,2)));
ymax=max(max(V(:,1)),max(V(:,2)));
axis([xmin,xmax,ymin,ymax])
axis square

text(center(1)-(xmax-xmin)/size(V,1),center(2)+(ymax-ymin)/size(V,1), ...
    ['Poly. vol.' ': ' num2str(vol)])
text(center(1)-(xmax-xmin)/size(V,1),center(2)+ ...
    0.5*(ymax-ymin)/size(V,1), ...
    ['LIR vol.' ': ' num2str(volLIR) ' ' '(' num2str(volPercent) '%' ')'])

text(xStar(1),xStar(2)+(ymax-ymin)/size(V,1), 'xStar')
text(yStar(1),yStar(2)+(ymax-ymin)/size(V,1), 'yStar')
text(zStar(1),zStar(2)+(ymax-ymin)/size(V,1), 'zStar')
text(wStar(1),wStar(2)+(ymax-ymin)/size(V,1), 'wStar')

hold off
end