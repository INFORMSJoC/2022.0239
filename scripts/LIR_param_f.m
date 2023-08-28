function [volLIR,volPercent]= LIR_param_f (Vertices,anglePercision,epsErr) %for polygons 
%         LIR_param_f (anglePercision,epsErr,x1,y1,x2,y2,e) % for elipses
          

%% Parametric approach for LIR in a convex polygon

%This function finds the Largest Inscibed Rectangle inside a polygon (or 
% ellipse or other convex bodies) and returns its volume and its ratio to 
% the volume of the polygon (convex body).
%
%
%  Last Modified:   08/26/2023
%
%  Author:      Mehdi Behroozi
%
%  Inputs:
%
%       real matrix V(n,2) of the vertices of the polygon.
%
%  Output:
%
%       The largest inscribed rectangle.
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

%epsErr=1e-5;
%anglePercision=0.1;

%Random vertices on a circle
%theta=2*pi.*rand(500,1); or % theta=linspace(0,2*pi,501)'; 
%r=4;
%Vertices=[r+r.*cos(theta), r+r.*sin(theta)];
%figure
%scatter(Vertices(:,1),Vertices(:,2),'fill');
%axis equal

%======================================================

tct=cputime; %total cpu time

n=size(Vertices,1);

%[diam,vert,diameter] = polygon_diameter_2d_brute (Vertices); % O(n^2)
%[AP,diam,vert,diameter] = polygon_diameter_2d_caliper (Vertices);
[~,diam,vert,diameter] = polygon_diameter_2d_caliper (Vertices); 
% O(n) if vertices are given in a sorted order.

V=axisAlign(Vertices,diam); % O(n)
V=Vertices;
[P,b,vol]=polyVert2Linq(V); % O(n) if vertices are given in a sorted order.


% %%%%%%%%%% For ellipses
% a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
% b = a*sqrt(1-e^2);   %e is eccentricity of ellips 0<e<1, e=0 is circle
% vol=pi*a*b;
% c=[(x1+x2)/2 (y1+y2)/2];
% alpha = atan2(y2-y1,x2-x1);
% %%%%%%%%%%%%


%theta = linspace(-pi/2,pi/2,181); 
%theta = linspace(0,89*pi/180,90);
%theta = theta(2:end-1);
theta = linspace(-pi/4,pi/4,45);
%theta = 0;


TT = tan(theta);
TTOV=[] %Tangant Theta Objective Value

 [tStar,xStar,yStar,zStar,uStar,vStar,ft,objValue]=innerOptProb(P,b,TT);
% %for ellipses
%    [tStar,xStar,yStar,zStar,uStar,vStar,ft,objValue]=innerOptProb(a,b,c,alpha,TT);


ft(isnan(ft))=-1;
    
figure
plot(ft(:,1),ft(:,2))
hold on
title('Objective function of LIR problem','fontweight','bold')
xlabel('t','fontweight','bold')
ylabel('LIR volume','fontweight','bold')
hold off
    
