%Main function
function Chemistry(stepnum,rmax)
    r=[0,0];%initialising variable radius
    theta=[0,0];%initialising variable theta
    phi=[0,0]; %initialising variable phi
    [r,theta,phi]=fml(stepnum,rmax);           
    f=wavefunction(r,theta,phi);
    [coordx,coordy,coordz]=polartocartesian(r,theta,phi);
    plot(r, probdensity(f));
    yn=ispointthere(probdensity(f),stepnum);
    pointsx=yn*coordx;
    pointsy=yn*coordy;
    pointsz=yn*coordz;
    scatter3(coordx,coordy,coordz)
    hold off
end

function [x,y,z]=polartocartesian (r,theta,phi)
    z=r.*sin(theta);
    y=r.*sin(theta).*sin(phi);
    x=r.*sin(theta).*cos(phi);
end

function [r,theta,phi]=fml(stepnum,rmax)
    r1=[0:rmax/stepnum:rmax];
    theta1=[0:(2*pi)/stepnum:2*pi];
    phi1=[0:(0.5*pi)/stepnum:pi/2];
    l=1;
    while(l<=stepnum)
        n=1;
        while(n<=stepnum)
            m=1;
            while(m<=stepnum)
                r=[r,r1(n)];
                phi=[phi,phi1(l)];
                theta=[theta,theta1(m)];
                m=m+1;
            end
            n=n+1;
        end
        l=l+1;
    end
end

function f= wavefunction (r,theta,phi)
    %f= ((r).^2).*(exp(-r/(3))).*(sin(theta).^2).*cos(2*phi);
    f=(2-r).*exp(-r/2);
end

function z = probdensity(waves)
    z=waves.^2;
end

function a=ispointthere(probability,stepnum)
    n=1;
    a=zeros(stepnum);
    while (n<=stepnum);
        b=rand/10;
        if (probability(n)<b)
            a(n)=1;
        elseif (probability(n)>=b)
            a(n)=0;
        end
        n=n+1;
    end 
    a=a(:,1);
end