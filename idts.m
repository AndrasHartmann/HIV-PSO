%paramest = [];
%bestest = [];
for numsim = 1:10
%load parameter guess
%addpath ../
%load initial parameter guess
%load params2
load params

%load dataset
addpath data/Liang2010/
data = load('set1.csv');

ts = data (:,1);
y = data (:,2:3);

%guess for initial states
X0 = [y(1,1)*0.8 y(1,1)*0.2 y(1,2)];

%number of particles
numparticles = 50;

%number of iterations
numiters = 50;

%defining initial particles
%particles = rand(numparams,numparticles)-0.5;
%see later
%number of parameters
numparams = 6;
%particle speed
vpart = zeros(numparams,numparticles)*0.2;
%upper limit of parameter speed
vpartlimit = 0.5;

%constants of PSO
c1 = 0.8;
c2 = 0.2;

%limit for selecting best fit
bestlimit = 0.05;

pso2;

[a, b] = min(pbest);
paramest = param_pbest(:,b)

end