zoomedFT=ft;
%put a while loop here for epsilon percision
%TTOV=[tStar,objValue] %Tangant Theta Objective Value
TTOV=[TTOV; [tStar, objValue] ];
ind=true;
nPiFourth = false;
pPiFourth = false;
PiFourth = false;
star=false;
k=1; %already one level of discretization has been done!
whileIter = 0;
while ind 
    whileIter = whileIter + 1;
    [SF,I]=sort(zoomedFT(:,2),'descend');
    T=zoomedFT(:,1);
    %ST=T(I);  %sorted t
    %SFT=[ST,SF];

    %filling LMax with indices of Local Maxima
    %in the first run of while loop LMax's size would probably be 1,2 or 3.
    %in later runs its size will be high likely just 1.
    LMax=[];
    for i=I'
        if ( i == 1 ) 
            if ( zoomedFT(i,2) >= zoomedFT(i+1,2) )
                LMax=[LMax;i];
            end
        elseif ( i == size(I,1))
            if ( zoomedFT(i-1,2) <= zoomedFT(i,2) )
                LMax=[LMax;i];
            end
        else
            if ( zoomedFT(i,2) >= zoomedFT(i-1,2) ) && ...
                    ( zoomedFT(i,2) >= zoomedFT(i+1,2) )
                LMax=[LMax;i];
            end    
        end

    end %end for

    %maxFT=zoomedFT(LMax,:);  % zoomedFT for just Local Maxima
    
    %dividing the interval [t(LMax(j)-1),t(LMax(j)+1)] around the local
    %maximum point t(LMax(j))
    
    if whileIter == 1
        for m=1:size(LMax,1)
            if LMax(m)==1
                nPiFourth = true;
            elseif LMax(m)==size(T,1)
                pPiFourth = true;
            end
        end
        if nPiFourth && pPiFourth
            PiFourth = true;
        else
            LMax=LMax(LMax~=1);
            LMax=LMax(LMax~=size(T,1));
        end

        if PiFourth
            if zoomedFT(1,2) >= zoomedFT(size(T,1),2)
                %to remove the machine error effect in innerOptProb
                LMax=LMax(LMax~=size(T,1));
            else
                LMax=LMax(LMax~=1);
            end
        end
    end
    
    Neg=[];    
    for m=1:size(LMax,1)
        if zoomedFT(LMax(m),2) < 0
            Neg=[Neg,m];
        end
    end
    LMax(Neg)=[];
    
    
    if (atan(T(2))-atan(T(1)))*180/pi <= anglePercision
        p = 5;
    else 
        p = 2*floor(1/anglePercision)+1;    
        %m=5; %no anglePercision 
    end
    
    zoomedFT1=zoomedFT;
    for j=1:size(LMax,1)
        if LMax(j)==1
            newTT=tan(linspace(atan(T(LMax(j))),atan(T(LMax(j)+1)),p));
        
        elseif LMax(j)==size(T,1)
            newTT=tan(linspace(atan(T(LMax(j)-1)),atan(T(LMax(j))),p));
            
        else
            newTT=tan(linspace(atan(T(LMax(j)-1)),atan(T(LMax(j)+1)),p));
        end
        

        if p == 5
            newTT1 = newTT([2 4]);
        else
            if mod(p,2) == 0
                newTT1 = newTT(2:end-1);
            else
                newTT1 = newTT([2:floor(p/2),ceil(p/2)+1:end-1]);
            end
        end
 
        
%         [tmpt,tmpx,tmpy,tmpz,tmpu,tmpv,tmpft,tmpobjValue]= ...
%             innerOptProb(P,b,newTT1);

          [tmpt,~,~,~,~,~,tmpft,~]= innerOptProb(P,b,newTT1);
% %for ellipses
%             [tmpt,~,~,~,~,~,tmpft,~]= innerOptProb(a,b,c,alpha,newTT1);
        
        
        
        if p == 5 
            tmpft = [ zoomedFT1(find(zoomedFT1==newTT(1)),:);...
                tmpft(1,:); zoomedFT1(find( abs( zoomedFT1-newTT(3) )<= ...
                                eps(1) ),:); ...
                tmpft(2,:); zoomedFT1(find(zoomedFT1==newTT(end)),:) ];
        else
            if mod(p,2) == 0
                tmpft = [ zoomedFT1(find(zoomedFT1==newTT(1)),:); ...
                    tmpft; zoomedFT1(find(zoomedFT1==newTT(end)),:) ];
            else
                 tmpft = [ zoomedFT1(find(zoomedFT1==newTT(1)),:) ; ...
                    tmpft(1:size(tmpft,1)/2,:); ...
                    zoomedFT1(find( abs( zoomedFT1-newTT(ceil(p/2)) )<= ...
                        eps(1) ),:); ...
                    tmpft(size(tmpft,1)/2+1:end,:); ...
                    zoomedFT1(find(zoomedFT1==newTT(end)),:) ];
            end
        end
        
        tmpft(isnan(tmpft))=-1;
                      
        [tmpmax,h] = max(tmpft(:,2));
        tmpt = tmpft(h,1);
        tmpobjValue = tmpmax;
      
        
        if tmpobjValue >= (objValue-epsErr)   
            %just one LMax point will remain here
            objValue = tmpobjValue;
            tStar=tmpt;
            zoomedFT=tmpft;
            lmax = LMax(j);
