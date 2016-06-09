function dX = model(t,X,p)
%function dX = model(t,X,p)
%traditional HIV model see e.g.
% sensitivity2: Computes the healthy CD4+ population, infected CD4+
%   population and free virus population according to the model below
%
%   Inputs required:
%       p:          Parameter vector
%           p(1)    s:  Rate of CD4+ T cells production from precursors
%                       (cell mm^-3 day^-1)
%           p(2)    d:  Uninfected CD4+ T cells death rate (day^-1)
%           p(3)    b:  CD4+ T cells infection rate (particle^-1 mm^3 ...
%                       day^-1)
%           p(4)    miu:Infected CD4+ T cells death rate (day^-1)
%           p(5)    k:  Virus particles production rate by infected T cells
%                       (particle cell^-1 day^-1)
%           p(6)    c:  Free virus particles death rate (day^-1)
%
%       X0:         Initial conditions
%           X0(1)   T0: Healthy T cells initial count (cells mm^-3)
%           X0(2)   Ti0:Infected T cells initial count (cells mm^-3)
%           X0(3)   V0: Virus particles initial count (particles mm^-3)
%
%   Model:  Equations for X:
%           dT/dt = s-d*T-beta*T*niu
%           dTi/dt=beta*T*niu-miu*Ti
%           dniu/dt=k*Ti-c*niu

T=X(1);
Ti=X(2);
v=X(3);

s=p(1);
d=p(2);
b=p(3);
miu=p(4);
k=p(5);
c=p(6);

%First set of equations
dT = s - d*T - b*T*v;
dTi = b*T*v - miu*Ti;
dv = k*Ti - c*v;

dX = [dT;dTi;dv];

end
