1;
% Prevent Octave from thinking that this
% is a function file:
%Author: Edgar Tejada
%Contributors: Jose Zarate
%	           Vivian Yuan

%Write a Matlab function called RK4 that solve (1) using Order 2 Runge-Kutta method.

%Write a Matlab function called RK4 that solve (1) using Order 2 Runge-Kutta method.

%Consider the IVP:
	% dy/dt = -12y, 0 <= t <= 1, with IV: y(0) = 1;
syms t y
global gdb;
gdb = 0; %Debug flag
a = 0;
b = 1;
N3 = 20;
N4 = 50;
N5 = 100;
alpha = 1;

f = @(t,y) -12.*y + 0.*t; %Function must be a function of two variables, even if the t just goes to zero.
Nvec= [N3, N4, N5];
hvec= (b-a)./Nvec;
y3 = RK4(f, a, b, alpha, N3);
y4 = RK4(f, a, b, alpha, N4);
y5 = RK4(f, a, b, alpha, N5);
%yvec= [y0,y1, y2];
tvec3= a:hvec(1):b; %For ploting y3
tvec4= a:hvec(2):b; %For plotting y4
tvec5= a:hvec(3):b; %For plotting y5
%Notice, our solutions are all around pretty smooth at a cursory glance.
if(gdb|0) %Test if the lengths match.
   length(y0) 
   length(tvec0)

end
if(gdb|0) %Test if the lengths match.
	tvec3
	tvec4
	tvec5
end

figure(1);
hold on
grid on
plot(tvec3,y3,'r','Linewidth',2)
plot(tvec4,y4,'g','Linewidth',2)
plot(tvec5,y5,'b','Linewidth',2)
xlabel('t');
ylabel('RK4 estimate for y(t) with y(0) = 1');
legend('N = 20','N = 50','N = 100');
%Huh, so let's see what they look like?
%The solution does seem to be converging as N--> Inf
%Seems to converge faster than RK2, and more closely.
%Now lets find the true solution for t = 1;
%Find the actual function solution
% dy/dt = -12y
%Solve via seperable
% y(t) = c1*e^(-12t) + d
%Use IVP conditions
%y(t) = e^(-12t)
ysol1= @(t) exp(-12.*t); %%Actual solution
%Plot the three solutions against their N's



exactSolution = ysol1(b);
%The exact solution is e^(-12), which is around 10^-6.
Err3 = abs(exactSolution - y3(end));
Err4 = abs(exactSolution - y4(end));
Err5 = abs(exactSolution - y5(end));
Err1 = [Err3,Err4,Err5];
if(gdb|0)
    Err1
end
figure(2)
grid on
hold on
loglog(Nvec,Err1,'c','Linewidth',5)
xlabel('Number of Subintervals N');
ylabel('Absolute Error @ f(1,y)');

y3=transpose(y3);
y4=transpose(y4);
y5=transpose(y5);
%Holy Converging Solutions batman, although as N ->Inf, the absolute error 
%Does seem to converge, but with  mild diminishing returns. 
%Our error for N=100 is still in the same magnitude as the actual solution
%So relative error would still be attrocious.
%RK4 seems to converge even faster than RK2!

%Author: Edgar Tejada
%Contributor:             Jose Zarate
%			  Vivian Yuan
function y = RK4(f, a, b, alpha, N)
	%NOTICE: y is a vector of saved y(t) estimated
	%How about TELLING US IF 'y' STORED THE END POINT OR THE VECTOR OF GUESSES? PLEASE!?
	%Syms t %We will see if CCW actually plays nice here.
	%Syms x %x is a veriable
	%y[0]= alpha
	global gdb;
	h = (b-a)./N; %Step size
	t = a; %Initialize t[0]
	y = 1:1:N; %Generate the vector
	y(1) = alpha; %Initial value
	for (i = 2:1:(N+1)) %%Iterate, since y(1) is filled, only go to (N-1)
		K1 = h.*f(t,y(i-1));
		K2 = h.*f(t+h./2, y(i-1) + K1./2);
		K3 = h.*f(t+h./2, y(i-1) + K2./2);
		K4 = h.*f(t+h, y(i-1) + K3);
		%y = y + (K1 + 2.*K2)./6; %%Modus operandi of RK4
        y(i) = y(i-1) + (K1+2*K2+2*K3+K4)./6;
		if(gdb|0)
			fprintf("\n%d\n", y)
                end
		t = a + i.*h;
	end

end
