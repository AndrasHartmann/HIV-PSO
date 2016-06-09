N = 100;
[a, b] = min(pbest)
%[tsim, y] = ode15s(@model1, linspace(0,TimeEnd,N), X0, [], params);
[tsim, ysim] = ode15s(@model1, linspace(0,ts(end),N), X0, [], param_pbest(:,b));
figure
subplot(2,1,1);
semilogy(ts,y(:,1),'.')
ylabel('T_u+T_I');
xlabel('time (days)');
set(gca,'xgrid', 'on', 'ygrid', 'on');
hold on;
semilogy(tsim,ysim(:,1)+ysim(:,2))
subplot(2,1,2);
semilogy(ts,y(:,2),'.')
hold on;
semilogy(tsim,ysim(:,3))
ylabel('V');
xlabel('time (days)');
set(gca,'xgrid', 'on', 'ygrid', 'on');
