%function bestfit=pso(f,numparams,numparticles,param,X0,lower,upper,tao,maxk,bestlimit,x)
%function bestfit=pso(f,numparams,numparticles,param,X0,lower,upper,tao,maxk,bestlimit,x)
%Particle Swarm Optimization
%f
%numparams
%numparticles
%param
%X0
%lower
%upper
%tao
%maxk
%bestlimit
%x

%PSO starts here
%initializing particles
particles = abs((rand(numparams,numparticles)).*repmat(params',1,numparticles)+repmat(0.5*params',1,numparticles));


%initializing best values;
%tic;
pbest = ones(1,numparticles).*inf;

param_pbest = ones(numparams,numparticles).*inf;
param_gbest = zeros(numparams,numparticles);

%for the best fit parameters

for iter = 1:numiters
gbest = inf;
for i = 1:numparticles

%    if i == 1
%	traj(:,iter) = particles(:,i)
%    end

	%traj(:,:,iter) = particles;

	%position in the time-series
	pos = 2;
	%linspace(0,TimeEnd,N)
	[tsim, xest] = ode15s(@model1, ts, X0, [], particles(:,i));

	yest = xest * [1 1 0; 0 0 1]';
    
	nan_locations = find(isnan(yest));
	yest(nan_locations) = 0;
	
	%The missing measurements are marked with -1
	yest(find(y==-1)) = -1;

	%yout = interp1(ttimes', y', x(:,1));
	%local param fit
	partfit = mymse((y - yest).*(ones(size(y))*[2 0; 0 1]./y));

	if partfit < pbest(i) && imag(partfit) == 0
	    pbest(i) = partfit;
	    param_pbest(:,i) = particles(:,i);
	    %param_pbest = repmat(particles(:,i), 1, numparticles);
	end;

	%global param fit
	if partfit < gbest && imag(partfit) == 0
	    gbest = partfit
	    param_gbest = repmat(particles(:,i), 1, numparticles);
	end;

    end;

    %condition to finish
    if gbest < bestlimit
	break;
    end

    %update particles speed
    vpart = vpart + c1 * rand(numparams,numparticles) .* (param_pbest - particles) + c2 * rand(numparams,numparticles) .* (param_gbest - particles);
    vpart(find(vpart > vpartlimit)) = vpartlimit;
    vpart(find(vpart < -vpartlimit)) = -vpartlimit;

    %update particles position
    particles = particles + vpart;
end;
%toc;
%PSO ends here