%             xStar=tmpx;
%             yStar=tmpy;
%             zStar=tmpz;
%             uStar=tmpu;
%             vStar=tmpv;
        end
    end %//end for j=1:size(LMax,1)
    
    TTOV=[TTOV; [tStar, objValue] ];
    
    if abs(TTOV(end,2)-TTOV(end-1,2))<epsErr
        if abs( tStar - T(lmax) ) > eps(1/2) %tStar ~= T(lmax)
        %This condition is to avoid coincidence of a new partition with
        %an old T(lmax) accidentally
            ind=false; 
            star=true;
        end      
        if ( newTT(end)-newTT(1) ) < epsErr
            ind=false;
            star=true;
        end
    end
    
    k=k+1
    TTOV'

end %end while

[objValue,row]=max(TTOV(:,2));

[tStar,xStar,yStar,zStar,uStar,vStar,ft,objValue]=...
                                        innerOptProb(P,b,TTOV(row,1));
% %for ellipses
% [tStar,xStar,yStar,zStar,uStar,vStar,ft,objValue]=...
%                                         innerOptProb(a,b,c,alpha,TTOV(row,1));

tStar
uStar
vStar
xStar
yStar
zStar
wStar = yStar+zStar-xStar


TTOV'
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


fprintf('\n The total CPU time is: %f seconds',cputime-tct)

figure
plot(zoomedFT(:,1),zoomedFT(:,2))
hold on
title('Dug in Objective function of LIR problem','fontweight','bold')
xlabel('t','fontweight','bold')
ylabel('LIR volume','fontweight','bold')
hold off


k1=convhull(V);
center = mean(D);

figure
%scatter(Vertices(:,1),Vertices(:,2),'fill');
scatter(V(:,1),V(:,2),'fill');
hold on
plot(V(k1,1),V(k1,2),'-b');

% figure %for ellipses
% t = linspace(0,2*pi);
% X = a*cos(t);
% Y = b*sin(t);
% x = (x1+x2)/2 + X*cos(alpha) - Y*sin(alpha);
% y = (y1+y2)/2 + X*sin(alpha) + Y*cos(alpha);
% plot(x,y,'b-')
% 
% hold on
% 
% %for parabola
% x=linspace(-0.1,6.68);
% y=0.5*(x-3).^2;
% plot(x,y,'b-')
% 
% %for halfspace
% x=linspace(4.6,6.9);
% y=-3*x+21;
% plot(x,y,'b-')


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
axis equal

text(center(1)-(xmax-xmin)/size(V,1),center(2)+(ymax-ymin)/size(V,1), ...
    ['Poly. vol.' ': ' num2str(vol)])
text(center(1)-(xmax-xmin)/size(V,1),center(2)+ ...
    0.5*(ymax-ymin)/size(V,1), ...
    ['LIR vol.' ': ' num2str(volLIR) ' ' '(' num2str(volPercent) '%' ')'])
if star==true
    text(center(1)-(xmax-xmin)/size(V,1), ...
        center(2),'Hit the optimal')
end
text(xStar(1),xStar(2)+(ymax-ymin)/size(V,1), 'xStar')
text(yStar(1),yStar(2)+(ymax-ymin)/size(V,1), 'yStar')
text(zStar(1),zStar(2)+(ymax-ymin)/size(V,1), 'zStar')
text(wStar(1),wStar(2)+(ymax-ymin)/size(V,1), 'wStar')


% %for ellipses
% text(c(1),c(2), ['Poly. vol.' ': ' num2str(vol)])
% text(c(1),c(2), ['LIR vol.' ': ' num2str(volLIR) ' ' '(' num2str(volPercent) '%' ')'])
% 
% text(xStar(1),xStar(2), 'xStar')
% text(yStar(1),yStar(2), 'yStar')
% text(zStar(1),zStar(2), 'zStar')
% text(wStar(1),wStar(2), 'wStar')

hold off




end