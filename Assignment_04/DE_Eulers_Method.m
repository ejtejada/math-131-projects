%Author: Edgar Tejada
%Contributor: Judith Mendoza, Roberto Bernal, Tomny Hang, Vivian Yuan 
f = @(t,y) (sin(2.*t) - 2.*t.*y)./(t.^2);
Ninterval = [10.^1,10^.2, 10.^3];
a = 1;
b = 5;
alpha = 2;
[y0, y1, y2] = euler_timestep(f,a,b,alpha,Ninteveral);
%Let's try declaring vectors like this. It grosses out my instincts, but it saves space!

figure('Euler Methods','f(t,y) = (sin(2*t) - 2t*y)/(t^2)');
plot(linspace(1,5,length(y0)),y0,'b','Linewidth',2)
hold on
grid on
plot(linspace(1,5,length(y1)),y1,'r','Linewidth',2)
plot(linspace(1,5,length(y2)),y2,'y','Linewidth',2)
xlabel('t');
ylabel('Eulers Method for f(t,y)');
legend('N = 10','N = 10^2','N = 10^3')
%solution = ode23(f,[1,5],alpha); %Thank you Vivian!
%exactSolution = deval(solution,b); %If only CCW had the symbolic library, we could grpahically compare these estimates with the exact answers!
format long
exactSolution = 0.080291661480137753412790008309088139016491861099003087;
%From Wolfram
Err0 = abs(exactSolution - y0(end));
Err1 = abs(exactSolution - y1(end));
Err2 = abs(exactSolution - y2(end));

Errinterval = [Err0,Err1,Err2];
figure('Euler Error', 'N ')
loglog(Ninterval,Errinterval,'g','Linewidth',5)
grid on
xlabel('Number of Subintervals N');
ylabel('Absolute Error at f(y,5)');

y0 = transpose(y0); %Seriously, why does CCW want a
y1 = transpose(y1); %damn column vector?
y2 = transpose(y2); %Why not tell us that is wants in such format explicitly?

% Comment on Results
% which method works best? Why?
% The 'best' solution depends on if you care about pure accuracy or the cost/benefit of cycles vs accuracy. If pure accuracy is all you care about, N=10^3 is the best, but if cycle and complexity (bang for buck) matter, N=10^2 is very good and accurate for a whole order lower of complexity.
% Which method works the worst? Why?
%The worst on all accounts is N=10; It is okay, but the graph from 1 to 5 shows it is not accurate relative to N= 10^2 or 10^3, especially for t between 1 and 3. Fewer subintervals is fast to calculate, but it will not converge as closely to the true solution for a well-posed ODE.

function y = euler_timestep(f,a,b,alpha,N)
	h = (b - a)./N;
	t = a:h:b; %Fill the t vector with all the points we are checking for y(t).
	w = zeros(size(t)); %Allocate memory for the 
	w(1) = alpha; % Initialize w
	for i = 1:1:N
		w(i+1) = w(i) + h.*f(t(i),w(i));
		% t = a + i.*h; Dont't need this redundat. See line 52
	end
	y = w;
end
